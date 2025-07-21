local M = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = {
            enabled = true,
            ui_select = true,
        }
    },
}

function M.config()
    -- local snacks = require("snacks")
    -- snacks.scroll.enable()
    -- snacks.indent.enable()
end

return M
