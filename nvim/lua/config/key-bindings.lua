local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')

local stop_insert = function()
    vim.schedule(
        function()
            vim.cmd("stopinsert")
        end
    )
end


vim.keymap.set(
    'n',
    '<leader><leader>',
    function()
        telescope_builtin.find_files()
        stop_insert()
    end,
    { desc = 'Telescope find files' }
)
vim.keymap.set(
    'n',
    '<leader>ff',
    function()
        telescope_builtin.live_grep()
        stop_insert()
    end,
    { desc = 'Telescope find files' }
)

vim.keymap.set(
    "n",
    "<leader>e",
    function()
        telescope.extensions.file_browser.file_browser({
            path = vim.fn.expand("%:p:h"),
            select_buffer = true
        })
        stop_insert()
    end
)
