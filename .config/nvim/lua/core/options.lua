local opt = vim.opt
local g = vim.g

opt.mouse = "a"
opt.showmode = false
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.relativenumber = false -- Show line numbers
opt.number = true -- but show the actual number for the line we're on
opt.hlsearch = false
opt.hidden = true -- keep buffers hidden
opt.belloff = "all" -- turn the bell off
opt.wrap = false
opt.ignorecase = true -- ignore case when searching...
opt.incsearch = true -- makes search act like search in modern browsers
opt.inccommand = "nosplit"
opt.smartcase = true -- don't ignore if there is capital letter in the query
opt.swapfile = false
opt.backup = false
-- opt.undodir = "~/.vim/undodir"
opt.undofile = true
opt.termguicolors = true
opt.clipboard = "unnamedplus"
opt.scrolloff = 8 -- make it so there are always eight lines below my cursor
opt.autoread = true -- enables auto reading of files edited outside vim
opt.cursorline = true -- Highlight the current line
opt.synmaxcol = 150
opt.ttyfast = true
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom
opt.colorcolumn = "80"
opt.signcolumn = "yes"
-- opt.winminwidth = 5
opt.background = "dark"
opt.laststatus = 3

-- needs testing
opt.shortmess = opt.shortmess + "c" -- Don't pass messages to |ins-completion-menu|.

-- timeouts
opt.updatetime = 20
opt.ttimeout = true
opt.ttimeoutlen = 100
opt.timeoutlen = 2000

-- tabs
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

g.mapleader = " "
g.maplocalleader = ","

-- plugin globals
g.slime_target = "tmux"
-- g.gutentags_enabled= 0
g.startuptime_tries = 5
g.startuptime_exe_args = { "-u", "~/.config/nvim/startuptime.vim" }

g.mkdp_command_for_global = 1

g.python3_host_prog = "~/.asdf/installs/python/3.9.7/bin/python"

if vim.fn.isdirectory(vim.env.PWD .. "/node_modules") then
  vim.env.PATH = vim.env.PATH .. ":" .. vim.env.PWD .. "/node_modules/.bin"
end
