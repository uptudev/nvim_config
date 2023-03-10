let g:skip_defaults_vim = 1
lua << EOF
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

EOF

let mapleader = "\\"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
call plug#begin('~/.vim/plugged')

    Plug 'uptudev/molokai.nvim', { 'branch': 'main' }
    Plug 'junegunn/seoul256.vim'
    Plug 'mhinz/vim-startify' 
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-tree/nvim-tree.lua', {'do': ':NvimTreeToggle'}
    Plug 'Yggdroot/indentLine'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    Plug 'windwp/nvim-autopairs'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'tpope/vim-commentary'
    Plug 'voldikss/vim-floaterm'

call plug#end()

if exists("g:neovide")
	colorscheme molokai
	let g:neovide_scale_factor = 1.0
	let g:neovide_padding_top = 0
	let g:neovide_padding_bottom = 0
	let g:neovide_padding_right = 0
	let g:neovide_padding_left = 0
	let g:neovide_transparency = 0.98
	let g:neovide_hide_mouse_when_typing = v:true
	let g:neovide_refresh_rate = 144
endif

set nocompatible

filetype on
filetype plugin indent on
syntax on

set linespace=0
set relativenumber
set cursorline
set cursorcolumn
set history=99
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set guifont=DinaRemaster:h12
set showcmd	
set showmatch	
set smartcase

lua << END
local map = vim.api.nvim_set_keymap

require('lualine').setup {
    options = { theme = 'molokai' },
}
require("nvim-tree").setup()
require('telescope').setup()
require('nvim-autopairs').setup()

map('n', '<leader>n', [[:NvimTreeToggle<cr>]], {})
map('n', '<leader>l', [[:IndentLinesToggle<cr>]], {})
map('n', '<leader>f', [[:Telescope find_files<cr>]], {})
map('n', '`', [[:FloatermNew<cr>]], {})
map('n', '<F11>', ":lua if vim.g.neovide_fullscreen then vim.g.neovide_fullscreen = false else vim.g.neovide_fullscreen = true end <cr>", {})

END
