local utils = require("utils")

vim.keymap.set("n", "<leader>grn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>gri", vim.lsp.buf.implementation)
