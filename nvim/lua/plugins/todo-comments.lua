require("todo-comments").setup()

local nnoremap = require("utils.mappers").nnoremap

nnoremap {"<leader>td", "lua vim.api.nvim_command('TodoQuickFix')<CR>"}
