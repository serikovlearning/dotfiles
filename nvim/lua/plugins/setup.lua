return {
    { 'nvim-telescope/telescope.nvim',              tag = '0.1.8',                                                              dependencies = { 'nvim-lua/plenary.nvim' } },
    { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } },
    { "catppuccin/nvim",                            name = "catppuccin",                                                        priority = 1000 },
    { "nvim-treesitter/nvim-treesitter",            build = ":TSUpdate" },
    { "neovim/nvim-lspconfig" },
    { "mason-org/mason.nvim" },
    { 'stevearc/conform.nvim',                      opts = {} },
    { 'echasnovski/mini.nvim',                      version = '*' },
    -- { "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } }
    -- {
  -- "nvimtools/none-ls.nvim",
  -- dependencies = {
    -- "nvimtools/none-ls-extras.nvim",
  -- }

}
