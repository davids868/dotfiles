return {
  "nvim-tree/nvim-web-devicons",

  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },

  -- LSP
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "neovim/nvim-lspconfig",
      lazy = true,
      event = "BufReadPre",
      config = function()
        require "config.lsp"
      end,
      dependencies = {
        "jose-elias-alvarez/typescript.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "folke/lua-dev.nvim",
      },
    },
  },
  "jose-elias-alvarez/typescript.nvim",
  -- "nanotee/sqls.nvim"
  "jose-elias-alvarez/null-ls.nvim",
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = function()
      require("fidget").setup {}
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup {}
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "hrsh7th/nvim-cmp",
    event = { "BufEnter" },
    lazy = true,
    config = function()
      require "config.cmp"
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "friendly-snippets" },
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
  },

  {
    {
      "codota/tabnine-nvim",
      build = "./dl_binaries.sh",
      config = function()
        require("tabnine").setup {
          disable_auto_comment = true,
          accept_keymap = "<Tab>",
          dismiss_keymap = "<C-]>",
          debounce_ms = 800,
          suggestion_color = { gui = "#808080", cterm = 244 },
          exclude_filetypes = { "TelescopePrompt" },
          log_file_path = nil, -- absolute path to Tabnine log file
        }
      end,
    },
  },

  {
    "tzachar/local-highlight.nvim",
    config = function()
      require("local-highlight").setup {
        file_types = { "python", "tsx", "lua" },
        hlgroup = "TSDefinitionUsage",
      }
    end,
  },

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    keys = { { "<leader>ga", ":Neogen<cr>", desc = "Neogen" } },
  },

  -- DAP
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      dap.adapters.python = {
        type = "executable",
        command = os.getenv "HOME" .. "/.virtualenvs/tools/bin/python",
        args = { "-m", "debugpy.adapter" },
      }
    end,
  },

  {
    "ThePrimeagen/refactoring.nvim",
    enabled = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    init = function()
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
  },

  {
    "rlane/pounce.nvim",
    cmd = { "Pounce", "PounceRepeat" },
    init = function()
      local nnoremap = require("utils.mappers").nnoremap
      local vnoremap = require("utils.mappers").vnoremap
      nnoremap { "s", "<cmd>Pounce<CR>" }
      nnoremap { "S", "<cmd>PounceRepeat<CR>" }
      vnoremap { "s", "<cmd>Pounce<CR>" }
    end,
    config = function()
      require "pounce"
    end,
  },

  -- Find and replace
  {
    "windwp/nvim-spectre",
    lazy = true,
    dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    init = function()
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
  },

  {
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
    dependencies = { "nvim-ts-context-commentstring" },
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    init = function()
      vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
    end,
  },
  { enabled = false, "ludovicchabant/vim-gutentags" },

  {
    "aserowy/tmux.nvim",
    event = { "VimEnter" },
    config = function()
      require "config.tmux"
    end,
  },

  {
    "kwkarlwang/bufresize.nvim",
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
  },

  "tpope/vim-repeat",
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
      vim.keymap.set("o", "ir", "i[")
      vim.keymap.set("o", "ar", "a[")
      vim.keymap.set("o", "ia", "i<")
      vim.keymap.set("o", "aa", "a<")
    end,
  },
  "kevinhwang91/nvim-bqf",
  "mg979/vim-visual-multi",
  "svermeulen/vim-cutlass",
  { "jpalardy/vim-slime", cmd = { "SlimeConfig" } },
  { "rafcamlet/nvim-luapad" },
  "jparise/vim-graphql",

  -- Markdown
  -- "mattn/calendar-vim"
  "renerocksai/calendar-vim",
  "reedes/vim-pencil",
  { enabled = false, "preservim/vim-markdown" },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = { "markdown", "vim-plug" },
    init = function()
      local nnoremap = require("utils.mappers").nnoremap
      nnoremap { "<leader>mp", ":MarkdownPreview<CR>" }
    end,
  },

  { "mzlogin/vim-markdown-toc" },
  {
    "renerocksai/telekasten.nvim",
    enabled = false,
    lazy = true,
    init = function()
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
  },
  {
    "vhyrro/neorg",
    enabled = false, -- TODO: enable or remove
    config = function()
      require("config.neorg").setup()
    end,
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter" },
  },

  {
    "kristijanhusak/orgmode.nvim",
    enabled = false, -- TODO: enable or remove
    dependencies = { "nvim-treesitter" },
    config = function()
      require("orgmode").setup {
        org_agenda_files = { "~/org/*" },
        org_default_notes_file = "~/org/refile.org",
      }
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  {
    "sindrets/winshift.nvim",
    cmd = { "WinShift" },
    init = function()
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
  },

  {
    -- enabled = false,
    "nvim-telescope/telescope.nvim",
    -- lazy = true,
    -- cmd = {"Telescope"},
    dependencies = {
      "nvim-telescope/telescope-z.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "debugloop/telescope-undo.nvim",

      -- { "nvim-telescope/telescope-frecency.nvim", dependencies = "tami5/sql.nvim" },
    },
    -- init = function()
    -- end,
    config = function()
      require "config.telescope"
      require "config.telescope.mapping"
    end,
  },

  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    config = function()
      require("sniprun").setup {}
      local nnoremap = require("utils.mappers").nnoremap
      local vnoremap = require("utils.mappers").vnoremap
      nnoremap { "<leader>ss", ":SnipRun<CR>" }
      vnoremap { "<leader>ss", ":SnipRun<CR>" }
      nnoremap { "<leader>sc", ":SnipClose<CR>" }
    end,
  },

  {
    disable = false, -- TODO: enable or remove
    "glacambre/firenvim",
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      require "config.firenvim"
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    init = function()
      require("utils.mappers").nnoremap { "<leader>v", ":SymbolsOutline<CR>" }
    end,
    config = function()
      require "config.symbol-outline"
    end,
  },

  {
    "rebelot/heirline.nvim",
    -- event = {"VimEnter"},
    config = function()
      require "config.heirline"
    end,
  },

  -- TODO: replace with something better
  {
    enabled = false,
    "kyazdani42/nvim-tree.lua",
    -- config = require("config.tree").config,
    -- setup = require("config.tree").setup,
    cmd = { "NvimTreeToggle" },
  },

  "elihunter173/dirbuf.nvim",

  {
    "luukvbaal/nnn.nvim",
    config = function()
      local builtin = require("nnn").builtin
      local mappings = {
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
  },

  {
    -- enabled = false, -- TODO: enable or remove
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = true,
    event = "BufRead",
    config = function()
      require "config.treesitter"
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-refactor",
      "windwp/nvim-ts-autotag",
    },
  },

  -- Git
  {
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
      init = function()
        local nnoremap = require("utils.mappers").nnoremap
        nnoremap { "<leader>lg", ":LazyGit<CR>" }
      end,
      config = function()
        vim.g.lazygit_floating_window_use_plenary = 0
      end,
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
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
          map("n", "]h", ":Gitsigns next_hunk<CR>")
          map("n", "[h", ":Gitsigns prev_hunk<CR>")

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
  },

  -- color schemes

  { "rebelot/kanagawa.nvim" },

  { "Mofiqul/dracula.nvim" },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    lazy = true,
    config = function()
      require("zen-mode").setup { window = { width = 200 } }
    end,
    init = function()
      require("utils.mappers").nnoremap { "<leader>ze", ":ZenMode<CR>", nil }
    end,
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    config = function()
      require "config.diffview"
    end,
  },

  {
    "Shatur/neovim-session-manager",
    config = function()
      require("session_manager").setup {
        autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
        autosave_only_in_session = true,
      }
    end,
    require = { "nvim-lua/plenary.nvim" },
  },

  {
    "bennypowers/nvim-regexplainer",
    lazy = true,
    config = function()
      require("regexplainer").setup()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  },

  -- take a look at later time as a faster telescope alernative
  {
    enabled = false,
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
  },
}
