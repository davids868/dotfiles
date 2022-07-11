local M = {}

-- local has = function(x)
--     return vim.fn.has(x) == 1
-- end

local bootstrap = function()
  local fn = vim.fn
  local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

  if fn.empty(fn.glob(install_path)) > 0 then
    print "Downloading packer.nvim..."
    fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
  end

  vim.cmd [[packadd packer.nvim]]
end

local config = {
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  -- max_jobs = 5,
}

M.setup = function(fn)
  bootstrap()

  local packer = require "packer"
  packer.init(config)
  return packer.startup(function(use)
    fn(use)
  end)
end

return M
