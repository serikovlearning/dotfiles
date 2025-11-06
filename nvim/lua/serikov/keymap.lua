local keymap = vim.keymap

keymap.set(
    "n",
    "<leader>w",
    "<C-w>"
)

-- Made shift+tab movement like in vscode / zed / etc
keymap.set("i", "<S-Tab>", "<C-\\><C-N><<<C-\\><C-N>^i")
