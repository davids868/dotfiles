local M = {}

function M.setup()
    require("neorg").setup {
        load = {
            ["core.integrations.telescope"] = {},
            ["core.defaults"] = {},
            ["core.keybinds"] = {
                config = {
                    default_keybinds = true,
                    neorg_leader = "<leader>o"
                }
            },
            ["core.norg.concealer"] = {}, -- Allows for use of icons
            ["core.norg.dirman"] = {
                -- Manage your directories with Neorg
                config = {
                    workspaces = {
                        my_workspace = "~/neorg"
                    }
                }
            }
        }
    }
end

return M
