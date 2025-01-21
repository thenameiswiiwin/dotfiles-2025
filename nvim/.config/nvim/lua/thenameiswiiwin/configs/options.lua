vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- Tabs & Indentation
opt.tabstop = 2
obt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- TermGUI
opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes'

-- Backspace
opt.backspace = 'indent,eol,start'

-- Clipboard
opt.clipboard:append('unnamedplus')

-- Split Windows
opt.splitright = true
opt.splitbelow = true

-- turn off swapfile
opt.swapfile = false
