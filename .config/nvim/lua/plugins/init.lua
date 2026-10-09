-- ============================================================
-- SECTION 4: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================

-- [[ Installing and Configuring Plugins ]]
--
-- To install a plugin simply call `vim.pack.add` with its git url.
-- This will download the default branch of the plugin, which will usually be `main` or `master`
-- You can also have more advanced specs, which we will talk about later.
--
-- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
--
-- NOTE: the requires below are in the same order the plugins were loaded in the
-- original single-file init.lua.

require 'plugins.guess_indent'
require 'plugins.gitsigns'
require 'plugins.which_key'
require 'plugins.colorscheme'
require 'plugins.todo_comments'
require 'plugins.mini'
require 'plugins.autopairs'
require 'plugins.rust'

-- ============================================================
-- SECTION 5: SEARCH & NAVIGATION
-- ============================================================
require 'plugins.telescope'

-- ============================================================
-- SECTION 6: LSP
-- ============================================================
require 'plugins.lsp'

-- ============================================================
-- SECTION 7: FORMATTING
-- ============================================================
require 'plugins.conform'

-- ============================================================
-- SECTION 8: AUTOCOMPLETE & SNIPPETS
-- ============================================================
require 'plugins.completion'

-- ============================================================
-- SECTION 9: TREESITTER
-- ============================================================
require 'plugins.treesitter'

-- File system browser
require 'plugins.neo_tree'

require 'plugins.minuet'
