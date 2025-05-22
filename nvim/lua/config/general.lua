vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- opts
local opt = vim.opt

opt.termguicolors = true            -- True color support
opt.smartcase = true                -- Don't ignore case with capitals
opt.spelllang = { "en", "ru" }
opt.updatetime = 200                -- Save swap file and trigger CursorHold

opt.fillchars:append({ eob = " " }) -- 'eob' = End Of Buffer

opt.clipboard = "unnamedplus"

opt.number = true
opt.signcolumn = "auto"
opt.cursorline = true
opt.wrap = true

-- scrolling
opt.scrolloff = 8 -- is one of my fav
opt.sidescrolloff = 8

-- saves
opt.showmode = false
opt.swapfile = false
opt.undofile = true     -- enable persistent undo
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages

opt.undofile = true
opt.backup = false

-- TABS
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true   -- convert tabs to spaces
opt.smartindent = true -- make indenting smarter again
opt.showtabline = 1


-- remove trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.cmd([[%s/\s\+$//e]])
    end,
})
