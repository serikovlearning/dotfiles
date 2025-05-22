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
    require("neotest").setup({
        adapters = {
            require('neotest').setup({
                adapters = {
                    require('neotest-jest')({
                        jestCommand = "npm test --",
                        jestConfigFile = "custom.jest.config.ts",
                        env = { CI = true },
                        cwd = function(path)
                            return vim.fn.getcwd()
                        end,
                    }),
                }
            }),
            require("neotest-vitest")({
                dap = { justMyCode = false },
            }),

        },
    })
end

return M
