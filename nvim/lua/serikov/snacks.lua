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
    local keymap = vim.keymap
    local snacks = require("snacks")
    snacks.setup({
        picker = {
            enabled = true,
            ui_select = true,
        },
        image = { enabled = true },
        input = { enabled = true },
    })


    local picker_opts = {
        layout = { preset = "default", preview = true },
    }

    keymap.set(
        'n',
        '<leader><leader>',
        function()
            snacks.picker.files(picker_opts)
        end,
        { desc = 'Telescope find files' }
    )
    keymap.set(
        'n',
        '<leader>ff',
        function()
            snacks.picker.grep(picker_opts)
        end,
        { desc = 'Telescope find files' }
    )
    local stop_insert = require("additional.utils").stop_insert

    keymap.set("n", "<leader>e", function()
        ---@class snacks.picker.explorer.Config: snacks.picker.files.Config|{}
        snacks.picker.explorer({
            layout = { preset = "default", preview = true },
            on_show = stop_insert,
            auto_close = true,
        })
    end, { desc = "Open file (snack explorer)" })

    keymap.set(
        "n",
        "<leader>gs",
        function()
            snacks.picker.git_status({ on_show = stop_insert })
        end
    )
    keymap.set(
        "n",
        "<leader>b",
        function()
            snacks.picker.buffers({ on_show = stop_insert })
        end
    )

    -- snacks.scroll.enable()
    -- snacks.indent.enable()
end

return M
