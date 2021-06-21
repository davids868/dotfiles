local mapper = function(t, mode)
    local defaults = {noremap = true, silent = true}
    local opts = t[3] or defaults

    vim.api.nvim_set_keymap(mode, t[1], t[2], opts)
end

local nnoremap = function(t)
    mapper(t, "n")
end

local inoremap = function(t)
    mapper(t, "i")
end

local vnoremap = function(t)
    mapper(t, "v")
end

local xnoremap = function(t)
    mapper(t, "x")
end

local cnoremap = function(t)
    mapper(t, "c")
end

local map = function(t)
    t[3] = {silent = true}
    mapper(t, "")
end

return {
    map = map,
    nnoremap = nnoremap,
    inoremap = inoremap,
    vnoremap = vnoremap,
    xnoremap = xnoremap,
    cnoremap = cnoremap
}
