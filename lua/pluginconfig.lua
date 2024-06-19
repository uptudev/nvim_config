local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Github libraries
require('lazy').setup({
  'wbthomason/packer.nvim',
  'junegunn/seoul256.vim',
  'mhinz/vim-startify',
  'uptudev/molokai.nvim',
  'nvim-lualine/lualine.nvim',
  'nvim-tree/nvim-web-devicons',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-tree/nvim-tree.lua',
  'Yggdroot/indentLine',
  'tpope/vim-fugitive',
  'junegunn/gv.vim',
  'windwp/nvim-autopairs',
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  },
  'christoomey/vim-tmux-navigator',
  'tpope/vim-commentary',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'simrat39/rust-tools.nvim',
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
  },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'lewis6991/gitsigns.nvim',
  {'akinsho/toggleterm.nvim', version = '*'},
  'DingDean/wgsl.vim',
  'othree/html5.vim',
  'pangloss/vim-javascript',
  'evanleck/vim-svelte',
  'ron-rs/ron.vim',
  -- 'github/copilot.vim',
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    ft = "norg",
    version = "*",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond",
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                my_notes = "~/notes",
              },
              index = "index.norg",
            },
          },
        },
      })
    end,
  },
  {
    "willothy/nvim-cokeline",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local get_hex = require('cokeline.hlgroups').get_hl_attr

      local green = vim.g.terminal_color_2
      local yellow = vim.g.terminal_color_3
      require('cokeline').setup({
        default_hl = {
          fg = function(buffer)
            return
              buffer.is_focused
              and get_hex('Normal', 'fg')
               or get_hex('Comment', 'fg')
          end,
          bg = get_hex('ColorColumn', 'bg'),
        },

        components = {
          {
            text = '｜',
            fg = function(buffer)
              return
                buffer.is_modified and yellow or green
            end
          },
          {
            text = function(buffer) return buffer.devicon.icon .. ' ' end,
            fg = function(buffer) return buffer.devicon.color end,
          },
          {
            text = function(buffer) return buffer.index .. ': ' end,
          },
          {
            text = function(buffer) return buffer.unique_prefix end,
            fg = get_hex('Comment', 'fg'),
            italic = true,
          },
          {
            text = function(buffer) return buffer.filename .. ' ' end,
            bold = function(buffer) return buffer.is_focused end,
          },
          {
            text = ' ',
          },
        },
      })
    end
  },
})

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
require("molokai").setup({
  transparent = true,
})
vim.api.nvim_command("colorscheme molokai")

-- Setup Lualine
require('lualine').setup({
  options = { 
    theme = molofix,
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''},
  },
})
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

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
})

require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return {'treesitter', 'indent'}
  end
})

return {}
