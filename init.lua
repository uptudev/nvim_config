vim.o.runtimepath = vim.o.runtimepath .. ',' .. '~/.local/share/nvim/site/pack/packer'

-- Override default config settings
require("vimconfig")

-- Import & setup plugins
require("pluginconfig")

-- Setup LSP
require("lspsetup")

-- Setup CMP
require("cmpconfig")

-- Dependent on all plugins to be loaded already; call last
require("keymap")

vim.cmd [[autocmd VimEnter * :TSEnable highlight]]
