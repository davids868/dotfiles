if not pcall(require, "telescope") then
  return
end

local cnoremap = require("utils.mappers").cnoremap
local vnoremap = require("utils.mappers").vnoremap
local nnoremap = require("utils.mappers").nnoremap
local pickers = require "config.telescope.pickers"

cnoremap { "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { nowait = true } }

vnoremap { "<leader>F", pickers.grep_curr_string }
nnoremap { "<leader>fl", pickers.current_buffer_fuzzy_find }
nnoremap { "<leader>fp", pickers.grep_prompt }
nnoremap { "<leader>fw", pickers.grep_curr_string }
nnoremap { "<leader>/", pickers.grep_last_search }
nnoremap { "<leader>F", pickers.live_grep }
nnoremap { "<leader>,", pickers.edit_neovim }
nnoremap { "<leader>p", pickers.git_files }
nnoremap { "<leader>o", pickers.find_files }
nnoremap { "<leader>go", pickers.git_branches }
nnoremap { "<leader><space>", pickers.commands }
nnoremap { "<leader>gr", pickers.lsp_references }
nnoremap { "<leader>D", pickers.diagnostics }
nnoremap { "<leader>s", pickers.current_buffer_tags }
nnoremap { "<leader>S", pickers.tags }
nnoremap { "<leader>ht", pickers.help_tags }
nnoremap { "<leader>ho", pickers.vim_options }
nnoremap { "<leader>tl", pickers.builtin }
nnoremap { "<leader>tr", pickers.resume }
nnoremap { "<leader>ft", pickers.filetypes }
