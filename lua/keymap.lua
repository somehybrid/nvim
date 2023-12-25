local utils = require("utils")

local telescope = require("telescope.builtin")

local keymaps = {
  n = {
    ["<leader>"] = {
      -- LSP
      pd = {
        "<cmd>Lspsaga preview_definition<CR>",
        opts = {
          desc = "Preview definition"
        },
      },
      g = {
        d = {
          "<cmd>Lspsaga goto_definition<CR>",
          opts = {
            desc = "Goto definition"
          },
        },
        r = {
          "<cmd>Lspsaga rename<CR>",
          opts = {
            desc = "Rename"
          },
        },
      },

      ["<Tab>"] = {
        ["1"] = {
          "<cmd>tabfirst<cr>",
          opts = {
            desc = "First tab"
          },
        },
        ["9"] = {
          "<cmd>tablast<cr>",
          opts = {
            desc = "Last tab"
          },
        },
        ["<Right>"] = {
          "<cmd>tabnext<cr>",
          opts = {
            desc = "Next Tab"
          },
        },
        ["<Left>"] = {
          "<cmd>tabprevious<cr>",
          opts = {
            desc = "Previous Tab"
          },
        },
      },

      k = {
        'v:count ? "k" : "gk"',
        opts = {
          expr = true,
          desc = "Move up"
        },
      },
      j = {
        'v:count ? "j" : "gj"',
        opts = {
          expr = true,
          desc = "Move down"
        },
      },
    },
  },

  v = {
    k = {
      'v:count ? "k" : "gk"',
      opts = {
        expr = true,
        desc = "Move up"
      },
    },
    j = {
      'v:count ? "j" : "gj"',
      opts = {
        expr = true,
        desc = "Move down"
      },
    },
  },
}

utils.load_mappings(keymaps)
