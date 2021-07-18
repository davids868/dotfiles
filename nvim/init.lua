local modules = {"core", "plugins", "config", "utils"}

local load = require

if pcall(require, "plenary") then
    local reload = require("plenary.reload").reload_module

    load = function(name)
        if pcall(require, module) then
            reload(name)
        end
        return require(name)
    end
end

for _, module in ipairs(modules) do
    load(module)
end

-- require("core")
-- require("config")
-- require("plugins")
-- require("utils")
