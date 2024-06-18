-- Prerequisite libraries
local cmp = require('cmp')          -- Include autocomplete
local luasnip = require('luasnip')  -- Include snippets

-- vscode loaders work
require("luasnip/loaders/from_vscode").lazy_load()  

-- tab support uses this function
local check_backspace = function()  
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local kind_icons = {    -- icons in autocomplete
  Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
  Field = " ",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
  Snippet = "",
	Color = "󰏘",
	File = "󰈙",
  Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
  Struct = "",
	Event = "",
	Operator = "󰆕",
  TypeParameter = " ",
	Misc = " ",
}

cmp.setup({
  -- Enable LSP snippets
  snippet = {   
    expand = function(args)
        luasnip.lsp_expand(args.body)
    end,
  },

  -- Custom keymaps
  mapping = {
    -- Tab
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),

    -- Shift-Tab
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),

    -- Ctrl-Shift-F
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    
    -- Ctrl-F
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    
    -- Ctrl-Space
    ['<C-Space>'] = cmp.mapping.complete(),
    
    -- Ctrl-E
    ['<C-e>'] = cmp.mapping.close(),
    
    -- Enter
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources:
  sources = {
    { name = "neorg" },                     -- from neorg
    { name = 'nvim_lsp'},                   -- from language server
    { name = 'nvim_lsp_signature_help'},    -- display function signatures
    { name = 'nvim_lua'},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer'},         -- source current buffer
    { name = 'vsnip'},          -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},           -- source for math calculation
    { name = 'luasnip'},        -- source for snippet completion
    { name = 'path' },          -- file paths
  },

  -- CMP window appearance
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },

  -- CMP entry formatting
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
        item.menu = ({
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]
        return item
      end,
  },

  -- Confirmation tweaks
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
})
