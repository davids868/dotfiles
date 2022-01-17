vim.o.completeopt = "menuone,noselect,noinsert"

local cmp = require("cmp")

cmp.setup {
    snippet = {
        expand = function(args)
            -- For `luasnip` user.
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({select = true})
    },
    sources = {
        {name = "nvim_lsp"},
        {name = "luasnip"},
        {name = "buffer"},
        {name = "path"},
        {name = "neorg"}
        -- {name = "orgmode"}
    },
    formatting = {
        format = require("config.kind").cmp_format()
    },
    documentation = {
        border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}
    },
    experimental = {
        ghost_text = {
            hl_group = "LineNr"
        }
    }
}

-- require "compe".setup {
--     enabled = true,
--     autocomplete = true,
--     debug = false,
--     min_length = 1,
--     throttle_time = 80,
--     source_timeout = 200,
--     incomplete_delay = 400,
--     max_abbr_width = 500,
--     max_kind_width = 100,
--     max_menu_width = 500,
--     documentation = true,
--     source = {
--         nvim_lsp = {priority = 1000},
--         buffer = {ignored_filetypes = ignored_filetypes},
--         calc = true,
--         vsnip = false,
--         path = true,
--         nvim_lua = true,
--         spell = false,
--         tags = false,
--         snippets_nvim = true,
--         treesitter = false,
--         omni = false,
--         conjure = true
--         -- off due to very bad performanc
--         -- tabnine = {
--         --     max_line = 1000,
--         --     max_num_results = 5
--         -- }
--     }
-- }
