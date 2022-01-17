local set = vim.keymap.set

local defaults = {silent = true}

local mapper = function(t, mode)
    local opts = t[3] or defaults

    set(mode, t[1], t[2], opts)
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

TelescopeMapArgs = TelescopeMapArgs or {}

local telemap = function(mode, key, f, options, buffer)
    local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

    TelescopeMapArgs[map_key] = options or {}

    local rhs = string.format("<cmd>lua require('config.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

    if not buffer then
        set(mode, key, rhs, defaults)
    else
        set(0, mode, key, rhs, {silent = true, buffer = 0})
    end
end

return {
    map = map,
    nnoremap = nnoremap,
    inoremap = inoremap,
    vnoremap = vnoremap,
    xnoremap = xnoremap,
    cnoremap = cnoremap,
    telemap = telemap
}
