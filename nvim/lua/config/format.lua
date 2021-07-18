local g = vim.g
local cmd = vim.cmd

local only_prettier = {"javacript", "javascriptreact", "typescript", "typescriptreact", "yaml"}

for _, value in ipairs(only_prettier) do
    g["neoformat_enabled_" .. value] = {"prettier"}
end

g.neoformat_enabled_ruby = {"rubocop"}
g.neoformat_enabled_python = {"black"}

cmd(
    [[
augroup fmt
  autocmd!
  let blacklist = ['ruby', 'yml', 'yaml']
  autocmd BufWritePre * if index(blacklist, &ft) < 0 | Neoformat
augroup END
]]
)
