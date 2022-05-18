vim.o.completeopt = "menu,menuone,noselect"

local cmp = require "cmp"

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<C-n>"] = function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end,
    ["<C-p>"] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "fuzzy_buffer" },
    { name = "neorg" },
    { name = "orgmode" },
  },
  formatting = {
    format = require("config.kind").cmp_format(),
  },
  completion = {
    autocomplete = { "InsertEnter", "TextChanged" },
  },
  window = {
    completion = {
      border = "rounded",
      winhighlight = "FloatBorder:None,Normal:None",
    },
    documentation = {
      border = "rounded",
      winhighlight = "FloatBorder:None,Normal:None",
    },
  },
  experimental = {
    ghost_text = {
      hl_group = "LineNr",
    },
  },
}

cmp.setup.cmdline(":", {
  sources = {
    { name = "cmdline" },
  },
  view = {
    entries = "wildmenu",
  },
})

-- cmp.setup.cmdline(
--     "/",
--     {
--         sources = {
--             {name = "buffer"}
--         },
--         view = {
--             entries = "wildmenu"
--         }
--     }
-- )
