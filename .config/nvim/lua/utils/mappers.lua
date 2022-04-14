local M = {}

M.nnoremap = function(t)
  vim.keymap.set("n", t[1], t[2], t[3])
end

M.inoremap = function(t)
  vim.keymap.set("i", t[1], t[2], t[3])
end

M.vnoremap = function(t)
  vim.keymap.set("v", t[1], t[2], t[3])
end

M.xnoremap = function(t)
  vim.keymap.set("x", t[1], t[2], t[3])
end

M.cnoremap = function(t)
  vim.keymap.set("c", t[1], t[2], t[3])
end

M.map = function(t)
  vim.keymap.set("", t[1], t[2], { silent = true })
end

TelescopeMapArgs = TelescopeMapArgs or {}

M.telemap = function(mode, key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local rhs = string.format("<cmd>lua require('config.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  if not buffer then
    vim.keymap.set(mode, key, rhs)
  else
    vim.keymap.set(mode, key, rhs, { silent = true, buffer = 0 })
  end
end

return M
