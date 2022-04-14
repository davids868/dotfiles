function _G.new_tab()
  local ft = vim.bo.filetype
  vim.api.nvim_command ":tabnew"
  vim.api.nvim_buf_set_option(0, "filetype", ft)
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
