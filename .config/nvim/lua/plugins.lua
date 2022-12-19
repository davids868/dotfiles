local packer = require "utils.packer"

local function plugins(use)
  use { "wbthomason/packer.nvim" }
  use { "lewis6991/impatient.nvim" }

  use "kyazdani42/nvim-web-devicons"

  use { "nvim-lua/plenary.nvim", module = "plenary" }
  use { "nvim-lua/popup.nvim", module = "popup" }

  -- LSP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      config = [[require("config.lsp")]],
      requires = {
        "jose-elias-alvarez/typescript.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "folke/lua-dev.nvim",
      },
    },
  }
  use "jose-elias-alvarez/typescript.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup {}
    end,
  }

  use {
    "glepnir/lspsaga.nvim", -- a maintained fork of glepnir/lspsaga.nvim
    -- cmd = {"Lspsaga"},
    config = function()
      require("lspsaga").init_lsp_saga {
        code_action_lightbulb = {
          enable = true,
          sign = true,
          enable_in_insert = false,
          sign_priority = 20,
          virtual_text = false,
        },
      }
    end,
  }

  use {
    "ThePrimeagen/refactoring.nvim",
    disable = true,
    requires = {
      { "nvim-lua/plenary.nvim" },
    },
  }
  use {
    "ThePrimeagen/harpoon",
    module = { "harpoon.ui", "harpoon.mark" },
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    setup = function()
      local nnoremap = require("utils.mappers").nnoremap
      nnoremap { "<leader>hh", ":lua require('harpoon.ui').toggle_quick_menu()<CR>" }
      nnoremap { "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>" }
      nnoremap { "<leader>hm", ":lua require('harpoon.ui').nav_file(1)<CR>" }
      nnoremap { "<leader>h,", ":lua require('harpoon.ui').nav_file(2)<CR>" }
      nnoremap { "<leader>h.", ":lua require('harpoon.ui').nav_file(3)<CR>" }
      nnoremap { "<leader>hj", ":lua require('harpoon.ui').nav_file(4)<CR>" }
      nnoremap { "<leader>hk", ":lua require('harpoon.ui').nav_file(5)<CR>" }
      nnoremap { "<leader>hl", ":lua require('harpoon.ui').nav_file(6)<CR>" }
      nnoremap { "<leader>hu", ":lua require('harpoon.ui').nav_file(7)<CR>" }
      nnoremap { "<leader>hi", ":lua require('harpoon.ui').nav_file(8)<CR>" }
      nnoremap { "<leader>ho", ":lua require('harpoon.ui').nav_file(9)<CR>" }
    end,
    config = function()
      require("harpoon").setup()
    end,
  }

  use {
    "hrsh7th/nvim-cmp",
    event = { "BufEnter" },
    opt = true,
    config = function()
      require "config.cmp"
    end,
    wants = { "LuaSnip" },
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        config = function()
          require "config.snips"
        end,
      },
      "tzachar/fuzzy.nvim",
      "rafamadriz/friendly-snippets",
      {
        "windwp/nvim-autopairs",
        config = function()
          require("nvim-autopairs").setup()
        end,
      },
    },
  }

  use {
    "rlane/pounce.nvim",
    cmd = { "Pounce", "PounceRepeat" },
    setup = function()
      local nnoremap = require("utils.mappers").nnoremap
      local vnoremap = require("utils.mappers").vnoremap
      nnoremap { "s", "<cmd>Pounce<CR>" }
      nnoremap { "S", "<cmd>PounceRepeat<CR>" }
      vnoremap { "s", "<cmd>Pounce<CR>" }
    end,
    config = function()
      require "pounce"
    end,
  }

  -- Find and replace
  use {
    "windwp/nvim-spectre",
    opt = true,
    module = "spectre",
    wants = { "plenary.nvim", "popup.nvim" },
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    setup = function()
      local nnoremap = require("utils.mappers").nnoremap
      nnoremap { "<leader>R", ":lua require('spectre').open()<CR>" }
    end,
    config = function()
      require("spectre").setup {
        mapping = {
          ["send_to_qf"] = {
            map = "<C-q>",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          },
        },
      }
    end,
  }

  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        pre_hook = function(ctx)
          if vim.bo.filetype == "typescriptreact" then
            local U = require "Comment.utils"
            local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
            local location = nil

            if ctx.ctype == U.ctype.block then
              location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring.internal").calculate_commentstring {
              key = type,
              location = location,
            }
          end
        end,
      }
    end,
    after = "nvim-ts-context-commentstring",
  }

  use {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    setup = function()
      vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
    end,
  }
  use { disable = true, "ludovicchabant/vim-gutentags" }

  use {
    "aserowy/tmux.nvim",
    event = { "VimEnter" },
    config = function()
      require "config.tmux"
    end,
  }

  use {
    "kwkarlwang/bufresize.nvim",
    disable=true,

    config = function()
      require("bufresize").setup {
        register = {
          keys = {},
          trigger_events = { "BufWinEnter", "WinEnter" },
        },
        resize = {
          keys = {},
          trigger_events = { "VimResized" },
          increment = false,
        },
      }
    end,
  }

  use "tpope/vim-repeat"
  use {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
      vim.keymap.set("o", "ir", "i[")
      vim.keymap.set("o", "ar", "a[")
      vim.keymap.set("o", "ia", "i<")
      vim.keymap.set("o", "aa", "a<")
    end,
  }
  use "kevinhwang91/nvim-bqf"
  use "mg979/vim-visual-multi"
  use "svermeulen/vim-cutlass"
  use { "jpalardy/vim-slime", cmd = { "SlimeConfig" } }
  use { "rafcamlet/nvim-luapad" }
  use "jparise/vim-graphql"

  -- Markdown
  -- use "mattn/calendar-vim"
  use "renerocksai/calendar-vim"
  use "reedes/vim-pencil"
  use { disable = true, "preservim/vim-markdown" }

  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown", "vim-plug" },
    setup = function()
      local nnoremap = require("utils.mappers").nnoremap
      nnoremap { "<leader>mp", ":MarkdownPreview<CR>" }
    end,
  }

  use { "mzlogin/vim-markdown-toc" }
  use {
    "renerocksai/telekasten.nvim",
    module = "telekasten",
    setup = function()
      local nnoremap = require("utils.mappers").nnoremap

      nnoremap {
        "<leader>zf",
        function()
          require("telekasten").find_notes()
        end,
      }
      nnoremap {
        "<leader>zd",
        function()
          require("telekasten").find_daily_notes()
        end,
      }
      nnoremap {
        "<leader>zg",
        function()
          require("telekasten").search_notes()
        end,
      }
      nnoremap {
        "<leader>zz",
        function()
          require("telekasten").follow_link()
        end,
      }
      nnoremap {
        "<leader>zT",
        function()
          require("telekasten").goto_today()
        end,
      }
      nnoremap {
        "<leader>zW",
        function()
          require("telekasten").goto_thisweek()
        end,
      }
      nnoremap {
        "<leader>zw",
        function()
          require("telekasten").find_weekly_notes()
        end,
      }
      nnoremap {
        "<leader>zn",
        function()
          require("telekasten").new_note()
        end,
      }
      nnoremap {
        "<leader>zN",
        function()
          require("telekasten").new_templated_note()
        end,
      }
      nnoremap {
        "<leader>zy",
        function()
          require("telekasten").yank_notelink()
        end,
      }
      nnoremap {
        "<leader>zc",
        function()
          require("telekasten").show_calendar()
        end,
      }
      nnoremap { "<leader>zC", "CalendarT<CR>" }
      nnoremap {
        "<leader>zi",
        function()
          require("telekasten").paste_img_and_link()
        end,
      }
      nnoremap {
        "<leader>zt",
        function()
          require("telekasten").toggle_todo()
        end,
      }
      nnoremap {
        "<leader>zb",
        function()
          require("telekasten").show_backlinks()
        end,
      }
      nnoremap {
        "<leader>zF",
        function()
          require("telekasten").find_friends()
        end,
      }
      nnoremap {
        "<leader>zp",
        function()
          require("telekasten").preview_img()
        end,
      }
      nnoremap {
        "<leader>zm",
        function()
          require("telekasten").browse_media()
        end,
      }
      nnoremap {
        "<leader>za",
        function()
          require("telekasten").show_tags()
        end,
      }
      nnoremap {
        "<leader>#",
        function()
          require("telekasten").show_tags()
        end,
      }
      nnoremap {
        "<leader>zr",
        function()
          require("telekasten").rename_note()
        end,
      }
      nnoremap {
        "<leader>z",
        function()
          require("telekasten").panel()
        end,
      }
    end,
    config = function()
      local home = vim.fn.expand "~/zettelkasten"
      require("telekasten").setup {
        home = home,
        take_over_my_home = true,
        auto_set_filetype = true,
        dailies = home .. "/" .. "daily",
        weeklies = home .. "/" .. "weekly",
        templates = home .. "/" .. "templates",
        image_subdir = "img",
        extension = ".md",
        follow_creates_nonexisting = true,
        dailies_create_nonexisting = true,
        weeklies_create_nonexisting = true,
        template_new_note = home .. "/" .. "templates/new_note.md",
        template_new_daily = home .. "/" .. "templates/daily.md",
        template_new_weekly = home .. "/" .. "templates/weekly.md",
        image_link_style = "markdown",
        plug_into_calendar = true,
        calendar_opts = {
          weeknm = 4,
          calendar_monday = 1,
          calendar_mark = "left-fit",
        },
        close_after_yanking = false,
        insert_after_inserting = true,
        tag_notation = "#tag",
        command_palette_theme = "dropdown",
        show_tags_theme = "dropdown",
        subdirs_in_links = true,
        template_handling = "smart",
        new_note_location = "smart",
        rename_update_links = true,
      }
    end,
  }
  use {
    "vhyrro/neorg",
    disable = true, -- TODO: enable or remove
    after = "nvim-treesitter",
    config = function()
      require("config.neorg").setup()
    end,
    requires = "nvim-lua/plenary.nvim",
  }

  use {
    "kristijanhusak/orgmode.nvim",
    disable = true, -- TODO: enable or remove
    after = "nvim-treesitter",
    config = function()
      require("orgmode").setup {
        org_agenda_files = { "~/org/*" },
        org_default_notes_file = "~/org/refile.org",
      }
    end,
  }

  use {
    "norcalli/nvim-colorizer.lua",
    config = [[require("colorizer").setup()]],
  }

  use {
    "sindrets/winshift.nvim",
    cmd = { "WinShift" },
    setup = function()
      local nnoremap = require("utils.mappers").nnoremap
      nnoremap { "<C-w>m", ":WinShift<CR>" }
      nnoremap { "<C-w><C-m>", ":WinShift<CR>" }
    end,
    config = function()
      require("winshift").setup {
        highlight_moving_win = true, -- Highlight the window being moved
        focused_hl_group = "Visual", -- The highlight group used for the moving window
        moving_win_options = {
          -- These are local options applied to the moving window while it's
          -- being moved. They are unset when you leave Win-Move mode.
          wrap = false,
          cursorline = false,
          cursorcolumn = false,
          colorcolumn = "",
        },
      }
    end,
  }

  use {
    -- disable = true,
    "nvim-telescope/telescope.nvim",
    -- opt = true,
    -- cmd = {"Telescope"},
    requires = {
      "nvim-telescope/telescope-z.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      -- { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sql.nvim" }
    },
    -- module = "config.telescope",
    -- setup = function()
    -- end,
    config = function()
      require "config.telescope"
      require "config.telescope.mapping"
    end,
  }

  use { "michaelb/sniprun", run = "bash ./install.sh" }

  use {
    disable = false, -- TODO: enable or remove
    "glacambre/firenvim",
    run = function()
      vim.fn["firenvim#install"](0)
    end,
    config = [[require("config.firenvim")]],
  }

  use {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    setup = function()
      require("utils.mappers").nnoremap { "<leader>v", ":SymbolsOutline<CR>" }
    end,
    config = function()
      require "config.symbol-outline"
    end,
  }

  use {
    "rebelot/heirline.nvim",
    -- event = {"VimEnter"},
    config = function()
      require "config.heirline"
    end,
  }

  -- TODO: replace with something better
  use {
    disable = true,
    "kyazdani42/nvim-tree.lua",
    -- config = require("config.tree").config,
    -- setup = require("config.tree").setup,
    cmd = { "NvimTreeToggle" },
  }

  use "elihunter173/dirbuf.nvim"

  use {
    "luukvbaal/nnn.nvim",
    config = function()
      local builtin = require("nnn").builtin
      mappings = {
        { "<C-t>", builtin.open_in_tab }, -- open file(s) in tab
        { "<C-s>", builtin.open_in_split }, -- open file(s) in split
        { "<C-v>", builtin.open_in_vsplit }, -- open file(s) in vertical split
        { "<C-p>", builtin.open_in_preview }, -- open file in preview split keeping nnn focused
        -- { "l", builtin.open },   -- open file in preview split keeping nnn focused
        { "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
        { "<C-w>", builtin.cd_to_path }, -- cd to file directory
        { "<C-e>", builtin.populate_cmdline }, -- populate cmdline (:) with file(s)
      }
      require("nnn").setup { picker = { cmd = "nnn -dH" }, mappings = mappings }
      require("utils.mappers").nnoremap { "<leader>n", ":NnnPicker %<CR>" }
    end,
  }

  use {
    -- disable = true, -- TODO: enable or remove
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    opt = true,
    event = "BufRead",
    config = [[require("config.treesitter")]],
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
  }

  use { "windwp/nvim-ts-autotag", opt = true, after = "nvim-treesitter" }

  -- Git
  use {
    {
      "tpope/vim-fugitive",
      config = function()
        local nnoremap = require("utils.mappers").nnoremap
        local vnoremap = require("utils.mappers").vnoremap
        local g = vim.g

        g.fugitive_gitlab_domains = { "https://gitlab.eu-west-1.mgmt.onfido.xyz/" }

        nnoremap { "<leader>ge", ":GBrowse<CR>" }
        nnoremap { "<leader>gy", ":GBrowse!<CR>" }
        vnoremap { "<leader>ge", ":'<,'>GBrowse<CR>" }
        vnoremap { "<leader>gy", ":'<,'>GBrowse!<CR>" }
        nnoremap { "<leader>df", ":Gvdiffsplit origin/HEAD<CR>" }
        nnoremap { "<leader>dv", ":DiffviewOpen<CR>" }
        nnoremap { "<leader>dm", ":DiffviewOpen origin/HEAD<CR>" }
        nnoremap { "<leader>fh", ":DiffviewFileHistory %<CR>" }
        nnoremap { "<leader>bc", ":DiffviewFileHistory %<CR>" }
        nnoremap { "<leader>dl", ":diffget //3<CR>" }
        nnoremap { "<leader>dh", ":diffget //2<CR>" }
        nnoremap { "<leader>gs", ":tab G<CR>" }
        nnoremap { "<leader>gb", ":Git blame<CR>" }
        nnoremap { "<leader>gc", ":GV<CR>" }
        nnoremap { "<leader>dv", ":DiffviewOpen<CR>" }
      end,
    },
    {
      "tpope/vim-rhubarb",
      "shumphrey/fugitive-gitlab.vim",
      "junegunn/gv.vim",
    },
    {
      "kdheepak/lazygit.nvim",
      cmd = "LazyGit",
      setup = function()
        local nnoremap = require("utils.mappers").nnoremap
        nnoremap { "<leader>lg", ":LazyGit<CR>" }
      end,
      config = function()
        vim.g.lazygit_floating_window_use_plenary = 0
      end,
    },
  }
  use {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup {
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
          map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

          -- Actions
          map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
          map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
          map("n", "<leader>hS", gs.stage_buffer)
          map("n", "<leader>hu", gs.undo_stage_hunk)
          map("n", "<leader>hR", gs.reset_buffer)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hb", function()
            gs.blame_line { full = true }
          end)
          map("n", "<leader>tb", gs.toggle_current_line_blame)
          map("n", "<leader>hd", gs.diffthis)
          map("n", "<leader>hD", function()
            gs.diffthis "~"
          end)
          map("n", "<leader>td", gs.toggle_deleted)

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      }
    end,
  }

  -- color schemes

  use { "rebelot/kanagawa.nvim" }

  use { "Mofiqul/dracula.nvim" }

  use {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opt = true,
    config = function()
      require("zen-mode").setup {}
    end,
    setup = function()
      require("utils.mappers").nnoremap { "<leader>ze", ":ZenMode<CR>", nil }
    end,
  }

  use {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    config = function()
      require "config.diffview"
    end,
  }

  use {
    "Shatur/neovim-session-manager",
    config = function()
      require("session_manager").setup {
        autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
        autosave_only_in_session = true,
      }
    end,
    require = { "nvim-lua/plenary.nvim" },
  }

  use {
    "bennypowers/nvim-regexplainer",
    keys = "gR",
    config = function()
      require("regexplainer").setup()
    end,
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  }

  -- take a look at later time as a faster telescope alernative
  use {
    disable = true,
    "camspiers/snap",
    rocks = { "fzy" },
    config = function()
      local snap = require "snap"

      snap.maps {
        { "<Leader>fb", snap.config.file { producer = "ripgrep.file" } },
        { "<Leader>fo", snap.config.file { producer = "vim.oldfile" } },
        { "<Leader>ff", snap.config.vimgrep {} },
      }
    end,
  }
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
  -- vim.g.loaded_netrwSettings = 1
  -- vim.g.loaded_netrwFileHandlers = 1
end

local load_plugins = function()
  disable_distribution_plugins()
  packer.setup(plugins)
end

load_plugins()
