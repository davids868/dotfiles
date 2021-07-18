local packer = require "utils.packer"

local function plugins(use)
    use {"wbthomason/packer.nvim"}

    use {
        "kyazdani42/nvim-web-devicons",
        config = [[require("nvim-web-devicons").setup({default = true})]]
    }

    use {"nvim-lua/plenary.nvim", module = "plenary"}
    use {"nvim-lua/popup.nvim", module = "popup"}

    use {"dstein64/vim-startuptime", cmd = "StartupTime"}

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        opt = true,
        event = "BufReadPre",
        config = [[require("config.lsp")]],
        requires = {
            "jose-elias-alvarez/nvim-lsp-ts-utils",
            "jose-elias-alvarez/null-ls.nvim",
            "folke/lua-dev.nvim"
        }
    }
    use {"onsails/lspkind-nvim", config = [[ require("lspkind").init() ]]}
    use {
        "folke/trouble.nvim",
        event = "BufReadPre",
        cmd = {"TroubleToggle", "Trouble"},
        config = function()
            require("trouble").setup({auto_open = false})
        end
    }

    use {
        "glepnir/lspsaga.nvim",
        -- cmd = {"Lspsaga"},
        config = function()
            require("lspsaga").init_lsp_saga {}
        end
    }
    use {
        "hrsh7th/nvim-compe",
        event = "InsertEnter",
        opt = true,
        config = function()
            require("config.compe")
        end,
        requires = {
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("config.snippets")
                end
            },
            "rafamadriz/friendly-snippets",
            {
                "windwp/nvim-autopairs",
                config = function()
                    require("nvim-autopairs").setup()
                end
            }
        }
    }

    -- Find and replace
    use "brooth/far.vim"
    use {
        "windwp/nvim-spectre",
        opt = true,
        module = "spectre",
        wants = {"plenary.nvim", "popup.nvim"},
        requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"},
        config = function()
            require("spectre").setup {
                mapping = {
                    ["send_to_qf"] = {
                        map = "<C-q>",
                        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>"
                    }
                }
            }
        end
    }

    -- NEEDS FIX
    -- use {"dstein64/startuptime.vim", cmd = "StartupTime"}

    -- Cnsider
    -- use 'hoob3rt/lualine.nvim'

    use {"sbdchd/neoformat", config = [[require("config.format")]]}
    use {"mbbill/undotree", cmd = "UndotreeToggle"}
    use "ludovicchabant/vim-gutentags"
    use "christoomey/vim-tmux-navigator"
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "kevinhwang91/nvim-bqf"
    use "tpope/vim-commentary"
    use "mg979/vim-visual-multi"
    use "svermeulen/vim-cutlass"
    use {"jpalardy/vim-slime", cmd = {"SlimeConfig"}}
    use {"thaerkh/vim-workspace", config = [[require("config.sessions")]]}
    use {"folke/todo-comments.nvim", config = [[require("config.todo-comments")]]}
    use {"rafcamlet/nvim-luapad"}
    use "jparise/vim-graphql"
    use "sunjon/Shade.nvim"

    -- Markdown
    use "mattn/calendar-vim"
    use "reedes/vim-pencil"
    use "plasticboy/vim-markdown"
    use {
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = {"vimwiki", "markdown", "vim-plug"}
    }
    use {"vimwiki/vimwiki", config = [[require("config.markdown")]]}

    use(
        {
            "nvim-telescope/telescope.nvim",
            -- opt = true,
            -- cmd = {"Telescope"},
            requires = {
                "nvim-telescope/telescope-z.nvim",
                "nvim-telescope/telescope-project.nvim",
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-symbols.nvim",
                "nvim-telescope/telescope-fzy-native.nvim"
                -- { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sql.nvim" }
            },
            config = function()
                require("config.telescope")
                require("config.telescope.mapping")
            end
        }
    )

    use {
        "glacambre/firenvim",
        run = function()
            vim.fn["firenvim#install"](0)
        end,
        config = [[require("config.firenvim")]]
    }
    use {"simrat39/symbols-outline.nvim", cmd = {"SymbolsOutline"}, config = [[require("config.symbol-outline")]]}

    use {
        "glepnir/galaxyline.nvim",
        branch = "main",
        config = [[require("config.galaxyline")]],
        requires = "kyazdani42/nvim-web-devicons"
    }

    use {"kyazdani42/nvim-tree.lua", config = [[require("config.tree")]], cmd = {"NvimTreeToggle"}}

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        opt = true,
        event = "BufRead",
        config = [[require("config.treesitter")]]
    }

    use {"windwp/nvim-ts-autotag", opt = true, after = "nvim-treesitter"}

    -- Git
    use {
        "tpope/vim-fugitive",
        {
            "tpope/vim-rhubarb",
            "shumphrey/fugitive-gitlab.vim",
            "junegunn/gv.vim"
        },
        {
            "kdheepak/lazygit.nvim",
            cmd = "LazyGit",
            config = function()
                vim.g.lazygit_floating_window_use_plenary = 0
            end
        }
    }
    use {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        requires = {"nvim-lua/plenary.nvim"},
        config = [[require("gitsigns").setup {}]]
    }

    -- Fennel
    use {"Olical/aniseed", tag = "v3.16.0"}
    use "bakpakin/fennel.vim"

    -- color schemes
    use {
        -- "shaunsingh/nord.nvim",
        -- "shaunsingh/moonlight.nvim",
        -- { "olimorris/onedark.nvim", requires = "rktjmp/lush.nvim" },
        -- "joshdick/onedark.vim",
        -- "wadackel/vim-dogrun",
        -- { "npxbr/gruvbox.nvim", requires = "rktjmp/lush.nvim" },
        -- "bluz71/vim-nightfly-guicolors",
        -- { "marko-cerovac/material.nvim" },
        -- "sainnhe/edge",
        -- { "embark-theme/vim", as = "embark" },
        -- "norcalli/nvim-base16.lua",
        -- "RRethy/nvim-base16",
        -- "novakne/kosmikoa.nvim",
        -- "glepnir/zephyr-nvim",
        -- "ghifarit53/tokyonight-vim"
        -- "sainnhe/sonokai",
        -- "morhetz/gruvbox",
        -- "arcticicestudio/nord-vim",
        -- "drewtempelmeyer/palenight.vim",
        -- "Th3Whit3Wolf/onebuddy",
        -- "christianchiarulli/nvcode-color-schemes.vim",
        -- "Th3Whit3Wolf/one-nvim"
        --
        -- Plug 'sainnhe/gruvbox-material'
        -- Plug 'npxbr/gruvbox.nvim'
        -- Plug 'eddyekofo94/gruvbox-flat.nvim'

        -- Plug 'tjdevries/colorbuddy.vim'
        -- Plug 'tjdevries/gruvbuddy.nvim'
        -- "
        -- Plug 'shaunsingh/nord.nvim'
        -- Plug 'ayu-theme/ayu-vim'
        -- Plug 'rktjmp/lush.nvim'
        -- Plug 'drewtempelmeyer/palenight.vim'
        -- Plug 'flazz/vim-colorschemes'
        -- Plug 'sainnhe/sonokai'
        -- Plug 'Dualspc/spaceodyssey'
        -- Plug 'sonph/onehalf', { 'rtp': 'vim' }
        -- Plug 'glepnir/zephyr-nvim'
        -- Plug 'rafamadriz/neon'

        "folke/tokyonight.nvim",
        config = [[vim.cmd("colorscheme tokyonight")]]
    }

    --  Should check
    -- use(
    --     {
    --         "TimUntersberger/neogit",
    --         cmd = "Neogit",
    --         config = function()
    --             require("config.neogit")
    --         end
    --     }
    -- )

    -- -- Statusline
    -- use(
    --     {
    --         "hoob3rt/lualine.nvim",
    --         event = "VimEnter",
    --         config = [[require('config.lualine')]],
    --         wants = "nvim-web-devicons"
    --     }
    -- )

    -- use(
    --     {
    --         "norcalli/nvim-colorizer.lua",
    --         event = "BufReadPre",
    --         config = function()
    --             require("config.colorizer")
    --         end
    --     }
    -- )

    -- use({"npxbr/glow.nvim", cmd = "Glow"})

    -- use(
    --     {
    --         "plasticboy/vim-markdown",
    --         opt = true,
    --         requires = "godlygeek/tabular",
    --         ft = "markdown"
    --     }
    -- )
    -- use(
    --     {
    --         "iamcco/markdown-preview.nvim",
    --         run = function()
    --             vim.fn["mkdp#util#install"]()
    --         end,
    --         cmd = "MarkdownPreview"
    --     }
    -- )

    -- -- use { "tjdevries/train.nvim", cmd = { "TrainClear", "TrainTextObj", "TrainUpDown", "TrainWord" } }

    -- -- use({ "wfxr/minimap.vim", config = function()
    -- --   require("config.minimap")
    -- -- end })

    -- use(
    --     {
    --         "phaazon/hop.nvim",
    --         keys = {"gh", "s"},
    --         cmd = {"HopWord", "HopChar1"},
    --         config = function()
    --             require("util").nmap("gh", "<cmd>HopWord<CR>")
    --             -- require("util").nmap("s", "<cmd>HopChar1<CR>")
    --             -- you can configure Hop the way you like here; see :h hop-config
    --             require("hop").setup({})
    --         end
    --     }
    -- )

    -- use({"mbbill/undotree", cmd = "UndotreeToggle"})

    -- use({"mjlbach/babelfish.nvim", module = "babelfish"})

    use {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        opt = true,
        config = function()
            require("zen-mode").setup({plugins = {tmux = true}})
        end
    }

    use {
        "sindrets/diffview.nvim",
        cmd = {"DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles"},
        config = function()
            require("config.diffview")
        end
    }

    -- use(
    --     {
    --         "RRethy/vim-illuminate",
    --         event = "CursorHold",
    --         module = "illuminate",
    --         config = function()
    --             vim.g.Illuminate_delay = 1000
    --         end
    --     }
    -- )

    -- -- use({ "wellle/targets.vim" })

    -- -- use("DanilaMihailov/vim-tips-wiki")
    -- use("nanotee/luv-vimdocs")
    -- use(
    --     {
    --         "andymass/vim-matchup",
    --         event = "CursorMoved"
    --     }
    -- )
    -- use({"camspiers/snap", rocks = {"fzy"}, module = "snap"})
end

local disable_distribution_plugins = function()
    vim.g.loaded_gzip = 1
    vim.g.loaded_tar = 1
    vim.g.loaded_tarPlugin = 1
    vim.g.loaded_zip = 1
    vim.g.loaded_zipPlugin = 1
    vim.g.loaded_getscript = 1
    vim.g.loaded_getscriptPlugin = 1
    vim.g.loaded_vimball = 1
    vim.g.loaded_vimballPlugin = 1
    vim.g.loaded_matchit = 1
    vim.g.loaded_matchparen = 1
    vim.g.loaded_2html_plugin = 1
    vim.g.loaded_logiPat = 1
    vim.g.loaded_rrhelper = 1
    -- vim.g.loaded_netrw = 1 -- needed for GBrowse
    -- vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrwSettings = 1
    vim.g.loaded_netrwFileHandlers = 1
end

local load_plugins = function()
    disable_distribution_plugins()
    packer.setup(plugins)
end

load_plugins()
