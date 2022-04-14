local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local function nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		vim.api.nvim_command("augroup " .. group_name)
		vim.api.nvim_command("autocmd!")
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.api.nvim_command(command)
		end
		vim.api.nvim_command("augroup END")
	end
end

local function load_autocmds()
	local definitions = {
		wins = {
			-- Check if file changed when its window is focus, more eager than 'autoread'
			{ "FocusGained", "* checktime" },
			-- Last active tab
			{
				"TabLeave",
				"* let g:lasttab = tabpagenr()",
			},
			-- active window cursorline
			{ "WinEnter,BufEnter,InsertLeave", "*", "setlocal cursorline" },
			{ "WinLeave,BufLeave,InsertEnter", "*", "setlocal nocursorline" },
		},
		ft = {
			{ "BufNewFile,BufRead", "*.toml", " setf toml" },
			{ "BufNewFile,BufRead", "*.mypy-testing", " setf python" },
			{ "BufNewFile,BufRead", "Dockerfile.local", " setf dockerfile" },
		},
		yank = {
			{ "TextYankPost", [[* silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=250})]] },
		},
		search = {
			{ "CmdlineEnter", "/,\\? :set hlsearch" },
			{ "CmdlineLeave", "/,\\? :set nohlsearch" },
		},
		q_close = {
			{
				"FileType",
				"help,startuptime,qf,lspinfo",
				"nnoremap <buffer><silent> q :close<CR>",
			},
			{
				"FileType",
				"man",
				"nnoremap <buffer><silent> q :quit<CR>",
			},
		},
	}

	nvim_create_augroups(definitions)
end

load_autocmds()
