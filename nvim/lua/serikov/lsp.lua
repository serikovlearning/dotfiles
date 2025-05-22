vim.lsp.config("vtsls", {
    cmd = {"vtsls", "--stdio"}
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
        -- keymap(bufnr, "n", "g.", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    end,
})
