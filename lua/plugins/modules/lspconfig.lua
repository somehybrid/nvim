return {
	{
		"neovim/nvim-lspconfig",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"Update",
			"MasonUpdateAll",
			"LspInstall",
			"LspUninstall",
			"DapInstall",
			"DapUninstall",
		},

		event = { "BufReadPre", "BufNewFile" },

		dependencies = {  -- much dependencies
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"lukas-reineke/lsp-format.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},

		init = function()
			vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)
			vim.keymap.set("n", "<leader>dc", require("dap").continue)
			vim.keymap.set("n", "<leader>ds", require("dap").step_over)
            vim.keymap.set("n", "<leader>dr", require("dap").repl.open)
		end,

		config = function()
			-- mason
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "󰗠 ",
						package_pending = " ",
						package_uninstalled = " ",
					},
				},
				max_concurrent_installers = 20, -- install ALL the packages
			})

			-- LSP
			local mlsp = require("mason-lspconfig")
			local lspconfig = require("lspconfig")

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			mlsp.setup()
			local attach = require("lsp-format").on_attach
			mlsp.setup_handlers({
				function(server)
					lspconfig[server].setup({
						capabilities = capabilities,
						on_attach = attach,
					})
				end,
			})

			require("lsp_lines").setup()
			vim.diagnostic.config({
				virtual_text = false,
			})

			-- DAP
			require("mason").setup()
			require("mason-nvim-dap").setup()

			local dap = require("dap")
			dap.configurations = {
				c = {
					{
						type = "codelldb",
						name = "C Debugger",
						request = "launch",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
						stopOnEntry = false,
					},
				},
				python = {
					{
						type = "python",
						name = "Python Debugger",
						request = "launch",
						program = "${file}",
					},
				},
			}

			local adapterdir = vim.fn.stdpath("data") .. "/mason/bin/"

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = adapterdir .. "codelldb",
					args = { "--port", "${port}" },
				},
			}

			dap.adapters.python = {
				type = "server",
				port = "${port}",
				executable = {
					command = adapterdir .. "debugpy",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}
		end,
	},

	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = "nvim-tree/nvim-web-devicons",

		keys = {
			{ "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "Go to definition" },
			{ "gp", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek definition" },
		},

		config = function()
			require("lspsaga").setup({})
		end,
	},
}
