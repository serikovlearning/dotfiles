local M = {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "marilari88/neotest-vitest",
        "nvim-neotest/neotest-jest",
    }
}

function M.config()
    local neotest = require('neotest')
    neotest.setup({
        adapters = {
            require('neotest-jest')({
                jestCommand = "npm run test --",
                jestConfigFile = "custom.jest.config.ts",
                env = { CI = true },
                cwd = function(path)
                    return vim.fn.getcwd()
                end,
            }),
        }
    })


    local keymap = vim.keymap

    keymap.set(
        "n",
        "<leader>nt",
        function()
            neotest.run.run()
        end
    )
    keymap.set(
        "n",
        "<leader>ns",
        function()
            neotest.summary.toggle()
        end
    )
    keymap.set(
        "n",
        "<leader>nw",
        function()
            -- neotest.watch.toggle(vim.fn.expand("%"))
            neotest.watch.toggle()
        end
    )
end

return M
