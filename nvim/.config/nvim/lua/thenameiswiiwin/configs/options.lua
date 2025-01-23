vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Line Numbers Default
opt.relativenumber = true
opt.number = true

-- Disable Mouse Mode
opt.mouse = ""

-- Save Undo History
opt.undofile = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- TermGUI
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noselect"

-- Split Windows
opt.splitright = true
opt.splitbelow = true

-- Concealer for Neorg
opt.conceallevel = 2

-- turn off swapfile
opt.swapfile = false
