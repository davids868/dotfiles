local g = vim.g
local cmd = vim.cmd

g.firenvim_config = {
  globalSettings = {
    alt = "all",
  },
  localSettings = {
    [".*"] = {
      cmdline = "neovim",
      priority = 0,
      selector = "textarea",
      takeover = "never",
    },
  },
}

cmd [[
au BufEnter github* set filetype=markdown
if exists('g:started_by_firenvim')
  set laststatus=0
  set showtabline=0
  set signcolumn=no
  set nonumber
  set winbar=""
endif
]]
