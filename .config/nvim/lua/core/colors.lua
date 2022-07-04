vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

vim.cmd "highlight WinSeparator guibg=None guifg=#54546D"

if pcall(require, "kanagawa") then
  require("kanagawa").setup {
    globalStatus = true,
  }

  vim.cmd "colorscheme kanagawa"
end
