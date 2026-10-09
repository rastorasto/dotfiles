local gh = require("config.pack").gh

vim.pack.add { gh 'milanglacier/minuet-ai.nvim' }



require('minuet').setup {
  provider = 'openai_compatible',
  provider_options = {
    openai_compatible = {
      api_key = 'OMNIROUTE_API_KEY',            -- env var NAME, never the literal key
      end_point = 'https://omni.mnau.org/v1/chat/completions',
      -- model = 'litellm/deepseek-v4.1-flash',
      model = 'litellm/mini',
      name = 'OmniRoute',
      stream = true,
      optional = { max_tokens = 128 },
    },
  },
  context_window = 2000,
  n_completions = 1,
  throttle = 500,
  debounce = 300,
  request_timeout = 15,
  -- blink source also starts disabled (toggled together with virtualtext by
  -- <leader>tm); manual completion still works regardless.
  blink = { enable_auto_complete = false },

  -- Copilot-style inline ghost text. Without this, minuet only feeds the
  -- blink completion menu, which opens on typed characters — placing the
  -- cursor somewhere and pausing never sends a request at all.
  virtualtext = {
    auto_trigger_ft = { '*' },
    -- Alt-based keys need the terminal to pass Option as Meta (most macOS
    -- terminals don't), so these are Ctrl-based instead. All verified free
    -- in this config.
    keymap = {
      accept = '<C-j>',
      accept_line = '<C-f>',
      accept_n_lines = '<C-g>',
      dismiss = '<C-q>',
    },
  },
}

-- <leader>tm: global Minuet on/off. Minuet's own `virtualtext toggle` is
-- buffer-local (vim.b flag set per FileType), so rolling our own: flip the
-- flag on every open buffer, re-apply it to future buffers via FileType
-- (runs after minuet's own FileType autocmd since it's created later), and
-- toggle the blink source too.
-- starts disabled: <leader>tm turns Minuet on
vim.g.minuet_enabled = false

local function apply_minuet_state(enabled)
  local ignore_ft = require('minuet').config.virtualtext.auto_trigger_ignore_ft
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf)
      and (not enabled or not vim.tbl_contains(ignore_ft, vim.bo[buf].filetype))
    then
      vim.b[buf].minuet_virtual_text_auto_trigger = enabled
    end
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('minuet_toggle', { clear = true }),
  -- only force-off here; when enabled, minuet's own FileType logic applies
  callback = function(ev)
    if vim.g.minuet_enabled == false then
      vim.b[ev.buf].minuet_virtual_text_auto_trigger = false
    end
  end,
  desc = 'Apply global Minuet off state to new buffers',
})

vim.keymap.set('n', '<leader>tm', function()
  vim.g.minuet_enabled = not vim.g.minuet_enabled
  apply_minuet_state(vim.g.minuet_enabled)
  vim.cmd('Minuet blink ' .. (vim.g.minuet_enabled and 'enable' or 'disable'))
  if not vim.g.minuet_enabled then
    require('minuet.virtualtext').action.dismiss() -- clear any visible ghost text
  end
  vim.notify('Minuet ' .. (vim.g.minuet_enabled and 'enabled' or 'disabled'))
end, { desc = 'Toggle Minuet completions' })
