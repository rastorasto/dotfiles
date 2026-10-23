local gh = require('config.pack').gh

-- Here is a more advanced configuration example that passes options to `gitsigns.nvim`
--
-- See `:help gitsigns` to understand what each configuration key does.
-- Adds git related signs to the gutter, as well as utilities for managing changes
vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
require('gitsigns').setup {
  signs = {
    add = { text = '+' }, ---@diagnostic disable-line: missing-fields
    change = { text = '~' }, ---@diagnostic disable-line: missing-fields
    delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
    topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
    changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
  },
  -- Minimal set of gitsigns keymaps (subset of upstream kickstart.nvim):
  --  ]c/[c jump between changes, <leader>hp preview hunk, <leader>hs stage hunk,
  --  <leader>hd diff current file. See `:help gitsigns-recommended-keymaps` for more.
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'
    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, 'Jump to next git [c]hange')
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, 'Jump to previous git [c]hange')

    -- Actions
    map('n', '<leader>hp', gitsigns.preview_hunk, 'git [p]review hunk')
    map('n', '<leader>hs', gitsigns.stage_hunk, 'git [s]tage hunk')
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, 'git [s]tage hunk')
    map('n', '<leader>hr', gitsigns.reset_hunk, 'git [r]eset hunk')
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, 'git [r]eset hunk')
    map('n', '<leader>hd', gitsigns.diffthis, 'git [d]iff against index')
    map('n', '<leader>hD', function()
      gitsigns.diffthis '~'
    end, 'git [D]iff against last commit')
  end,
}
