local packer = require("utils.packer")

local function plugins(use)
	use({ "wbthomason/packer.nvim" })
	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient").enable_profile()
		end,
	})

	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	})

	use({ "nvim-lua/plenary.nvim", module = "plenary" })
	use({ "nvim-lua/popup.nvim", module = "popup" })

	use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		opt = true,
		event = "BufReadPre",
		config = [[require("config.lsp")]],
		requires = {
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			"jose-elias-alvarez/null-ls.nvim",
			"folke/lua-dev.nvim",
		},
	})

	use({
		"folke/trouble.nvim",
		event = "BufReadPre",
		cmd = { "TroubleToggle", "Trouble" },
		config = function()
			require("trouble").setup({ auto_open = false })
		end,
	})

	use({
		"tami5/lspsaga.nvim", -- a maintained fork of glepnir/lspsaga.nvim
		-- cmd = {"Lspsaga"},
		config = function()
			require("lspsaga").init_lsp_saga({
				code_action_prompt = {
					enable = true,
					sign = false,
					sign_priority = 20,
					virtual_text = true,
				},
			})
		end,
	})

	-- TODO: look into refactoring plugin
	-- use {
	--     "ThePrimeagen/refactoring.nvim",
	--     requires = {
	--         {"nvim-lua/plenary.nvim"},
	--         {"nvim-treesitter/nvim-treesitter"}
	--     }
	--     -- config = function()
	--     --     require("config.refactoring")
	--     -- end
	-- }
	--
	use({
		"ThePrimeagen/harpoon",
		keys = { "<space>hh" },
		requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
		setup = function()
			local nnoremap = require("utils.mappers").nnoremap
			nnoremap({ "<leader>hh", ":lua require('harpoon.ui').toggle_quick_menu()<CR>" })
			nnoremap({ "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>" })
			nnoremap({ "<leader>hm", ":lua require('harpoon.ui').nav_file(1)<CR>" })
			nnoremap({ "<leader>h,", ":lua require('harpoon.ui').nav_file(2)<CR>" })
			nnoremap({ "<leader>h.", ":lua require('harpoon.ui').nav_file(3)<CR>" })
			nnoremap({ "<leader>hj", ":lua require('harpoon.ui').nav_file(4)<CR>" })
			nnoremap({ "<leader>hk", ":lua require('harpoon.ui').nav_file(5)<CR>" })
			nnoremap({ "<leader>hl", ":lua require('harpoon.ui').nav_file(6)<CR>" })
			nnoremap({ "<leader>hu", ":lua require('harpoon.ui').nav_file(7)<CR>" })
			nnoremap({ "<leader>hi", ":lua require('harpoon.ui').nav_file(8)<CR>" })
			nnoremap({ "<leader>ho", ":lua require('harpoon.ui').nav_file(9)<CR>" })
		end,
		config = function()
			require("harpoon").setup()
		end,
	})

	use({
		"hrsh7th/nvim-cmp",
		event = { "BufEnter" },
		opt = true,
		config = function()
			require("config.cmp")
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
					require("config.snips")
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
	})

	use({
		"rlane/pounce.nvim",
		cmd = { "Pounce", "PounceRepeat" },
		setup = function()
			local nnoremap = require("utils.mappers").nnoremap
			local vnoremap = require("utils.mappers").vnoremap
			nnoremap({ "s", "<cmd>Pounce<CR>" })
			nnoremap({ "S", "<cmd>PounceRepeat<CR>" })
			vnoremap({ "s", "<cmd>Pounce<CR>" })
		end,
		config = function()
			require("pounce")
		end,
	})

	-- Find and replace
	use({
		"windwp/nvim-spectre",
		opt = true,
		module = "spectre",
		wants = { "plenary.nvim", "popup.nvim" },
		requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
		setup = function()
			local nnoremap = require("utils.mappers").nnoremap
			nnoremap({ "<leader>R", ":lua require('spectre').open()<CR>" })
		end,
		config = function()
			require("spectre").setup({
				mapping = {
					["send_to_qf"] = {
						map = "<C-q>",
						cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
					},
				},
			})
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = function(ctx)
					if vim.bo.filetype == "typescriptreact" then
						local U = require("Comment.utils")
						local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
						local location = nil

						if ctx.ctype == U.ctype.block then
							location = require("ts_context_commentstring.utils").get_cursor_location()
						elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
							location = require("ts_context_commentstring.utils").get_visual_start_location()
						end

						return require("ts_context_commentstring.internal").calculate_commentstring({
							key = type,
							location = location,
						})
					end
				end,
			})
		end,
		after = "nvim-ts-context-commentstring",
		-- requires = {
		--     {
		--         "JoosepAlviste/nvim-ts-context-commentstring",
		--         after = "nvim-treesitter"
		--     }
		-- }
	})

	-- TODO: figure out better formatting
	use({
		disable = true,
		"sbdchd/neoformat",
		setup = require("config.format").setup,
		config = require("config.format").config,
	})

	use({
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		setup = function()
			vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
		end,
	})
	use("ludovicchabant/vim-gutentags")

	use({
		"aserowy/tmux.nvim",
		event = { "VimEnter" },
		config = function()
			require("config.tmux")
		end,
	})

	use({
		disable = true,
		"olimorris/persisted.nvim",
		config = function()
			require("persisted").setup({
				autoload = true,
			})
		end,
	})

	use({
		"AndrewRadev/splitjoin.vim",
		keys = { "gJ", "gS" },
	})

	use("tpope/vim-repeat")
	use("tpope/vim-surround")
	use("kevinhwang91/nvim-bqf")
	use("mg979/vim-visual-multi")
	use("svermeulen/vim-cutlass")
	use({ "jpalardy/vim-slime", cmd = { "SlimeConfig" } })
	use({ "folke/todo-comments.nvim", config = [[require("config.todo-comments")]] })
	use({ "rafcamlet/nvim-luapad" })
	use("jparise/vim-graphql")
	use("sunjon/Shade.nvim")

	-- TODO: figure out if useful
	-- use { "vuki656/package-info.nvim", config = {"require('package-info').setup()"} }

	-- Markdown
	-- use "mattn/calendar-vim"
	use("renerocksai/calendar-vim")
	use("reedes/vim-pencil")
	use("plasticboy/vim-markdown")
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown", "vim-plug" },
		setup = function()
			local nnoremap = require("utils.mappers").nnoremap
			nnoremap({ "<leader>mp", ":MarkdownPreview<CR>" })
		end,
	})

	use({ "mzlogin/vim-markdown-toc" })
	use({
		"renerocksai/telekasten.nvim",
		module = "telekasten",
		setup = function()
			local nnoremap = require("utils.mappers").nnoremap

			nnoremap({
				"<leader>zf",
				function()
					require("telekasten").find_notes()
				end,
			})
			nnoremap({
				"<leader>zd",
				function()
					require("telekasten").find_daily_notes()
				end,
			})
			nnoremap({
				"<leader>zg",
				function()
					require("telekasten").search_notes()
				end,
			})
			nnoremap({
				"<leader>zz",
				function()
					require("telekasten").follow_link()
				end,
			})
			nnoremap({
				"<leader>zT",
				function()
					require("telekasten").goto_today()
				end,
			})
			nnoremap({
				"<leader>zW",
				function()
					require("telekasten").goto_thisweek()
				end,
			})
			nnoremap({
				"<leader>zw",
				function()
					require("telekasten").find_weekly_notes()
				end,
			})
			nnoremap({
				"<leader>zn",
				function()
					require("telekasten").new_note()
				end,
			})
			nnoremap({
				"<leader>zN",
				function()
					require("telekasten").new_templated_note()
				end,
			})
			nnoremap({
				"<leader>zy",
				function()
					require("telekasten").yank_notelink()
				end,
			})
			nnoremap({
				"<leader>zc",
				function()
					require("telekasten").show_calendar()
				end,
			})
			nnoremap({ "<leader>zC", "CalendarT<CR>" })
			nnoremap({
				"<leader>zi",
				function()
					require("telekasten").paste_img_and_link()
				end,
			})
			nnoremap({
				"<leader>zt",
				function()
					require("telekasten").toggle_todo()
				end,
			})
			nnoremap({
				"<leader>zb",
				function()
					require("telekasten").show_backlinks()
				end,
			})
			nnoremap({
				"<leader>zF",
				function()
					require("telekasten").find_friends()
				end,
			})
			nnoremap({
				"<leader>zp",
				function()
					require("telekasten").preview_img()
				end,
			})
			nnoremap({
				"<leader>zm",
				function()
					require("telekasten").browse_media()
				end,
			})
			nnoremap({
				"<leader>za",
				function()
					require("telekasten").show_tags()
				end,
			})
			nnoremap({
				"<leader>#",
				function()
					require("telekasten").show_tags()
				end,
			})
			nnoremap({
				"<leader>zr",
				function()
					require("telekasten").rename_note()
				end,
			})
			nnoremap({
				"<leader>z",
				function()
					require("telekasten").panel()
				end,
			})
		end,
		config = function()
			local home = vim.fn.expand("~/zettelkasten")
			require("telekasten").setup({
				home = home,
				-- if true, telekasten will be enabled when opening a note within the configured home
				take_over_my_home = true,
				-- auto-set telekasten filetype: if false, the telekasten filetype will not be used
				--                               and thus the telekasten syntax will not be loaded either
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
					-- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
					weeknm = 4,
					calendar_monday = 1,
					-- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
					calendar_mark = "left-fit",
				},
				-- telescope actions behavior
				close_after_yanking = false,
				insert_after_inserting = true,
				tag_notation = "#tag",
				command_palette_theme = "dropdown",
				show_tags_theme = "dropdown",
				subdirs_in_links = true,
				-- template_handling
				-- What to do when creating a new note via `new_note()` or `follow_link()`
				-- to a non-existing note
				-- - prefer_new_note: use `new_note` template
				-- - smart: if day or week is detected in title, use daily / weekly templates (default)
				-- - always_ask: always ask before creating a note
				template_handling = "smart",
				-- path handling:
				--   this applies to:
				--     - new_note()
				--     - new_templated_note()
				--     - follow_link() to non-existing note
				--
				--   it does NOT apply to:
				--     - goto_today()
				--     - goto_thisweek()
				--
				--   Valid options:
				--     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
				--              all other ones in home, except for notes/with/subdirs/in/title.
				--              (default)
				--
				--     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
				--                    except for notes with subdirs/in/title.
				--
				--     - same_as_current: put all new notes in the dir of the current note if
				--                        present or else in home
				--                        except for notes/with/subdirs/in/title.
				new_note_location = "smart",
				-- should all links be updated when a file is renamed
				rename_update_links = true,
			})
		end,
	})
	use({
		"vhyrro/neorg",
		disable = true, -- TODO: enable or remove
		after = "nvim-treesitter",
		config = function()
			require("config.neorg").setup()
		end,
		requires = "nvim-lua/plenary.nvim",
	})

	use({
		"kristijanhusak/orgmode.nvim",
		disable = true, -- TODO: enable or remove
		after = "nvim-treesitter",
		config = function()
			require("orgmode").setup({
				org_agenda_files = { "~/org/*" },
				org_default_notes_file = "~/org/refile.org",
			})
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		config = [[require("colorizer").setup()]],
	})

	use({
		"sindrets/winshift.nvim",
		cmd = { "WinShift" },
		setup = function()
			local nnoremap = require("utils.mappers").nnoremap
			nnoremap({ "<C-w>m", ":WinShift<CR>" })
			nnoremap({ "<C-w><C-m>", ":WinShift<CR>" })
		end,
		config = function()
			require("winshift").setup({
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
			})
		end,
	})

	use({
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
		config = function()
			require("config.telescope")
			require("config.telescope.mapping")
		end,
	})

	use({
		disable = true,
		"gelguy/wilder.nvim",
		config = function()
			require("config.wilder")
		end,
		requires = { { "romgrk/fzy-lua-native", after = "wilder.nvim" } },
	})

	use({
		disable = true, -- TODO: enable or remove
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
		config = [[require("config.firenvim")]],
	})

	use({
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline" },
		setup = function()
			require("utils.mappers").nnoremap({ "<leader>v", ":SymbolsOutline<CR>" })
		end,
		config = function()
			require("config.symbol-outline")
		end,
	})

	use({
		disable = true,
		"NTBBloodbath/galaxyline.nvim",
		branch = "main",
		config = function()
			require("config.galaxyline")
			-- require("galaxyline.themes.eviline")
		end,
		requires = "kyazdani42/nvim-web-devicons",
	})

	use({
		"rebelot/heirline.nvim",
		-- event = {"VimEnter"},
		config = function()
			require("config.heirline")
		end,
	})

	-- TODO: replace with something better
	use({
		"kyazdani42/nvim-tree.lua",
		config = require("config.tree").config,
		setup = require("config.tree").setup,
		cmd = { "NvimTreeToggle" },
	})

	use("elihunter173/dirbuf.nvim")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		opt = true,
		event = "BufRead",
		config = [[require("config.treesitter")]],
		requires = {
			-- "JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	})

	use({ "windwp/nvim-ts-autotag", opt = true, after = "nvim-treesitter" })
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		after = "nvim-treesitter",
	})

	-- Git
	use({
		{
			"tpope/vim-fugitive",
			config = function()
				local nnoremap = require("utils.mappers").nnoremap
				local vnoremap = require("utils.mappers").vnoremap
				local g = vim.g

				g.fugitive_gitlab_domains = { "https://gitlab.eu-west-1.mgmt.onfido.xyz/" }

				nnoremap({ "<leader>ge", ":GBrowse<CR>" })
				nnoremap({ "<leader>gy", ":GBrowse!<CR>" })
				vnoremap({ "<leader>ge", ":'<,'>GBrowse<CR>" })
				vnoremap({ "<leader>gy", ":'<,'>GBrowse!<CR>" })
				nnoremap({ "<leader>df", ":Gvdiffsplit origin/master<CR>" })
				nnoremap({ "<leader>dv", ":DiffviewOpen<CR>" })
				nnoremap({ "<leader>dm", ":DiffviewOpen origin/master<CR>" })
				nnoremap({ "<leader>fh", ":DiffviewFileHistory<CR>" })
				nnoremap({ "<leader>bc", ":DiffviewFileHistory<CR>" })
				nnoremap({ "<leader>dl", ":diffget //3<CR>" })
				nnoremap({ "<leader>dh", ":diffget //2<CR>" })
				nnoremap({ "<leader>gs", ":tab G<CR>" })
				nnoremap({ "<leader>gb", ":Git blame<CR>" })
				nnoremap({ "<leader>gc", ":GV<CR>" })
				nnoremap({ "<leader>dv", ":DiffviewOpen<CR>" })
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
				nnoremap({ "<leader>lg", ":LazyGit<CR>" })
			end,
			config = function()
				vim.g.lazygit_floating_window_use_plenary = 0
			end,
		},
	})
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({
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
						gs.blame_line({ full = true })
					end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					map("n", "<leader>td", gs.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	})

	-- Fennel
	use({ "Olical/aniseed", tag = "v3.16.0", disable = true })
	use("bakpakin/fennel.vim")
	use({
		disable = true,
		"rktjmp/hotpot.nvim",
		config = function()
			require("hotpot")
		end,
	})

	-- color schemes

	use({
		"folke/tokyonight.nvim",
		disable = true,
		config = function()
			vim.g.tokyonight_style = "night"
			vim.cmd("colorscheme tokyonight")
		end,
	})

	use({
		"rebelot/kanagawa.nvim",
		disable = false,
		-- config = function()
		--     vim.cmd("colorscheme kanagawa")
		-- end
	})

	use({
		"glepnir/zephyr-nvim",
		disable = true,
		config = function()
			require("zephyr")
			local zephyr = require("zephyr")
			zephyr.highlight("Tabline", { fg = zephyr.base6, bg = zephyr.base2 })
			zephyr.highlight("TabLineFill", { fg = zephyr.base6, bg = zephyr.base2 })
			zephyr.highlight("TabLineSel", { fg = zephyr.blue, bg = zephyr.bg })
			vim.cmd("colorscheme zephyr")
		end,
	})

	-- TODO: check
	-- use(
	--     {
	--         "TimUntersberger/neogit",
	--         cmd = "Neogit",
	--         config = function()
	--             require("config.neogit")
	--         end
	--     }
	-- )

	use({
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opt = true,
		config = function()
			require("zen-mode").setup({})
		end,
		setup = function()
			require("utils.mappers").nnoremap({ "<leader>ze", ":ZenMode<CR>", nil })
		end,
	})

	use({
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
		config = function()
			require("config.diffview")
		end,
	})

	use({
		"Shatur/neovim-session-manager",
		config = function()
			require("session_manager").setup({
				autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
			})
		end,
	})

	use({
		"bennypowers/nvim-regexplainer",
		keys = "gR",
		config = function()
			require("regexplainer").setup()
		end,
		requires = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
	})

	use({
		disable = true,
		"camspiers/snap",
		rocks = { "fzy" },
		config = function()
			require("config.snap")
		end,
	})
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
