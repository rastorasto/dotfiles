local gh = require('config.pack').gh

-- For example, lets say we want to install `guess-indent.nvim` - a plugin for
-- automatically detecting and setting the indentation.
--
-- We first install it from https://github.com/NMAC427/guess-indent.nvim
-- and then call its `setup()` function to start it with default settings.
vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
-- Keep the plugin's default excludes (netrw, tutor) and add 'c': C files use
-- the fixed 4-space settings in after/ftplugin/c.lua instead of guessing.
require('guess-indent').setup {
  filetype_exclude = { 'netrw', 'tutor', 'c' },
}
