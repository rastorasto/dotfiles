-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('user-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Treesitter highlighting when a parser is available (nvim bundles c, lua,
-- markdown, vim, vimdoc, query; nix can add more). No nvim-treesitter plugin,
-- so nothing gets compiled. Falls back to regex syntax silently.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('user-treesitter', { clear = true }),
  callback = function(args) pcall(vim.treesitter.start, args.buf) end,
})
