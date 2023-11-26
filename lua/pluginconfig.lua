-- Github libraries
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'uptudev/molokai.nvim'
  use 'junegunn/seoul256.vim'
  use 'mhinz/vim-startify'
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'Yggdroot/indentLine'
  use 'tpope/vim-fugitive'
  use 'junegunn/gv.vim'
  use 'windwp/nvim-autopairs'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use 'tpope/vim-commentary'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'
  use 'simrat39/rust-tools.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'lewis6991/gitsigns.nvim'
  use {'akinsho/toggleterm.nvim', tag = '*'}
  use 'DingDean/wgsl.vim'
  use 'othree/html5.vim'
  use 'pangloss/vim-javascript'
  use 'evanleck/vim-svelte'
  use 'ron-rs/ron.vim'
end)

-- Import Rust tooling
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- My molokai colour palette for Lualine and nvim
local molofix = require("molofix")
vim.api.nvim_command("colorscheme molokai")

-- Setup Lualine
require('lualine').setup {
    options = { 
        theme = molofix,
        component_separators = {left = '', right = ''},
        section_separators = {left = '', right = ''},
    },
}

-- Setup file browser and Telescope for searching
require('nvim-tree').setup()
require('telescope').setup()

-- Setup block auto-pairing (doubling of `[]`, `{}`, `()`, `''`, `""`, etc.)
require('nvim-autopairs').setup()

-- Mason Setup
require('mason').setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require('mason-lspconfig').setup()

-- Git status symbols
require('gitsigns').setup()

-- Quake terminal
require('toggleterm').setup()

return {}
