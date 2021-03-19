vim.o.completeopt = "menuone,noselect,noinsert"
local opts = {ignored_filetypes = {"clap_input"}}

require("lspkind").init()
require "compe".setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = false,
    source = {
        path = opts,
        buffer = {ignored_filetypes = opts.ignored_filetypes, priority = 100},
        calc = true,
        vsnip = false,
        nvim_lsp = {
            priority = 1
        },
        nvim_lua = true,
        spell = false,
        tags = false,
        snippets_nvim = true,
        treesitter = false,
        omni = false,
        tabnine = {
            max_line = 1000,
            max_num_results = 5
        }
    }
}

-- local t = function(str)
--     return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
-- _G.s_tab_complete = function()
--     if vim.fn.pumvisible() == 1 then
--         return t "<C-p>"
--     elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
--         return t "<Plug>(vsnip-jump-prev)"
--     else
--         return t "<S-Tab>"
--     end
-- end

local opts = {noremap = true, silent = true, expr = true}
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", opts)
vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", opts)
vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", opts)
