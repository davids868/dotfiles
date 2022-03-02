local load_modules = function()
    require("config.git")
end

local bind_mappings = function()
    local nnoremap = require("utils.mappers").nnoremap
    local vnoremap = require("utils.mappers").vnoremap

    nnoremap {"<leader>u", ":UndotreeToggle<CR>"}
    nnoremap {"<leader>z", ":ZenMode<CR>"}
    nnoremap {"<leader>n", ":NvimTreeToggle<CR>"}
    nnoremap {"<leader>L", ":Neoformat<CR>"}
    nnoremap {"<leader>R", ":lua require('spectre').open()<CR>"}
    nnoremap {"<leader>is", ":ISwapWith<CR>"}
    nnoremap {"<C-w>m", ":WinShift<CR>"}
    nnoremap {"<C-w><C-m>", ":WinShift<CR>"}

    nnoremap {"<leader>mp", ":MarkdownPreview<CR>"}

    nnoremap {"<leader>hh", ":lua require('harpoon.ui').toggle_quick_menu()<CR>"}
    nnoremap {"<leader>ha", ":lua require('harpoon.mark').add_file()<CR>"}
    nnoremap {"<leader>hm", ":lua require('harpoon.ui').nav_file(1)<CR>"}
    nnoremap {"<leader>h,", ":lua require('harpoon.ui').nav_file(2)<CR>"}
    nnoremap {"<leader>h.", ":lua require('harpoon.ui').nav_file(3)<CR>"}
    nnoremap {"<leader>hj", ":lua require('harpoon.ui').nav_file(4)<CR>"}
    nnoremap {"<leader>hk", ":lua require('harpoon.ui').nav_file(5)<CR>"}
    nnoremap {"<leader>hl", ":lua require('harpoon.ui').nav_file(6)<CR>"}
    nnoremap {"<leader>hu", ":lua require('harpoon.ui').nav_file(7)<CR>"}
    nnoremap {"<leader>hi", ":lua require('harpoon.ui').nav_file(8)<CR>"}
    nnoremap {"<leader>ho", ":lua require('harpoon.ui').nav_file(9)<CR>"}

    nnoremap {"<leader>v", ":SymbolsOutline<CR>"}

    nnoremap {"s", "<cmd>Pounce<CR>"}
    nnoremap {"S", "<cmd>PounceRepeat<CR>"}
    vnoremap {"s", "<cmd>Pounce<CR>"}
end

local load_config = function()
    load_modules()
    bind_mappings()
end

load_config()
