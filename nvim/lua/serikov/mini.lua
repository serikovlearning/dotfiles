local M = { 'echasnovski/mini.nvim', version = '*' }


function M.config()
    require("mini.icons").setup()
    require("mini.comment").setup()
    require("mini.git").setup()
end

return M
