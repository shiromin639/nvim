vim.g.mapleader = " "
vim.keymap.set("n", "<leader>nx", vim.diagnostic.goto_next) -- next err
vim.keymap.set("n", "<leader>px", vim.diagnostic.goto_prev) -- previous err
vim.keymap.set("n", "<leader>x", vim.diagnostic.open_float)
