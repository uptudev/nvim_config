-- Lazy.nvim setup
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

-- Packages
require('lazy').setup({
    'wbthomason/packer.nvim',
    'junegunn/seoul256.vim',
    'mhinz/vim-startify',
    'uptudev/molokai.nvim',
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'uptudev/molokai.nvim',
        },
        config = function()
            local molofix = require("molofix")
            require("molokai").setup({
                transparent = true,
            })
            vim.api.nvim_command("colorscheme molokai")
            require('lualine').setup({
                options = { 
                    theme = molofix,
                    component_separators = {left = '', right = ''},
                    section_separators = {left = '', right = ''},
                },
            })
        end
    },
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('telescope').setup()
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup()
        end
    },
    'Yggdroot/indentLine',
    'tpope/vim-fugitive',
    'junegunn/gv.vim',
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = {
            'kevinhwang91/promise-async',
        },
        config = function()
            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return {'treesitter', 'indent'}
                end
            })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        config = function()
            local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
            parser_config.blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade",
                    files = {"src/parser.c"},
                    branch = "main",
                },
                filetype = "blade"
            }
            require('nvim-treesitter.configs').setup({
                highlight = {
                    enable = true,
                },
            })
        end
    },
    'christoomey/vim-tmux-navigator',
    'tpope/vim-commentary',
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = "",
                        package_pending = "",
                        package_uninstalled = "",
                    },
                }
            })
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup()
            require('lspconfig').rust_analyzer.setup({
                settings = {
                    ["rust-analyzer"] = {
                        diagnostics = {
                            enable = true,
                            disabled = {"unresolved-proc-macro"},
                            enableExperimental = true,
                        },
                    }
                },
            })
        end,
    },
    'neovim/nvim-lspconfig',
    {
        'simrat39/rust-tools.nvim',
        config = function()
            local rt = require('rust-tools')
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
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
        },
    },
    'hrsh7th/cmp-nvim-lsp',
    {
        'mfussenegger/nvim-lint',
        dependencies = 'williamboman/mason.nvim',
        config = function()
            require('lint').linters_by_ft = {
                c = {'cpplint'},
                cpp = {'cpplint'},
                lua = {'luacheck'},
                javascript = {'eslint_d'},
                typescript = {'eslint_d'},
                typescriptreact = {'eslint_d'},
                css = {'stylelint'},
                scss = {'stylelint'},
                sass = {'stylelint'},
                less = {'stylelint'},
                json = {'jsonlint'},
                yaml = {'yamllint'},
                markdown = {'markdownlint', 'vale'},
                sh = {'shellcheck'},
            }
        end
    },
    {
        'rshkarin/mason-nvim-lint',
        dependencies = {
            'williamboman/mason.nvim',
            'mfussenegger/nvim-lint',
        },
        config = function()
            require("mason-nvim-lint").setup({
                ensure_installed = {'htmlhint', 'eslint_d'},
            })
        end
    },
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },
    'DingDean/wgsl.vim',
    {
        'RaafatTurki/hex.nvim',
        config = function()
            require('hex').setup()
        end,
    },
    'othree/html5.vim',
    'pangloss/vim-javascript',
    'evanleck/vim-svelte',
    'ron-rs/ron.vim',
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
                                dev = "~/dev/notes",
                                tenebrae = "~/dev/tenebrae/notes",
                                cubes = "~/Documents/cubes",
                                peppers = "~/Documents/peppers",
                                hexclad = "~/dev/hexclad/notes",
                                recipe_site = "~/dev/recipe_site/notes",
                                recipes = "~/Documents/recipes",
                            },
                            index = "index.norg",
                        },
                    },
                },
            })
        end,
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({})
        end,
    },
})

return {}
