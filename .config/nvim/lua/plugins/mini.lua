local gh = require('config.pack').gh

-- Only the statusline from mini.nvim (mode | file | diagnostics | line:col).
vim.pack.add { gh 'nvim-mini/mini.nvim' }
local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end
