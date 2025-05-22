return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    { -- optional blink completion source for require statements and module annotations
        "saghen/blink.cmp",
        opts = {
            completion = {
                menu = {
                    auto_show = false,
                },
            },
            sources = {
                -- add lazydev to your completion providers
                default = { "buffer", "lsp", "path", "snippets", "lazydev", },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },
        },
    }
    -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
