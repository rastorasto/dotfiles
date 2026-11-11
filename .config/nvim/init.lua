-- Entry point. Settings live in lua/config/, one file per plugin in lua/plugins/.
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.pack'
require 'plugins'

-- vim: ts=2 sts=2 sw=2 et
