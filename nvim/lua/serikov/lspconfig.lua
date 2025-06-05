local M = { "neovim/nvim-lspconfig" }

function M.config()
    vim.lsp.config("*", {
        settings = {}
        -- codeActionsOnSave = {
        --     -- If you want some of these to trigger on save
        --     -- You can enable them individually here
        --     source = {
        --         organizeImports = true,
        --         removeUnused = true,
        --     },
        -- },
    })
    vim.lsp.enable({
        "lua_ls",
        "vtsls",
    })

    -- Setup dignostics
    local icons = require("additional.icons")
    local util = vim.lsp.util


    vim.diagnostic.config({
        virtual_text = {
            spacing = 2,
            prefix = function(diagnostic)
                local severity = vim.diagnostic.severity
                local icons_map = {
                    [severity.ERROR] = icons.diagnostics.Error,
                    [severity.WARN] = icons.diagnostics.Warning,
                    [severity.INFO] = icons.diagnostics.Information,
                    [severity.HINT] = icons.diagnostics.Hint,
                }
                return icons_map[diagnostic.severity] or "•"
            end,
        },
        signs = false,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = true
    })


    -- formattings
    vim.keymap.set(
        'n',
        'gf',
        function()
            vim.lsp.buf.format({ async = true })
        end
    )


    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            -- Get the buffer number
            local bufnr = args.buf
            local snacks = require("snacks")
            local stop_insert = require("additional.utils").stop_insert

            -- Define a local function to simplify keymapping
            local keymap = vim.keymap.set
            local opts = { buffer = bufnr, noremap = true, silent = true }

            keymap("n", "gD", function()
                snacks.picker.lsp_declarations({
                    on_show = stop_insert
                })
            end
            , opts)
            keymap("n", "gd", function()
                snacks.picker.lsp_definitions({
                    on_show = stop_insert
                })
            end, opts)
            keymap("n", "gr", function()
                snacks.picker.lsp_references({
                    on_show = stop_insert
                })
            end, opts)
            keymap("n", "gdb", function()
                snacks.picker.diagnostics_buffer({
                    on_show = stop_insert
                })
            end, opts)
            -- keymap("n", "gd", function() snacks.picker.lsp_definitions() end, opts)
            -- keymap("n", "gr", function() snacks.picker.lsp_references() end, opts)
            keymap("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
            keymap("n", "gR", vim.lsp.buf.rename, opts)
            keymap("n", "gI", vim.lsp.buf.implementation, opts)
            keymap("n", "gl", vim.diagnostic.open_float, opts)
            keymap("n", "g.", vim.lsp.buf.code_action, opts)
            -- keymap("n", "g.", vim.lsp.handlers(), opts)
            -- keymap("n", "g.", function()
            --     snacks.picker.({
            --         on_show = stop_insert,
            --         filter
            --     })
            -- end, opts)
         keymap("n", "g]", vim.diagnostic.goto_next, opts)
            keymap("n", "g[", vim.diagnostic.goto_prev, opts)
        end,
    })
end

return M
