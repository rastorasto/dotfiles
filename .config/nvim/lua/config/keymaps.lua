local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
map('n', '<leader>e', vim.cmd.Ex, { desc = 'File explorer (netrw)' })
map('n', '<leader>cd', '<cmd>cd %:h<CR>', { desc = 'cd to current file dir' })
map('n', '<leader>ut', '<cmd>TransparentToggle<CR>', { desc = 'Toggle transparency' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Windows: <C-hjkl> to move between splits
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Window left' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Window right' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Window down' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Window up' })
map('n', '<C-w>a', '<Cmd>leftabove vertical sfind <cfile><CR>', { desc = 'Split left & edit file under cursor' })

-- Diagnostics: [d / ]d jump (and open the float), <leader>q list them
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = true,
  jump = {
    on_jump = function(_, bufnr) vim.diagnostic.open_float { bufnr = bufnr, scope = 'cursor', focus = false } end,
  },
}
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics list' })
