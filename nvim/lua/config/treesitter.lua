require "nvim-treesitter.configs".setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        disable = {"scss"}
    },
    rainbow = {
        enable = false,
        extended_mode = true -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    },
    autotag = {
        enable = true
    },
    context_commentstring = {
        enable = true
    }
}

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
