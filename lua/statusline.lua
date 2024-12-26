vim.api.nvim_set_hl(0, "BubbleCol", { bg = "#181a23", fg = "#dddddd" })
vim.api.nvim_set_hl(0, "SepCol", { bg = "NONE", fg = "#181a23" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = "#7c7c7c" })

local lsep = " %#SepCol#"
local rsep = "%#SepCol# "

local split = "%="

local bubble = function(stuff)
	return table.concat({
		lsep,
		"%#BubbleCol#",
		" ",
		stuff,
		" ",
		rsep,
		"%#StatusLine#",
	})
end

local modes = {
	["n"] = " ",
	["no"] = " ",
	["v"] = "󰈈 ",
	["V"] = "󰈈 ",
	[""] = "󰈈 ",
	["s"] = "󰏫 ",
	["S"] = "󰏫 ",
	[""] = "󰏫 ",
	["i"] = "󰏫 ",
	["ic"] = "󰏫 ",
	["R"] = "󰛔 ",
	["Rv"] = "󰏫 ",
	["c"] = " ",
	["cv"] = " ",
	["r"] = "󰛔 ",
	["rm"] = " ",
	["r?"] = " ",
	["!"] = " ",
	["t"] = " ",
}

local get_lsp = function()
	local lsp_symbols = { Error = "󰅙 ", Info = "󰋼 ", Warn = " ", Hint = "" }
	local lsp_details = ""

	for type, sign in pairs(lsp_symbols) do
		local count = #vim.diagnostic.get(0, { severity = type })
		local hl = true and "%#DiagnosticSign" .. type .. "#" or " "
		local number = count > 0 and hl .. sign .. count .. " " or ""
		lsp_details = lsp_details .. number
	end

	return lsp_details .. "%#StatusLine#"
end

local file_icons = {
	typescript = " ",
	css = " ",
	scss = " ",
	javascript = " ",
	javascriptreact = " ",
	html = " ",
	python = " ",
	java = " ",
	markdown = " ",
	sh = " ",
	zsh = " ",
	vim = " ",
	lua = " ",
	haskell = " ",
	conf = " ",
	ruby = " ",
	txt = " ",
	rust = " ",
	cpp = " ",
	c = " ",
	go = " ",
}

local get_filetype = function()
	local ft = vim.bo.filetype
	if file_icons[ft] == nil then
		return ""
	end

	return file_icons[ft] .. " "
end

local lsp_names = function()
	local clients = { " LSP: [" }
	for index, client in ipairs(vim.lsp.get_clients()) do
		clients[index * 2] = client.name
		clients[index * 2 + 1] = ", "
	end

	local num = #clients
	if num == 1 then
		num = #clients + 1
	end

	clients[num] = "]"

	return table.concat(clients)
end

local function branch_name()
	local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
	if branch ~= "" then
		return branch
	else
		return ""
	end
end

vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "FocusGained" }, {
	callback = function()
		vim.b.branch_name = branch_name()
	end,
})

local math = require("math")

local get_statline = function()
	local mode = modes[vim.api.nvim_get_mode().mode]

	local branch = branch_name()
	local branch_component = ""
	if branch ~= "" then
		branch_component = bubble(branch)
	end

	local left = { bubble(mode), bubble(get_filetype() .. "%f"), branch_component }
	local middle = { get_lsp() }
	local right = { bubble("[%l:%c]"), bubble(lsp_names()) }

	local left_stat = table.concat(left)
	local middle_stat = table.concat(middle)
	local right_stat = table.concat(right)

	local statusline = left_stat .. "%=" .. middle_stat .. "%=" .. right_stat
	return statusline
end

vim.api.nvim_create_autocmd(
	{
		"UIEnter",
		"CursorHold",
		"FocusGained",
		"LspAttach",
		"BufWritePost",
		"BufEnter",
		"BufReadPost",
		"TabEnter",
		"TabClosed",
	},
	{
		callback = function()
			vim.o.statusline = get_statline()
		end,
	}
)
