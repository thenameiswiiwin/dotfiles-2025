-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Configure folding
opt.foldlevel = 20 -- Open folds up to 20 levels by default
opt.foldmethod = 'expr' -- Use expression-based folding
opt.foldexpr = 'nvim_treesitter#foldexpr()' -- Use Tree-sitter for folds

-- UI enhancements
vim.o.cmdheight = 0 -- Minimize command-line height
vim.o.showcmdloc = 'statusline' -- Display command in the status line
vim.o.winbar = '%{%v:lua.require\'nvim-navic\'.get_location()%}' -- Show current code context in the winbar
vim.opt.swapfile = false -- Disable swap files

-- Configure clipboard for macOS
vim.g.clipboard = {
  name = 'macOS-clipboard',
  copy = { ['+'] = 'pbcopy', ['*'] = 'pbcopy' },
  paste = { ['+'] = 'pbpaste', ['*'] = 'pbpaste' },
  cache_enabled = false, -- Disable caching for clipboard content
}

-- Configure display of invisible characters
vim.opt.listchars = {
  space = '.', -- Replace spaces with dots
  eol = '↲', -- Show end of line with ↲
  nbsp = '␣', -- Replace non-breaking space with ␣
  trail = '·', -- Show trailing spaces with ·
  precedes = '←', -- Indicate lines that extend to the left
  extends = '→', -- Indicate lines that extend to the right
  tab = '¬ ', -- Display tabs with ¬
  conceal = '※', -- Concealed text indicator
}
vim.opt.list = true -- Enable rendering of invisible characters
