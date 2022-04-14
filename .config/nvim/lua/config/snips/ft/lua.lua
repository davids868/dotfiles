local ls = require "luasnip"

local t = ls.text_node

local newline = function(text)
  return t { "", text }
end

return {
  M = {
    desc = "Module declarations",
    "local M = {}",
    newline "return M",
  },
}
