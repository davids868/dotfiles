local parent_module = "dap"
local modules = { "core", "plugins", "utils" }

local load = require

if pcall(require, "plenary") then
	local reload = require("plenary.reload").reload_module

	load = function(name)
		if pcall(require, module) then
			print("reloading: " .. name)
			reload(name)
		end
		return require(name)
	end
end

for _, module in ipairs(modules) do
	load(module)
	-- load(parent_module .. "." .. module)
end

-- require("core")
-- require("config")
-- require("plugins")
-- require("utils")
