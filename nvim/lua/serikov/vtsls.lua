local M = { "yioneko/nvim-vtsls" }

function M.config()
    -- require("vtsls").commands.source_actions()
    vim.keymap.set(
        "n",
        "gn",
        function()
            require("vtsls").commands.source_actions()
        end
    )
end

return M
