return {
	{
		"folke/tokyonight.nvim",
        lazy = false,
		priority = 1000,

		config = function(_, opts)
			require("tokyonight").setup({
				transparent = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
				on_highlights = function(hl, colors)
					hl.LineNr = { fg = "#909090" }
					hl.LineNrAbove = { fg = "#656565" }
					hl.LineNrBelow = { fg = "#656565" }
				end,
			})
			require("tokyonight").load({ style = "moon" })
		end,
	},

	{
		"goolord/alpha-nvim",
		event = "VimEnter",

		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
                ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
                ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
                ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
                ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
                ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
                ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
            ]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", "<cmd>Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", "<cmd>ene <BAR> startinsert <CR>"),
				dashboard.button("r", " " .. " Suggested files", "<cmd>Telescope frecency <CR>"),
				dashboard.button("g", " " .. " Find text", "<cmd>Telescope live_grep <CR>"),
			}
			return dashboard
		end,

		config = function(_, dashboard)
			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
					dashboard.section.footer.val = stats.count .. " plugins loaded in " .. ms .. "ms"
					require("alpha").redraw()
				end,
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufEnter",
		opts = {
			indent = { char = "│" },
		},
		config = function()
			require("ibl").setup()
		end,
	},

	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			symbol = "│",
			options = { try_as_border = true },
			show_current_context = true,
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
}
