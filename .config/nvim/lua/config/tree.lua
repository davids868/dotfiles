local tree_cb = require "nvim-tree.config".nvim_tree_callback

require "nvim-tree".setup(
    {
        disable_netrw = false,
        hijack_netrw = true,
        update_focused_file = {
            enable = true
        },
        view = {
            width = 35,
            mappings = {
                list = {
                    {key = "l", cb = tree_cb("edit")},
                    {key = "h", cb = tree_cb("close_node")},
                    {key = "o", cb = ":lua NvimTreeOSOpen()<CR>"}
                }
            }
        }
    }
)

function NvimTreeOSOpen()
    local lib = require "nvim-tree.lib"
    local node = lib.get_node_at_cursor()
    dump(node.absolute_path)
    if node then
        vim.fn.jobstart("open '" .. node.absolute_path .. "' &", {detach = true})
    end
end

vim.g.nvim_tree_bindings = {}

require("nvim-tree.events").on_nvim_tree_ready(
    function()
        vim.cmd("NvimTreeRefresh")
    end
)
