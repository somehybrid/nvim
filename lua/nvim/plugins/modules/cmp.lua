return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "ray-x/cmp-treesitter",
            "lukas-reineke/cmp-rg",

            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp",

                dependencies = {
                    "rafamadriz/friendly-snippets",
                    "saadparwaiz1/cmp_luasnip",
                },

                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load({})
                end,
            },

            {
                "jcdickinson/codeium.nvim",
                cmd = "Codeium",
                dependencies = "nvim-lua/plenary.nvim",

                config = function()
                    require("codeium").setup({})
                end
            },

            {
                "zbirenbaum/copilot.lua",
                dependencies = "zbirenbaum/copilot-cmp",

                config = function()
                    require("copilot").setup({
                        suggestion = { enabled = false, },
                        panel = { enabled = false, },
                    })
                    require("copilot_cmp").setup({})
                end,
            },
        },

        opts = function()
            local cmp = require("cmp")
            return {
                completion = {
                    completeopt = "menu,menuone,noselect",
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<S-CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                }),
                sources = cmp.config.sources({
                    { name = "codeium",    priority = 1000, },
                    { name = "copilot",    priority = 1000, },
                    { name = "nvim_lsp",   priority = 1000, },
                    { name = "treesitter", priority = 800, },
                    { name = "rg",         priority = 600, },
                    { name = "luasnip",    priority = 400, },
                    { name = "path",       priority = 200, },
                }),
                formatting = {
                    format = function(entry, item)
                        local icons = require("nvim.utils.icons")

                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end

                        item.menu = ({
                            buffer = "≡",
                            nvim_lsp = "",
                            luasnip = "",
                            treesitter = "",
                            rg = "",
                            codeium = "{...}",
                            copilot = "󰊤",
                        })[entry.source.name]

                        return item
                    end,
                },
            }
        end,
    },
}
