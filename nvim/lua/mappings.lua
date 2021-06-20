local nnoremap = require("utils.mappers").nnoremap

nnoremap {"<leader>td", "vim.api.nvim_command('TodoQuickFix')"}
