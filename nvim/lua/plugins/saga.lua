local saga = require("lspsaga")

local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>i", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F2>", "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
vim.api.nvim_set_keymap("v", "<leader>a", "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>dp", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>dn", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)

vim.api.nvim_set_keymap("n", "gp", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", opts)

saga.init_lsp_saga()
