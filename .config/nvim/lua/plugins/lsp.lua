local gh = require('config.pack').gh

-- LSP servers come from PATH (brew on macOS, nix on NixOS) -- no Mason.
-- A server whose binary is missing is simply skipped, so the same config
-- works on every machine.
vim.pack.add {
  gh 'neovim/nvim-lspconfig', -- default configs (cmd, filetypes, root markers)
  gh 'j-hui/fidget.nvim', -- LSP progress messages in the corner
}
require('fidget').setup {}

---@type table<string, vim.lsp.Config>
local servers = {
  clangd = {},
  pyright = {},
  rust_analyzer = {},
  stylua = {}, -- formats Lua
  nixd = {
    settings = { nixd = { formatting = { command = { 'nixfmt' } } } },
  },
  lua_ls = {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false -- stylua formats
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
      end
      -- Editing the nvim config: teach lua_ls about the `vim` API.
      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = { version = 'LuaJIT', path = { 'lua/?.lua', 'lua/?/init.lua' } },
        workspace = {
          checkThirdParty = false,
          library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), { '${3rd}/luv/library' }),
        },
      })
    end,
    settings = { Lua = { format = { enable = false } } },
  },
}

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  local cmd = vim.lsp.config[name].cmd
  if type(cmd) == 'table' and vim.fn.executable(cmd[1]) == 1 then vim.lsp.enable(name) end
end

-- Buffer-local keymaps once a server attaches. Neovim already provides
-- grn (rename), gra (code action), grr, gri, K (hover) by default;
-- telescope.lua overrides a few of them with pickers.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc }) end

    map('grD', vim.lsp.buf.declaration, 'Goto declaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- Highlight other uses of the word under the cursor after a short pause.
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local group = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, { buffer = event.buf, group = group, callback = vim.lsp.buf.document_highlight })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, { buffer = event.buf, group = group, callback = vim.lsp.buf.clear_references })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'user-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, 'Toggle inlay hints')
    end
  end,
})

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = 'Format buffer' })
