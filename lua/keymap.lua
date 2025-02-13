local ffi = require("ffi")

ffi.cdef([[
void ui_busy_start(void);
void ui_busy_stop(void);
]])

-- Because typing `vim.api.nvim_set_keymap` is redundant
local map = vim.api.nvim_set_keymap
local non_vcs_ignored = true

function _G.toggle_gitignored()
    local setup, nvimtree = pcall(require, "nvim-tree")
    if not setup then
        return
    end

    non_vcs_ignored = not non_vcs_ignored

    nvimtree.setup({
        git = {
            ignore = non_vcs_ignored,
        },
    })
end

-- Leader key is SPACE
vim.g.mapleader = ' '

-- Initialize variables to track the current state
local cursor_highlight_enabled = true
local cursor_visible = true

-- Function to toggle cursorline and cursorcolumn
function ToggleCursorHighlight()
    cursor_highlight_enabled = not cursor_highlight_enabled
    vim.opt.cursorline = cursor_highlight_enabled
    vim.opt.cursorcolumn = cursor_highlight_enabled
    if cursor_highlight_enabled then
        ffi.C.ui_busy_stop()
    else 
        ffi.C.ui_busy_start()
    end
end

-- Cursor blinking and default behaviour
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkwait450-blinkon450-blinkoff300,i-ci:ver25-Cursor/lCursor-blinkwait450-blinkon450-blinkoff300,r-cr:hor20-Cursor/lCursor-blinkwait450-blinkon450-blinkoff300"

-- Keymapping

-- Toggle non-VCS file visibility
map('n', '<leader>g', ":lua toggle_gitignored()<CR>", {noremap = true, silent = true, nowait = true})

-- Toggle cursor row/column highlighting
map('n', '<leader>H', ":lua ToggleCursorHighlight()<CR>", {noremap = true, silent = true, nowait = true})

-- Toggle nvim-tree (file browser)
map('n', '<leader>n', [[:NvimTreeToggle<cr>]], {noremap = true, silent = true, nowait = true})

-- Toggle indentation lines                 
map('n', '<leader>l', [[:IndentLinesToggle<cr>]], {noremap = true, silent = true, nowait = true})

-- Open Telescope to find files
map('n', '<leader>f', [[:Telescope find_files<cr>]], {noremap = true, silent = true, nowait = true})

-- Split the editor vertically
map('n', '<leader>v', [[:split<cr>]], {})

-- Split the editor horizontally
map('n', '<leader>h', [[:vsplit<cr>]], {})

-- Quit
map('n', '<leader>q', [[:q<cr>]], {})

-- Quit all 
map('n', '<leader>Q', [[:qa<cr>]], {})

-- Save/Write
map('n', '<leader>w', [[:w<cr>]], {})

-- Autofill a `mkdir` call (just needing the directory name)
map('n', '<leader>m', [[:!mkdir ]], {})

-- Autofill a `touch` call (just needing the file name)
map('n', '<leader>t', [[:!touch ]], {})

-- Reload the configs from the base file (useful when tweaking configs)
map('n', '<leader>o', [[:so ~/.config/nvim/init.lua<cr>]], {noremap = true, silent = true, nowait = true})

-- Toggle fullscreen
map('n', '<F11>', ":lua if vim.g.neovide_fullscreen then vim.g.neovide_fullscreen = false else vim.g.neovide_fullscreen = true end <cr>", {noremap = true, silent = true, nowait = true})

-- Erase search highlighting
map('n', '<leader>e', [[:nohlsearch<CR>:match<CR>:diffupdate<CR>]], {noremap = true, silent = true, nowait = true})

-- Change working directory of nvim-tree; rebinding of `Ctrl+]`
map('n', '<leader>d', [[<C-]>]], {})

-- Remap `Ctrl-D` & `Ctrl-U` to capital J and K, respectively, then recentre screen. Also remap join to Alt-J.
map('n', '<S-J>', [[<C-d>zz]], {})
map('n', '<S-K>', [[<C-u>zz]], {})
map('n', '<M-J>', [[:join<cr>]], {})

-- Keep paste register in visual mode; in normal mode, it dumps the system clipboard.
map('v', '<leader>p', "\"_dP", {})
map('n', '<leader>p', "\"+p", {})

-- Yank to system clipboard
map('n', '<leader>y', "\"+y", {})

-- Toggle hex visibility
map('n', '<leader>X', ":HexToggle<CR>", {})

-- ufo maps
map('n', 'zR', ":lua require('ufo').openAllFolds()<CR>", {noremap = true, silent = true})
map('n', 'zM', ":lua require('ufo').closeAllFolds()<CR>", {noremap = true, silent = true})

-- toggle treesitter highlighting (with a neorg toggle-concealer call)
map('n', '<leader>c', [[:TSToggle highlight<CR>]], {noremap = true, silent = true, nowait = true})
map('n', '<leader>C', [[:Neorg toggle-concealer<CR>]], {noremap = true, silent = true, nowait = true})

map('n', '<leader>e', [[:BufferLinePick<CR>]], { noremap = true, silent = true })
map('n', '<leader>E', [[:BufferLinePickClose<CR>]], { noremap = true, silent = true })
