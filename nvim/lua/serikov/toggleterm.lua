local M = { 'akinsho/toggleterm.nvim', version = "*", config = true }

function M.config()
    require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "float",
        size = function(term)
            if term.direction == "horizontal" then
                return 10
            end
        end,
    })
end

return M
