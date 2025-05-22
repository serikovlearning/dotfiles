local M = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
}

function M.config()
    local snacks = require("snacks")
    snacks.dim.enable()
    -- snacks.scroll.enable()
    -- snacks.indent.enable()
end

return M
