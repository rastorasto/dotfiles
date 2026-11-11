-- vim.pack (built-in plugin manager) helpers.
--   :lua vim.pack.update()        update plugins (then commit nvim-pack-lock.json)
--   :lua vim.pack.del { 'name' }  remove a plugin from disk + lockfile

-- Build steps after install/update. Each one is skipped if its tool is missing.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      local result = vim.system({ 'make' }, { cwd = ev.data.path }):wait()
      if result.code ~= 0 then vim.notify('Build failed for ' .. name .. ':\n' .. (result.stderr or ''), vim.log.levels.ERROR) end
    end
  end,
})

---@param repo string
local function gh(repo) return 'https://github.com/' .. repo end

return { gh = gh }
