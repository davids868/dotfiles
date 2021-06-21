local nnoremap = require("utils.mappers").nnoremap
local g = vim.g
local cmd = vim.cmd

g.neoformat_enabled_ruby = {"rubocop"}
g.neoformat_enabled_yaml = {"prettier"}
g.neoformat_enabled_python = {"black"}

nnoremap {"<leader>L", ":Neoformat<CR>"}

cmd(
    [[
augroup fmt
  autocmd!
  let blacklist = ['ruby', 'yml', 'yaml']
  autocmd BufWritePre * if index(blacklist, &ft) < 0 | Neoformat
augroup END
]]
)
