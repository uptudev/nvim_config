-- Option
vim.g.skip_defaults_vim = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.winborder = "rounded"
vim.o.showcmd = true
vim.o.showmatch = true
vim.o.smartcase = true
vim.o.wrap = false
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.swapfile = false
vim.o.history = 99
vim.o.wildmenu = true
vim.o.wildmode = 'list:longest'
vim.o.wildignore = '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx'
vim.o.signcolumn = 'yes'
vim.o.completeopt = 'fuzzy,menuone,noselect,noinsert'
vim.o.completefuzzycollect = 'keyword,files,whole_line'
vim.o.shortmess = 'ltToOcCF'
vim.o.termguicolors = true
vim.o.updatetime = 300
vim.g.mapleader = " "

-- Theme
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

-- Keybinds
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>r', ':noh<CR>', { silent = true })
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { silent = true })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { silent = true })
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { silent = true })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { silent = true })
vim.keymap.set('n', '<S-J>', '<C-d>zz')
vim.keymap.set('n', '<S-K>', '<C-u>zz')
vim.keymap.set('n', '<M-J>', ':join<CR>')
vim.keymap.set('v', '<leader>p', "\"_dP")
vim.keymap.set('n', '<leader>p', "\"+p")
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', "\"+y")
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', "\"+d")
vim.keymap.set('n', '<leader>e', ':BufferLinePick<CR>', { silent = true })
vim.keymap.set('n', '<leader>E', ':BufferLinePickClose<CR>', { silent = true })

-- Plugins
vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/uptudev/molokai.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mhinz/vim-startify",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/vhyrro/luarocks.nvim",
    "https://github.com/nvim-neorg/neorg",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/tpope/vim-commentary",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
})

-- Plugin Setup
require('mason').setup()
require('molokai').setup({ transparent = true })
require('lualine').setup({
    options = {
        theme = molofix,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
})
require('nvim-tree').setup()
require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "rust", "lua", "markdown" },
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true
    },
})
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
require('telescope').setup()
require('telescope').load_extension('fzf')
require('nvim-autopairs').setup()
require('bufferline').setup()

vim.cmd('colorscheme molokai')
vim.cmd(':hi statusline guibg=NONE')
vim.cmd('filetype on')
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')
vim.cmd("autocmd BufReadPost * if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe 'normal! g`\"' | endif")

-- Icons for different LSP notification classes
vim.fn.sign_define('DiagnosticSignError', { texthl = 'DiagnosticSignError', text = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarn', { texthl = 'DiagnosticSignWarn', text = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', text = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignInfo', { texthl = 'DiagnosticSignInfo', text = '', numhl = '' })

-- Diagnostic config
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    virtual_lines = { current_line = true },
})

vim.lsp.enable({ "lua_ls", "rust-analyzer" })
