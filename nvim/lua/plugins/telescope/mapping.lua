if not pcall(require, "telescope") then
    return
end

local sorters = require("telescope.sorters")

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(mode, key, f, options, buffer)
    local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

    TelescopeMapArgs[map_key] = options or {}

    local rhs = string.format("<cmd>lua require('plugins.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

    local map_options = {
        noremap = true,
        silent = true
    }

    if not buffer then
        vim.api.nvim_set_keymap(mode, key, rhs, map_options)
    else
        vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
    end
end

vim.api.nvim_set_keymap("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", {noremap = false, nowait = true})

-- Search
map_tele("v", "<leader>F", "grep_visual_selection")
map_tele("n", "<leader>fl", "buffer_lines")
map_tele("n", "<leader>fp", "grep_prompt")
-- map_tele("n", "<leader>G", "live_grep")
map_tele(
    "n",
    "<leader>fw",
    "grep_string",
    {
        short_path = true,
        word_match = "-w",
        only_sort_text = true,
        sorter = sorters.get_fzy_sorter()
    }
)
map_tele("n", "<leader>/", "grep_last_search")
map_tele("n", "<leader>F", "live_grep")
map_tele("n", "<leader>,", "edit_neovim")
map_tele("n", "<leader>p", "git_files")
map_tele("n", "<leader>o", "find_files")
map_tele("n", "<leader>go", "git_branches")
map_tele("n", "<leader><space>", "commands")
-- map_tele("n", "<leader>rr", "oldfiles")

-- map_tele("<leader>fv", "find_nvim_source")
-- map_tele("n", "<leader>s", "lsp_document_symbols")
-- map_tele("n", "<leader>S", "lsp_dynamic_workspace_symbols")
map_tele("n", "<leader>D", "lsp_workspace_diagnostics")
map_tele("n", "<leader>s", "current_buffer_tags")
map_tele("n", "<leader>S", "tags")

map_tele("n", "<leader>b", "buffers")
map_tele("n", "<leader>ht", "help_tags")
map_tele("n", "<leader>ho", "vim_options")
map_tele("n", "<leader>tl", "builtin")
map_tele("n", "<leader>ft", "filetypes")

return map_tele
