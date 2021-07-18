local load_modules = function()
    require("config.git")
end

local bind_mappings = function()
    local nnoremap = require("utils.mappers").nnoremap
    local inoremap = require("utils.mappers").inoremap
    local opts = {noremap = true, silent = true, expr = true}

    nnoremap {"<leader>u", ":UndotreeToggle<CR>"}
    nnoremap {"<leader>z", ":ZenMode<CR>"}
    nnoremap {"<leader>n", ":NvimTreeToggle<CR>"}
    nnoremap {"<leader>L", ":Neoformat<CR>"}
    nnoremap {"<leader>R", ":lua require('spectre').open()<CR>"}

    inoremap {"<C-Space>", "compe#complete()", opts}
    inoremap {"<CR>", "compe#confirm('<CR>')", opts}
    inoremap {"<C-e>", "compe#close('<C-e>')", opts}
end

local load_config = function()
    load_modules()
    bind_mappings()
end

load_config()
