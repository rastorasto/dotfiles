local gh = require('config.pack').gh

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  { src = gh 'ThePrimeagen/harpoon', version = 'harpoon2' },
}

local harpoon = require 'harpoon'
harpoon:setup()

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon [A]dd file' })
vim.keymap.set('n', '<leader>m', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon [M]enu' })
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon menu' })

for i = 1, 4 do
  vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon file ' .. i })
end

vim.keymap.set('n', '<leader>sl', function()
  local conf = require('telescope.config').values
  local file_paths = {}
  for _, item in ipairs(harpoon:list().items) do
    table.insert(file_paths, item.value)
  end
  require('telescope.pickers').new(require('telescope.themes').get_ivy { prompt_title = 'Working List' }, {
    finder = require('telescope.finders').new_table { results = file_paths },
    previewer = conf.file_previewer {},
    sorter = conf.generic_sorter {},
  }):find()
end, { desc = '[S]earch Harpoon [L]ist' })
