local M = {}

M.icons = {
	types = {
		Array = " ",
		Boolean = " ",
		Class = " ",
		Color = " ",
		Constant = " ",
		Constructor = " ",
		Copilot = " ",
		Enum = " ",
		EnumMember = " ",
		Event = " ",
		Field = " ",
		File = " ",
		Folder = " ",
		Function = " ",
		Interface = " ",
		Key = " ",
		Keyword = " ",
		Method = " ",
		Module = " ",
		Namespace = " ",
		Null = " ",
		Number = " ",
		Object = " ",
		Operator = " ",
		Package = " ",
		Property = " ",
		Reference = " ",
		Snippet = " ",
		String = " ",
		Struct = " ",
		Text = " ",
		TypeParameter = " ",
		Unit = " ",
		Value = " ",
		Variable = " ",
	},
	diagnostics = {
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
	},
	git = {
		added = " ",
		modified = " ",
		removed = " ",
	},
}

local function keymap(mode, lhs, rhs, opts)
	opts = opts or {}
	opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end

M.load_mappings = function(mappings)
	for mode, map in pairs(mappings) do
		for lhs, rhs in pairs(map) do
			local keys = { lhs }
			local values = { rhs }

			while #keys > 0 do
				local current_lhs = table.remove(keys)
				local current_rhs = table.remove(values)

				if current_rhs[1] then
					keymap(mode, current_lhs, current_rhs[1], current_rhs.opts or {})
				else
					for sub_lhs, sub_rhs in pairs(current_rhs) do
						table.insert(keys, current_lhs .. sub_lhs)
						table.insert(values, sub_rhs)
					end
				end
			end
		end
	end
end

M.load_options = function(options, globals)
	for key, value in pairs(options) do
		vim.opt[key] = value
	end

	for key, value in pairs(globals) do
		vim.g[key] = value
	end
end

return M
