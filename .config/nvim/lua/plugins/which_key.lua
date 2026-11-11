local gh = require('config.pack').gh

-- Popup listing the keys that can follow what you just pressed.
vim.pack.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>s', group = 'Search', mode = { 'n', 'v' } },
    { '<leader>t', group = 'Toggle' },
    { '<leader>u', group = 'UI' },
    { 'gr', group = 'LSP' },
    { '<C-w>f', desc = 'Split & edit file under cursor' },
    { '<C-w>F', desc = 'Split & edit file and jump to line' },
    { '<C-w>gf', desc = 'Edit file under cursor in new tab' },
    { '<C-w>gF', desc = 'Edit file in new tab and jump to line' },
    { '<C-w>i', desc = 'Split & jump to declaration' },
    { '<C-w>d', desc = 'Show diagnostics under cursor' },
  },
}
