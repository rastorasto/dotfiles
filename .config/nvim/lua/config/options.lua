vim.loader.enable()

vim.g.mapleader = ' ' -- must be set before plugins load
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false

local o = vim.o
o.number = true
o.relativenumber = true
o.mouse = 'a'
o.showmode = false -- mode is shown in the statusline
vim.schedule(function() o.clipboard = 'unnamedplus' end) -- share system clipboard

o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.breakindent = true

o.undofile = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = 'yes'
o.updatetime = 250
o.timeoutlen = 300
o.splitright = true
o.splitbelow = true
o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.inccommand = 'split' -- live preview of :s
o.cursorline = true
o.scrolloff = 10
o.confirm = true
