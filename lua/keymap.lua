local map = vim.api.nvim_set_keymap

vim.g.mapleader = ' '

map('n', '<leader>n', [[:NvimTreeToggle<cr>]], {})
map('n', '<leader>l', [[:IndentLinesToggle<cr>]], {})
map('n', '<leader>f', [[:Telescope find_files<cr>]], {})
map('n', '<leader>v', [[:vsplit<cr>]], {})
map('n', '<leader>s', [[:split<cr>]], {})
map('n', '<leader>q', [[:q<cr>]], {})
map('n', '<leader>w', [[:w<cr>]], {})
map('n', '<leader>r', [[:!cargo run<cr>]], {})
map('n', '<leader>b', [[:!cargo build<cr>]], {})
map('n', '<leader>e', [[:!cargo fmt<cr><cr>]], {})
map('n', '<leader>m', [[:!mkdir ]], {})
map('n', '<leader>t', [[:!touch ]], {})
map('n', '<leader>o', [[:so ~/.config/nvim/init.lua<cr>]], {})
map('n', '`', [[:ToggleTerm<cr>]], {})
map('n', '<F11>', ":lua if vim.g.neovide_fullscreen then vim.g.neovide_fullscreen = false else vim.g.neovide_fullscreen = true end <cr>", {})
map('n', '<C-S>', [[:nohlsearch<CR>:match<CR>:diffupdate<CR>]], {})