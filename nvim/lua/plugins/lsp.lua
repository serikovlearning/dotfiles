vim.lsp.config("vtsls", {
    cmd = { "vtsls", "--stdio" },
    settings = {
        ["vtsls"] = {}
    }
})

vim.lsp.config("lua-language-server", {
    cmd = { "lua-language-server" },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            },
            workspace = {
                checkThirdParty = false,
            },
            codeLens = {
                enable = true,
            },
            completion = {
                callSnippet = "Replace",
            },
            doc = {
                privateName = { "^_" },
            },
            hint = {
                enable = true,
                setType = true,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
            },
        },
    }
})

vim.lsp.config("eslint", {
    cmd = { "eslint-lsp", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
    root_dir = vim.fn.getcwd,
    settings = {
        validate = "on",
        packageManager = "npm"
    },
    on_attach = function(client, bufnr)
        -- Run `EslintFixAll` before saving
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end
})

vim.lsp.enable("eslint")
vim.lsp.enable("lua-language-server")
vim.lsp.enable("vtsls")

-- Setup dignostics
local icons = require("config.icons")
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
    --  	signs = {
    -- 	active = false,
    -- 	values = {
    -- 		{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
    -- 		{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    -- 		{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    -- 		{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
    -- 	},
    -- },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = true
})


local bufnr = vim.api.nvim_get_current_buf()
vim.lsp.inlay_hint.enable()

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

        -- Define a local function to simplify keymapping
        local opts = { noremap = true, silent = true }
        local keymap = vim.api.nvim_buf_set_keymap

        keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover({border=\"rounded\"})<CR>", opts)
        keymap(bufnr, "n", "gR", "<cmd>lua vim.lsp.rename()<CR>", opts)
        keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    end,
})


vim.api.nvim_create_user_command("EslintFixAll", function()
    local params = vim.lsp.util.make_range_params()
    params.context = { diagnostics = vim.diagnostic.get(0) }

    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    for _, client in ipairs(clients) do
        if client.name == "eslint" then
            client.request("textDocument/codeAction", params, function(_, result)
                if result and result[1] then
                    vim.lsp.util.apply_workspace_edit(result[1].edit, client.offset_encoding)
                    if result[1].command then
                        vim.lsp.buf.execute_command(result[1].command)
                    end
                end
            end, 0)
        end
    end
end, {})


-- vim.keymap.set("n", "<leader>[", ":EslintFixAll<CR>", { desc = "Fix with ESLint" })
