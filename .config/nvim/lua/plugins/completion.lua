local gh = require('config.pack').gh

-- Completion popup. <C-y> accept, <C-n>/<C-p> move, <C-e> close, <C-k> signature.
-- LSP snippets are expanded by Neovim's built-in vim.snippet (no LuaSnip).
vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
require('blink.cmp').setup {
  keymap = {
    preset = 'default',
    ['<C-space>'] = false,
    ['<C-l>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
  },
  appearance = { nerd_font_variant = 'mono' },
  completion = { documentation = { auto_show = true, auto_show_delay_ms = 500 } },
  sources = { default = { 'lsp', 'path', 'snippets' } },
  fuzzy = { implementation = 'lua' }, -- no prebuilt binary download (NixOS-safe)
  signature = { enabled = true },
}
