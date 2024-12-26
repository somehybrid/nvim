local utils = require("utils")

local options = {
	number = true,
	relativenumber = true,
	termguicolors = true,

	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	expandtab = true,

	scrolloff = 8,
	swapfile = false,
}

local globals = {
	mapleader = " ",
}

utils.load_options(options, globals)

vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
	pattern = "*.rs",
	callback = function()
		io.popen("rusty-tags vi --quiet --start-dir=" .. vim.fn.getcwd())
		vim.api.nvim_set_option_value("tags", "./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi", { scope = "local" })
	end,
})
