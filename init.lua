-- Option
vim.g.skip_defaults_vim = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.winborder = 'rounded'
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
vim.keymap.set('n', '<C-J>', ':TmuxNavigateDown<CR>', { silent = true, noremap = true})
vim.keymap.set('n', '<C-K>', ':TmuxNavigateUp<CR>', { silent = true, noremap = true})
vim.keymap.set('n', '<C-H>', ':TmuxNavigateLeft<CR>', { silent = true, noremap = true})
vim.keymap.set('n', '<C-L>', ':TmuxNavigateRight<CR>', { silent = true, noremap = true})

-- Plugins
vim.pack.add({
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/uptudev/molokai.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mhinz/vim-startify',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-tree/nvim-tree.lua',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/akinsho/bufferline.nvim',
    'https://github.com/vhyrro/luarocks.nvim',
    'https://github.com/nvim-neorg/neorg',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/hrsh7th/nvim-cmp',
    'https://github.com/hrsh7th/cmp-buffer',
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/tpope/vim-commentary',
    'https://github.com/windwp/nvim-autopairs',
    'https://github.com/christoomey/vim-tmux-navigator',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
})

-- Plugin Setup
require('mason').setup()
require('molokai').setup({ transparent = true })
require('lualine').setup({
    options = {
        theme = {
            normal = {
                a = { fg = '#1e1f1c', bg = '#66d9ef', gui = 'bold' },
                b = { fg = '#1e1f1c', bg = '#f92672' },
                c = { fg = '#ef5939', bg = NONE },
            },
            command = { a = { fg = '#1e1f1c', bg = '#dda55f', gui = 'bold' } },
            insert = { a = { fg = '#1e1f1c', bg = '#a6e22e', gui = 'bold' } },
            visual = { a = { fg = '#1e1f1c', bg = '#e6db74', gui = 'bold' } },
            replace = { a = { fg = '#1e1f1c', bg = '#ff0000', gui = 'bold' } },
            inactive = {
                a = { fg = '#f92672', bg = NONE, gui = 'bold' },
                b = { fg = '#f8f8f2', bg = '#f92672' },
                c = { fg = '#808080', bg = NONE },
            },
        },
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
})
require('nvim-tree').setup({
    on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        vim.keymap.set("n", "<C-i>",          api.node.show_info_popup,           opts("Info"))
        vim.keymap.set("n", "<C-r>",          api.fs.rename_sub,                  opts("Rename: Omit Filename"))
        vim.keymap.set("n", "<C-t>",          api.node.open.tab,                  opts("Open: New Tab"))
        vim.keymap.set("n", "<C-v>",          api.node.open.vertical,             opts("Open: Vertical Split"))
        vim.keymap.set("n", "<C-x>",          api.node.open.horizontal,           opts("Open: Horizontal Split"))
        vim.keymap.set("n", "<BS>",           api.node.navigate.parent_close,     opts("Close Directory"))
        vim.keymap.set("n", "<CR>",           api.node.open.edit,                 opts("Open"))
        vim.keymap.set("n", "<Tab>",          api.node.open.preview,              opts("Open Preview"))
        vim.keymap.set("n", ">",              api.node.navigate.sibling.next,     opts("Next Sibling"))
        vim.keymap.set("n", "<",              api.node.navigate.sibling.prev,     opts("Previous Sibling"))
        vim.keymap.set("n", ".",              api.node.run.cmd,                   opts("Run Command"))
        vim.keymap.set("n", "-",              api.tree.change_root_to_parent,     opts("Up"))
        vim.keymap.set("n", "a",              api.fs.create,                      opts("Create File Or Directory"))
        vim.keymap.set("n", "bd",             api.marks.bulk.delete,              opts("Delete Bookmarked"))
        vim.keymap.set("n", "bt",             api.marks.bulk.trash,               opts("Trash Bookmarked"))
        vim.keymap.set("n", "bmv",            api.marks.bulk.move,                opts("Move Bookmarked"))
        vim.keymap.set("n", "B",              api.tree.toggle_no_buffer_filter,   opts("Toggle Filter: No Buffer"))
        vim.keymap.set("n", "c",              api.fs.copy.node,                   opts("Copy"))
        vim.keymap.set("n", "C",              api.tree.toggle_git_clean_filter,   opts("Toggle Filter: Git Clean"))
        vim.keymap.set("n", "[c",             api.node.navigate.git.prev,         opts("Prev Git"))
        vim.keymap.set("n", "]c",             api.node.navigate.git.next,         opts("Next Git"))
        vim.keymap.set("n", "d",              api.fs.remove,                      opts("Delete"))
        vim.keymap.set("n", "D",              api.fs.trash,                       opts("Trash"))
        vim.keymap.set("n", "E",              api.tree.expand_all,                opts("Expand All"))
        vim.keymap.set("n", "e",              api.fs.rename_basename,             opts("Rename: Basename"))
        vim.keymap.set("n", "]e",             api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
        vim.keymap.set("n", "[e",             api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
        vim.keymap.set("n", "F",              api.live_filter.clear,              opts("Live Filter: Clear"))
        vim.keymap.set("n", "f",              api.live_filter.start,              opts("Live Filter: Start"))
        vim.keymap.set("n", "g?",             api.tree.toggle_help,               opts("Help"))
        vim.keymap.set("n", "gy",             api.fs.copy.absolute_path,          opts("Copy Absolute Path"))
        vim.keymap.set("n", "ge",             api.fs.copy.basename,               opts("Copy Basename"))
        vim.keymap.set("n", "H",              api.tree.toggle_hidden_filter,      opts("Toggle Filter: Dotfiles"))
        vim.keymap.set("n", "I",              api.tree.toggle_gitignore_filter,   opts("Toggle Filter: Git Ignore"))
        vim.keymap.set("n", "J",              api.node.navigate.sibling.last,     opts("Last Sibling"))
        vim.keymap.set("n", "K",              api.node.navigate.sibling.first,    opts("First Sibling"))
        vim.keymap.set("n", "L",              api.node.open.toggle_group_empty,   opts("Toggle Group Empty"))
        vim.keymap.set("n", "M",              api.tree.toggle_no_bookmark_filter, opts("Toggle Filter: No Bookmark"))
        vim.keymap.set("n", "m",              api.marks.toggle,                   opts("Toggle Bookmark"))
        vim.keymap.set("n", "o",              api.node.open.edit,                 opts("Open"))
        vim.keymap.set("n", "O",              api.node.open.no_window_picker,     opts("Open: No Window Picker"))
        vim.keymap.set("n", "p",              api.fs.paste,                       opts("Paste"))
        vim.keymap.set("n", "P",              api.node.navigate.parent,           opts("Parent Directory"))
        vim.keymap.set("n", "q",              api.tree.close,                     opts("Close"))
        vim.keymap.set("n", "r",              api.fs.rename,                      opts("Rename"))
        vim.keymap.set("n", "R",              api.tree.reload,                    opts("Refresh"))
        vim.keymap.set("n", "s",              api.node.run.system,                opts("Run System"))
        vim.keymap.set("n", "S",              api.tree.search_node,               opts("Search"))
        vim.keymap.set("n", "u",              api.fs.rename_full,                 opts("Rename: Full Path"))
        vim.keymap.set("n", "U",              api.tree.toggle_custom_filter,      opts("Toggle Filter: Hidden"))
        vim.keymap.set("n", "W",              api.tree.collapse_all,              opts("Collapse All"))
        vim.keymap.set("n", "x",              api.fs.cut,                         opts("Cut"))
        vim.keymap.set("n", "y",              api.fs.copy.filename,               opts("Copy Name"))
        vim.keymap.set("n", "Y",              api.fs.copy.relative_path,          opts("Copy Relative Path"))
        vim.keymap.set("n", "<2-LeftMouse>",  api.node.open.edit,                 opts("Open"))
        vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node,       opts("CD"))
    end,
})
require('nvim-treesitter.configs').setup({
ensure_installed = { 'c', 'rust', 'lua', 'markdown' },
sync_install = true,
auto_install = true,
highlight = {
    enable = true
},
})
require('neorg').setup({
load = {
    ['core.defaults'] = {},
    ['core.completion'] = {
        config = {
            engine = 'nvim-cmp',
        },
    },
    ['core.concealer'] = {
        config = {
            icon_preset = 'diamond',
        },
        },
        ['core.dirman'] = {
            config = {
                workspaces = {
                    my_notes = '~/notes',
                    dev = '~/dev/notes',
                    tenebrae = '~/dev/tenebrae/notes',
                    cubes = '~/Documents/cubes',
                    peppers = '~/Documents/peppers',
                    hexclad = '~/dev/hexclad/notes',
                    recipe_site = '~/dev/recipe_site/notes',
                    recipes = '~/Documents/recipes',
                },
                index = 'index.norg',
            },
        },
    },
})
require('telescope').setup()
require('telescope').load_extension('fzf')
require('nvim-autopairs').setup()
require('bufferline').setup()
require('mason-lspconfig').setup()

vim.cmd('colorscheme molokai')
vim.cmd(':hi statusline guibg=NONE')
vim.cmd('filetype on')
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')
vim.cmd("autocmd BufReadPost * if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe 'normal! g`\"' | endif")

-- Diagnostic config
vim.diagnostic.config({
    underline = false,
    virtual_text = { current_line = true },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
            [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
            [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
            [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
            [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
        },
    },
    severity_sort = true,
})
