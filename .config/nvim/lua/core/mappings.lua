local nnoremap = require("utils.mappers").nnoremap
local vnoremap = require("utils.mappers").vnoremap
local inoremap = require("utils.mappers").inoremap
local xnoremap = require("utils.mappers").xnoremap
local cnoremap = require("utils.mappers").cnoremap
local map = require("utils.mappers").map

-- scroll
nnoremap {"<C-d>", "20j"}
nnoremap {"<C-u>", "20k"}

-- Tab actions
nnoremap {"<leader>tn", ":tabnew<CR>"}
nnoremap {"<leader>tq", ":tabclose<CR>"}

-- visual search
vnoremap {"/", "y/<C-R>0"}

-- Better Esc mappings
-- inoremap {"jk", "<Esc>"}
-- inoremap {"kj", "<Esc>"}
-- map {"<C-c>", "<Esc>"}

-- Yanks
nnoremap {"Y", "y$"}
nnoremap {"<leader>Y", "ggyG<C-o>"}

-- Move code blocks
vnoremap {"K", ":m '<-2gv<CR>gv"}
vnoremap {"J", ":m '>+1gv<CR>gv"}

-- Better clipboard, adds m for move
nnoremap {"gm", "m"}
nnoremap {"m", "d"}
xnoremap {"m", "d"}
nnoremap {"mm", "dd"}
nnoremap {"M", "D"}
vnoremap {"p", '"_dP'}
vnoremap {"P", '"_dp'}

-- vim basics
map {"Q", "q"}
nnoremap {"<leader>q", ":q<CR>"}
nnoremap {"<leader>Q", ":qa<CR>"}
nnoremap {"<C-s>", ":w<CR>"}
inoremap {"<C-s>", "<Esc>:w<CR>"}
nnoremap {"<leader>W", ":noa w<CR>"}
nnoremap {"<leader>e", ":e!<CR>"}

-- Window resize
nnoremap {"<M-j>", ":resize -2<CR>"}
nnoremap {"<M-k>", ":resize +2<CR>"}
nnoremap {"<M-h>", ":vertical resize -10<CR>"}
nnoremap {"<M-l>", ":vertical resize +10<CR>"}

-- Increase/Decrease
nnoremap {"+", "<C-a>"}
nnoremap {"-", "<C-x>"}

-- Better indentation
vnoremap {"<", "<gv"}
vnoremap {">", ">gv"}
nnoremap {"<", "<<"}
nnoremap {">", ">>"}

-- Better incsearch
cnoremap {"<c-j>", "<c-g>"}
cnoremap {"<c-k>", "<c-t>"}

-- navigating command mode
cnoremap {"<c-h>", "<left>"}
cnoremap {"<c-l>", "<right>"}

-- resource
nnoremap {"<Leader>rs", ":source %<CR>"}
nnoremap {"<Leader>rl", ":luafile %<CR>"}
nnoremap {"<Leader>rc", ":PackerCompile<CR>"}

-- run last used macro on selected lines
vnoremap {"@@", ":normal @@<CR>"}

-- Go to tab by number
nnoremap {"<leader>1", "1gt"}
nnoremap {"<leader>2", "2gt"}
nnoremap {"<leader>3", "3gt"}
nnoremap {"<leader>4", "4gt"}
nnoremap {"<leader>5", "5gt"}
nnoremap {"<leader>6", "6gt"}
nnoremap {"<leader>7", "7gt"}
nnoremap {"<leader>8", "8gt"}
nnoremap {"<leader>9", "9gt"}

-- Go to last active tab
nnoremap {"<leader><tab>", ":exe 'tabn '.g:lasttab<cr>"}
vnoremap {"<leader><tab>", "<esc>:exe 'tabn '.g:lasttab<cr>"}
