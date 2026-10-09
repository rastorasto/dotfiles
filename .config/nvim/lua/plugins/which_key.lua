local gh = require('config.pack').gh

-- Useful plugin to show you pending keybinds.
vim.pack.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
  -- Delay between pressing a key and opening which-key (milliseconds)
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  -- Document existing key chains
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>u', group = '[U]I' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
    -- Built-in <C-w> file commands the default which-key window preset omits
    { '<C-w>f', desc = 'Split & edit file under cursor', mode = { 'n' } },
    { '<C-w>F', desc = 'Split & edit file and jump to line', mode = { 'n' } },
    { '<C-w>gf', desc = 'Edit file under cursor in new tab', mode = { 'n' } },
    { '<C-w>gF', desc = 'Edit file in new tab and jump to line', mode = { 'n' } },
    { '<C-w>i', desc = 'Split & jump to declaration', mode = { 'n' } },
    { '<C-w>d', desc = 'Split & jump to definition', mode = { 'n' } },
  },
}
