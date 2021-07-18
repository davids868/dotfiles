local nnoremap = require("utils.mappers").nnoremap
local vnoremap = require("utils.mappers").vnoremap
local g = vim.g

g.fugitive_gitlab_domains = {"https://gitlab.eu-west-1.mgmt.onfido.xyz/"}

nnoremap {"<leader>ge", ":GBrowse<CR>"}
nnoremap {"<leader>gy", ":GBrowse!<CR>"}
vnoremap {"<leader>ge", ":'<,'>GBrowse<CR>"}
vnoremap {"<leader>gy", ":'<,'>GBrowse!<CR>"}
nnoremap {"<leader>dm", ":Gvdiffsplit origin/master<CR>"}
nnoremap {"<leader>dv", ":DiffviewToggle<CR>"}
nnoremap {"<leader>dl", ":diffget //3<CR>"}
nnoremap {"<leader>dh", ":diffget //2<CR>"}
nnoremap {"<leader>gs", ":tab G<CR>"}
nnoremap {"<leader>gb", ":Git blame<CR>"}
-- nnoremap{"<leader>gl",":Git pull<CR>"}
-- nnoremap{"<leader>gpp",":Git push"}
-- nnoremap{"<leader>gpf",":Git push -f"}
-- nnoremap{"<leader>gpu",":Git push -u origin HEAD"}
nnoremap {"<leader>gc", ":GV<CR>"}
nnoremap {"<leader>dv", ":DiffviewOpen<CR>"}
nnoremap {"<leader>lg", ":LazyGit<CR>"}
