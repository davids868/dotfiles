if not pcall(require, "telescope") then
    return
end

local telemap = require("utils.mappers").telemap
local sorters = require("telescope.sorters")

vim.api.nvim_set_keymap("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", {noremap = false, nowait = true})

-- Search
telemap("v", "<leader>F", "grep_visual_selection")
telemap("n", "<leader>fl", "buffer_lines")
telemap("n", "<leader>fp", "grep_prompt")
telemap(
    "n",
    "<leader>fw",
    "grep_string",
    {
        short_path = true,
        hidden = true,
        word_match = "-w",
        only_sort_text = true,
        sorter = sorters.get_fzy_sorter()
    }
)
telemap("n", "<leader>/", "grep_last_search")
telemap("n", "<leader>F", "live_grep")
telemap("n", "<leader>,", "edit_neovim")
telemap("n", "<leader>p", "git_files")
telemap("n", "<leader>o", "find_files")
telemap("n", "<leader>go", "git_branches")
telemap("n", "<leader><space>", "commands")
-- map_tele("n", "<leader>rr", "oldfiles")

-- map_tele("<leader>fv", "find_nvim_source")
-- map_tele("n", "<leader>s", "lsp_document_symbols")
-- map_tele("n", "<leader>S", "lsp_dynamic_workspace_symbols")
telemap("n", "<leader>D", "lsp_workspace_diagnostics")
telemap("n", "<leader>s", "current_buffer_tags")
telemap("n", "<leader>S", "tags")
telemap("n", "<leader>ht", "help_tags")
telemap("n", "<leader>ho", "vim_options")
telemap("n", "<leader>tl", "builtin")
telemap("n", "<leader>tr", "resume")
telemap("n", "<leader>ft", "filetypes")

return telemap
