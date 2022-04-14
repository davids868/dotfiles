local languages = {
  "bash",
  "c",
  "clojure",
  "cmake",
  "commonlisp",
  "cpp",
  "css",
  "elixir",
  "erlang",
  "fennel",
  "go",
  "graphql",
  "html",
  "http",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "python",
  "regex",
  "ruby",
  "rust",
  "scss",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "yaml",
  "org",
  "norg",
}
-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

-- parser_config.org = {
--     install_info = {
--         url = "https://github.com/milisims/tree-sitter-org";,
--         revision = "main",
--         files = {"src/parser.c", "src/scanner.cc"}
--     },
--     filetype = "org"
-- }

-- parser_config.norg = {
--     install_info = {
--         url = "https://github.com/nvim-neorg/tree-sitter-norg",
--         files = {"src/parser.c", "src/scanner.cc"},
--         branch = "main"
--     }
-- }

require("nvim-treesitter.configs").setup {
  ensure_installed = languages,
  highlight = {
    enable = true,
    -- disable = {"org"}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    -- additional_vim_regex_highlighting = {"org"} -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  rainbow = {
    enable = false,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  keymaps = {
    -- You can use the capture groups defined in textobjects.scm
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["ac"] = "@class.outer",
    ["ic"] = "@class.inner",
  },
}
