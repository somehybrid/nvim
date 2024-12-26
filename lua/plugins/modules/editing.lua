-- general editing and stuff

return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"nvim-telescope/telescope.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},

		cmd = "Telescope",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Find word" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Recent history" },
			{ "<leader>fb", "<cmd>Telescope file_browser<CR>", desc = "Browse files" },
		},

		opts = {
			defaults = {
				file_ignore_patterns = { "target" },
				color_devicons = true,
				prompt_prefix = "   ",
			},

			extensions = {
				fzy_native = {
					override_generic_sorter = false,
					override_file_sorter = true,
				},
			},
		},

		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)

			telescope.load_extension("file_browser")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		cmd = "TSInstall",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "python", "rust" },
			})
		end,
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},

		config = true,
		cmd = "Neogit",
	},
}
