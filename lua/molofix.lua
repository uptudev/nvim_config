-- Copyright (c) 2020-2021 shadmansaleh
-- Modified (c) 2023 uptu
-- MIT license, see LICENSE for more details.
-- stylua: ignore

-- Colour scheme
local colors = {
  black  = '#1e1f1c',
  gray   = '#808080',
  white  = '#f8f8f2',
  cyan   = '#66d9ef',
  green  = '#a6e22e',
  orange = '#ef5939',
  pink   = '#f92672',
  red    = '#ff0000',
  yellow = '#e6db74',
  brown  = '#dda55f',
}

-- Lualine theme, each mode designates modifications to the base theme
local molofix = {
  normal = {
    a = { fg = colors.black, bg = colors.cyan, gui = 'bold' },
    b = { fg = colors.black, bg = colors.pink },
    c = { fg = colors.orange, bg = NONE },
  },
  command = { a = { fg = colors.black, bg = colors.brown, gui = 'bold' } },
  insert = { a = { fg = colors.black, bg = colors.green, gui = 'bold' } },
  visual = { a = { fg = colors.black, bg = colors.yellow, gui = 'bold' } },
  replace = { a = { fg = colors.black, bg = colors.red, gui = 'bold' } },
  inactive = {
    a = { fg = colors.pink, bg = NONE, gui = 'bold' },
    b = { fg = colors.white, bg = colors.pink },
    c = { fg = colors.gray, bg = NONE },
  },
}

return molofix
