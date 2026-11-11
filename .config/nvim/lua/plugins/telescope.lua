local gh = require('config.pack').gh

-- Fuzzy finder. Inside a picker: <C-/> (insert) or ? (normal) lists its keys.
local plugins = {
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
}
-- fzf-native is a C extension: only when `make` exists, otherwise telescope's Lua sorter is used.
if vim.fn.executable 'make' == 1 then table.insert(plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end
vim.pack.add(plugins)

require('telescope').setup {
  extensions = { ['ui-select'] = { require('telescope.themes').get_dropdown() } },
}
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require 'telescope.builtin'
local map = vim.keymap.set
map('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
map('n', '<leader>sg', builtin.live_grep, { desc = 'Search by grep' })
map({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = 'Search current word' })
map('n', '<leader>s/', function() builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' } end, { desc = 'Search in open files' })
map('n', '<leader>/', function() builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false }) end, { desc = 'Search in current buffer' })
map('n', '<leader>s.', builtin.oldfiles, { desc = 'Search recent files' })
map('n', '<leader><leader>', builtin.buffers, { desc = 'Open buffers' })
map('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
map('n', '<leader>sr', builtin.resume, { desc = 'Resume last search' })
map('n', '<leader>sh', builtin.help_tags, { desc = 'Search help' })
map('n', '<leader>sk', builtin.keymaps, { desc = 'Search keymaps' })
map('n', '<leader>sc', builtin.commands, { desc = 'Search commands' })
map('n', '<leader>ss', builtin.builtin, { desc = 'Search telescope pickers' })
map('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = 'Search nvim config' })
map('n', '<leader>uc', builtin.colorscheme, { desc = 'Pick colorscheme' })

-- LSP pickers (jump back with <C-o> / <C-t>)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user-telescope-lsp', { clear = true }),
  callback = function(event)
    local function bmap(keys, fn, desc) map('n', keys, fn, { buffer = event.buf, desc = 'LSP: ' .. desc }) end
    bmap('grd', builtin.lsp_definitions, 'Goto definition')
    bmap('grr', builtin.lsp_references, 'Goto references')
    bmap('gri', builtin.lsp_implementations, 'Goto implementation')
    bmap('grt', builtin.lsp_type_definitions, 'Goto type definition')
    bmap('gO', builtin.lsp_document_symbols, 'Document symbols')
    bmap('gW', builtin.lsp_dynamic_workspace_symbols, 'Workspace symbols')
  end,
})
