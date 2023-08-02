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
            require('nvim-ts-autotag').setup()
        end,
    },

    {
        "nvim-telescope/telescope.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-fzy-native.nvim",
        },

        cmd = "Telescope",
        keys = {
            { "<leader>ff",       "<cmd>Telescope find_files<CR>",   desc = "Find files", },
            { "<leader>fg",       "<cmd>Telescope live_grep<CR>",    desc = "Find word", },
            { "<leader>fo",       "<cmd>Telescope oldfiles<CR>",     desc = "Recent history", },
            { "<leader>fb",       "<cmd>Telescope file_browser<CR>", desc = "Browse files", },
        },

        opts = {
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--vimgrep",
                },
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },

                color_devicons = true,
                prompt_prefix = "   ",
            },

            extensions = {
                fzy_native = {
                    override_generic_sorter = false,
                    override_file_sorter = true,
                },
            }
        },

        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)

            telescope.load_extension("file_browser")
            telescope.load_extension("fzy_native")
        end,
    },

    {
        "folke/trouble.nvim",
        event = "LspAttach",
    },

    {
        "nvim-treesitter/nvim-treesitter",
        cmd = "TSInstall",
        event = { "BufReadPost", "BufNewFile", },

        build = function()
            require("nvim-treesitter.install").update()
        end,

        config = function()
            require("nvim-treesitter.configs").setup({
                sync_install = false,
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                }
            })
        end,
    },

    {
        "andweeb/presence.nvim",
        event = { "BufReadPost", "BufNewFile", },

        config = function()
            require("presence").setup({
                neovim_imagine_text = "Neovim",
            })
        end,
    },

    {
        "michaelb/sniprun",
        run = "bash ./install.sh",
        cmd = "SnipRun",
        keys = {
            { "<leader>rs", "<cmd>SnipRun<CR>", desc = "Run snippet", mode = { "v", "n" } },
        },
    },

    {
        "CRAG666/code_runner.nvim",
        cmd = "RunCode",
        keys = {
            { "<leader>rf", "<cmd>RunCode<CR>", desc = "Run file", },
        },

        opts = {
            filetype = {
                python = "python -u",
            }
        },
        config = function(_, opts)
            require("code_runner").setup(opts)
        end,
    }
}
