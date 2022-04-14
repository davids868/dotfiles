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

cmd([[
au BufEnter gitlab* set filetype=markdown
if exists('g:started_by_firenvim')
  set laststatus=0
  set showtabline=1
endif
]])
