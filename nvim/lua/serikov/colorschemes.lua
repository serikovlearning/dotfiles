local M = {
    "catppuccin/nvim", name = "catppuccin", priority = 1000
}
local C = {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("oldworld")
    end,
}

local B = {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
        vim.g.gruvbox_material_background = "hard" -- or "soft"/"hard"
        vim.g.gruvbox_material_foreground = "mix" -- or "mix"/"original"
        vim.g.gruvbox_material_enable_bold = 1
        vim.g.gruvbox_material_enable_italic = 1
        vim.g.gruvbox_material_ui_contrast = "high"
        -- vim.cmd.colorscheme("gruvbox-material")
    end,
}

function M.config()
    require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        background = {         -- :h background
            light = "latte",
            dark = "mocha",
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
        term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
            enabled = true,             -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.85,          -- percentage of the shade to apply to the inactive window
        },
        no_italic = false,              -- Force no italic
        no_bold = false,                -- Force o bold
        no_underline = false,           -- Force no underline
        styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" },    -- Change the style of comments
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
            -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = false,
            mini = {
                enabled = true,
                indentscope_color = "",
            },
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
    })
end

return { C, M, B }
