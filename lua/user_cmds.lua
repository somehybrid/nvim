local function update_mason()
	local registry = require("mason-registry")
	registry.update()
	local packages = registry.get_all_packages()
	for _, package in pairs(packages) do
		package:install()
	end
end

vim.api.nvim_create_user_command("MasonUpdateAll", function()
	update_mason()
end, {})

vim.api.nvim_create_user_command("Update", function()
	vim.cmd("MasonUpdateAll")
	require("lazy").sync()
end, {})
