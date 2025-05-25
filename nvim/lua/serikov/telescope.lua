local M = { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } }
local MB = { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } }
-- local MS = { "nvim-telescope/telescope-ui-select.nvim" }

local function vsplit_and_callback(fn)
    vim.cmd("only")
    vim.cmd("vsplit")
    vim.cmd("wincmd L")
    fn()
end

local keymap = vim.keymap

function M.config()
    local telescope = require('telescope')
    local telescope_builtin = require('telescope.builtin')
    -- telescope.load_extension("telescope-ui-select")
    --
    local telescope_themes = require("telescope.themes")
    telescope.setup({
        defaults = {
            -- prompt_position = 'top',
            -- layout_strategy = 'horizontal',
            sorting_strategy = 'ascending',
            -- use_less = false
        },
        pickers = {
            find_files = { hidden = true }
        },
        extensions = {
            -- ["ui-select"] = {
            --     telescope_themes.get_cursor {
            --     }
            -- },
            ["file_browser"] = {
                grouped = true,
                respect_gitignore = false,
                mappings = {
                    ["i"] = {
                        ["<C-l>"] = function(prompt_bufnr)
                            local action_state = require("telescope.actions.state")
                            local actions = require("telescope.actions")
                            local entry = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            vsplit_and_callback(function()
                                vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
                            end)
                        end,
                    },
                    ["n"] = {
                        ["<C-l>"] = function(prompt_bufnr)
                            local action_state = require("telescope.actions.state")
                            local actions = require("telescope.actions")
                            local entry = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            vsplit_and_callback(function()
                                vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
                            end)
                        end,
                    },
                },
            }
        }
    })
    -- telescope.load_extension("ui-select")
    telescope.load_extension("file_browser")
    keymap.set(
        'n',
        '<leader><leader>',
        function()
            telescope_builtin.find_files()
        end,
        { desc = 'Telescope find files' }
    )
    keymap.set(
        'n',
        '<leader>ff',
        function()
            telescope_builtin.live_grep()
        end,
        { desc = 'Telescope find files' }
    )
    local call_with_normal = require("additional.utils").call_with_normal
    keymap.set(
        "n",
        "<leader>e",
        call_with_normal(
            function()
                telescope.extensions.file_browser.file_browser({
                    path = vim.fn.expand("%:p:h"),
                    select_buffer = true
                })
            end
        )
    )

    keymap.set(
        "n",
        "<leader>gs",
        call_with_normal(
            function()
                telescope_builtin.git_status()
            end
        )
    )
end

-- return { MS, M, MB }
return {  M, MB }
-- return vim.tbl_extend("force", M, MB)
