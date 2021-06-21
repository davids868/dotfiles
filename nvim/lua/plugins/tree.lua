local tree_cb = require "nvim-tree.config".nvim_tree_callback

vim.g.nvim_tree_width = 35
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_disable_netrw = 0

function NvimTreeOSOpen()
    local lib = require "nvim-tree.lib"
    local node = lib.get_node_at_cursor()
    if node then
        vim.fn.jobstart("open '" .. node.absolute_path .. "' &", {detach = true})
    end
end

vim.g.nvim_tree_bindings = {
    {key = {"l"}, cb = tree_cb("edit")},
    {key = {"h"}, cb = tree_cb("close_node")},
    {key = {"o"}, cb = tree_cb(":lua NvimTreeOSOpen()<cr>")}
}
