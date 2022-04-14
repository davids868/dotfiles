if not pcall(require, "telescope") then
	return
end

local actions = require("telescope.actions")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")

local builtin = require("telescope.builtin")

local dropdown = themes.get_dropdown({
	winblend = 10,
	border = true,
	previewer = false,
	shorten_path = false,
	layout_config = { width = 0.5 },
})

require("telescope").setup({
	defaults = {
		prompt_prefix = "   ",
		selection_caret = "❯ ",
		winblend = 10,
		layout_strategy = "horizontal",
		layout_config = {
			prompt_position = "top",
			-- preview_cutoff = 120,
			horizontal = {
				width_padding = 0.1,
				height_padding = 0.1,
				preview_width = 0.6,
			},
			vertical = {
				width_padding = 0.05,
				height_padding = 1,
				preview_height = 0.5,
			},
		},
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		scroll_strategy = "cycle",
		color_devicons = true,
		dynamic_preview_title = true,
		mappings = {
			i = {
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
			},
			n = {
				["<Space>q"] = actions.close,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			-- "--glob='!.git/*'"
		},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		file_sorter = sorters.get_fzy_sorter,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		fzf_writer = {
			use_highlighter = false,
			minimum_grep_characters = 6,
		},
	},
})

-- Load the fzy native extension at the start.
pcall(require("telescope").load_extension, "fzy_native")
pcall(require("telescope").load_extension, "gh")
pcall(require("telescope").load_extension, "cheat")
pcall(require("telescope").load_extension, "dap")
pcall(require("telescope").load_extension, "arecibo")

-- require("telescope").load_extension("fzf")

local M = {}

function M.edit_neovim()
	builtin.find_files({
		prompt_title = "~ dotfiles ~",
		shorten_path = false,
		cwd = "~/.config/nvim",
		layout_strategy = "horizontal",
		layout_config = {
			preview_width = 0.65,
		},
	})
end

function M.find_nvim_source()
	builtin.find_files({
		prompt_title = "~ nvim ~",
		shorten_path = false,
		cwd = "~/build/neovim/",
		width = 0.25,
		layout_strategy = "horizontal",
		layout_config = {
			preview_width = 0.65,
		},
	})
end

function M.edit_zsh()
	builtin.find_files({
		shorten_path = false,
		cwd = "~/.config/zsh/",
		prompt = "~ dotfiles ~",
		hidden = true,
		layout_strategy = "horizontal",
		layout_config = {
			preview_width = 0.55,
		},
	})
end

function M.builtin()
	builtin.builtin(dropdown)
end

function M.find_files()
	builtin.find_files({ no_ignore = true })
end

function M.git_files()
	local ok = pcall(require("telescope.builtin").git_files, dropdown)
	if not ok then
		require("telescope.builtin").find_files()
	end
end

function M.live_grep()
	builtin.live_grep({
		file_ignore_patterns = { ".git/*" },
	})
end

function M.grep_prompt()
	builtin.grep_string({
		shorten_path = true,
		search = vim.fn.input("Grep String > "),
	})
end

function M.grep_visual_selection(opts)
	opts = opts or {}

	-- vim.cmd([[ norm! gv"fy ]])
	-- local register = vim.fn.getreg("f")
	-- dump(register)

	local start = vim.fn.getpos("'<")
	local finish = vim.fn.getpos("'>")

	dump({ start, finish })

	opts.shorten_path = true
	-- opts.word_match = "-w"
	-- opts.search = register
	opts.layout_strategy = "vertical"

	builtin.grep_string(opts)
end

function M.grep_last_search(opts)
	opts = opts or {}

	-- \<getreg\>\C
	-- -> Subs out the search things
	local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

	opts.path_display = "shorten"
	-- opts.word_match = "-w"
	opts.search = register
	opts.layout_strategy = "vertical"

	builtin.grep_string(opts)
end

function M.my_plugins()
	builtin.find_files({
		cwd = "~/plugins/",
	})
end

function M.installed_plugins()
	builtin.find_files({
		cwd = vim.fn.stdpath("data") .. "/site/pack/packer/start/",
	})
end

function M.project_search()
	builtin.find_files({
		previewer = false,
		layout_strategy = "vertical",
		cwd = require("lspconfig/util").root_pattern(".git")(vim.fn.expand("%:p")),
	})
end

function M.buffers()
	builtin.buffers({
		shorten_path = false,
	})
end

function M.buffer_lines()
	builtin.current_buffer_fuzzy_find()
end

function M.help_tags()
	builtin.help_tags({
		show_version = true,
	})
end

function M.file_browser()
	builtin.file_browser({
		sorting_strategy = "ascending",
		scroll_strategy = "cycle",
		prompt_position = "top",
	})
end

function M.lsp_dynamic_workspace_symbols()
	builtin.lsp_dynamic_workspace_symbols({
		file_ignore_patterns = { "node_modules/.*" },
	})
end

function M.lsp_document_symbols()
	builtin.lsp_document_symbols()
end

for k, v in pairs(M) do
	if builtin[k] == nil then
		builtin[k] = v
	end
end

return setmetatable({}, {
	__index = function(_, k)
		if M[k] then
			return M[k]
		else
			return builtin[k]
		end
	end,
})
