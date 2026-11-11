local gh = require('config.pack').gh

-- catppuccin is the default; gruvbox is here to switch to with <leader>uc.
vim.pack.add {
  { src = gh 'catppuccin/nvim', name = 'catppuccin' },
  gh 'ellisonleao/gruvbox.nvim',
  gh 'xiyaowong/transparent.nvim',
}

require('catppuccin').setup { flavour = 'mocha' }
require('gruvbox').setup {}

-- Transparent background, re-applied on every colorscheme change. Toggle: <leader>ut.
vim.g.transparent_enabled = true
require('transparent').setup {}

vim.cmd.colorscheme 'catppuccin-mocha'
