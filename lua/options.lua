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
}

local globals = {
  mapleader = " ",
}

utils.load_options(options, globals)
