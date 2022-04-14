vim.o.completeopt = "menuone,noselect,noinsert"

local cmp = require("cmp")

cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({select = true}),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item()
    },
    sources = {
        {name = "nvim_lsp"},
        {name = "luasnip"},
        {name = "buffer"},
        {name = "path"},
        {name = "fuzzy_buffer"},
        {name = "neorg"},
        {name = "orgmode"}
    },
    formatting = {
        format = require("config.kind").cmp_format()
    },
    window = {
        completion = {
            border = "rounded",
            winhighlight = "FloatBorder:None,Normal:None"
        },
        documentation = {
            border = "rounded",
            winhighlight = "FloatBorder:None,Normal:None"
        }
    },
    experimental = {
        ghost_text = {
            hl_group = "LineNr"
        }
    }
}

cmp.setup.cmdline(
    ":",
    {
        sources = {
            {name = "cmdline"}
        },
        view = {
            entries = "wildmenu"
        }
    }
)

