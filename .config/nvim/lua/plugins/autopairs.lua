local gh = require('config.pack').gh

-- [[ Autopairs ]]
-- Automatically inserts the closing pair when typing `(`, `[`, `{`, `"`, `'`, ...
--
-- If the closing char is already under the cursor, typing it moves over it
-- instead of inserting a duplicate, e.g. `(expr|)` + `)` -> `(expr)|`.
vim.pack.add { gh 'windwp/nvim-autopairs' }
require('nvim-autopairs').setup {}
