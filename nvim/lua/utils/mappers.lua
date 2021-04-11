local mapper = function(t)
    local lhs = t[1] or t.lhs
    local rhs = t[2] or t.rhs
    local opts = t[3] or t.opts or {noremap = true, silent = true}
    local is_global = t[4] or t.is_global or true
    local mode = t[5] or t.mode or "n"

    if mode == "v" then
        rhs = "<cmd>'<,'>lua " .. rhs .. "<CR>"
    else
        rhs = "<cmd>lua " .. rhs .. "<CR>"
    end

    if is_global then
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    else
        vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
    end
end

local nnoremap = function(t)
    t.mode = "n"
    mapper(t)
end

local inoremap = function(t)
    t.mode = "i"
    mapper(t)
end

local vnoremap = function(t)
    t.mode = "v"
    mapper(t)
end

return {
    nnoremap = nnoremap,
    inoremap = inoremap,
    vnoremap = vnoremap
}
