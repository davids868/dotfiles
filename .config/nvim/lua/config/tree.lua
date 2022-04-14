local M = {}

M.config = function()
	local tree_cb = require("nvim-tree.config").nvim_tree_callback

	require("nvim-tree").setup({
		disable_netrw = false,
		hijack_netrw = true,
		update_to_buf_dir = { enable = false },
		update_focused_file = {
			enable = true,
		},
		view = {
			width = 35,
			mappings = {
				list = {
					{ key = "l", cb = tree_cb("edit") },
					{ key = "h", cb = tree_cb("close_node") },
					{ key = "o", cb = ":lua NvimTreeOSOpen()<CR>" },
				},
			},
		},
		git = {
			enable = true,
			ignore = false,
			timeout = 500,
		},
	})

	function NvimTreeOSOpen()
		local lib = require("nvim-tree.lib")
		local node = lib.get_node_at_cursor()
		dump(node.absolute_path)
		if node then
			vim.fn.jobstart("open '" .. node.absolute_path .. "' &", { detach = true })
		end
	end

	vim.g.nvim_tree_bindings = {}

	require("nvim-tree.events").on_nvim_tree_ready(function()
		vim.cmd("NvimTreeRefresh")
	end)
end

M.setup = function()
	local nnoremap = require("utils.mappers").nnoremap
	nnoremap({ "<leader>n", ":NvimTreeToggle<CR>" })
end

return M
