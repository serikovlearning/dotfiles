local M = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
}

function M.config()
    local servers = {
        "lua_ls",
        "vtsls"
    }

    require("mason").setup({
        ui = {
            border = "rounded",
        },
    })
    local m = require("mason-lspconfig")
    m.setup({
        ensure_installed = servers,
        automatic_installation = true,
    })
    -- m.setup_handlers({
    --     function(name)
    --         vim.lsp.enable(name)
    --     end,
    -- })
end

return M
