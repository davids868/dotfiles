function _G.new_tab()
  local ft = vim.bo.filetype
  vim.api.nvim_command ":tabnew"
  vim.api.nvim_buf_set_option(0, "filetype", ft)
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

local units = {
  ["seconds"] = 1,
  ["milliseconds"] = 1000,
  ["microseconds"] = 1000000,
  ["nanoseconds"] = 1000000000,
}

-- USAGE: benchmark("milliseconds", 2, 500, test, 10000)
function benchmark(unit, decPlaces, n, f, ...)
  local elapsed = 0
  local multiplier = units[unit]
  for i = 1, n do
    local now = os.clock()
    f(...)
    elapsed = elapsed + (os.clock() - now)
  end
  print(
    string.format(
      "Benchmark results: %d function calls | %."
        .. decPlaces
        .. "f %s elapsed | %."
        .. decPlaces
        .. "f %s avg execution time.",
      n,
      elapsed * multiplier,
      unit,
      (elapsed / n) * multiplier,
      unit
    )
  )
end
