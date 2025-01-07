-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Overwrite LazyVim mappings with vim-tmux-navigator mappings
-- Reference: https://github.com/christoomey/vim-tmux-navigator
vim.keymap.set('n', '<C-h>', ':<C-U>TmuxNavigateLeft<CR>', { noremap = true, silent = true, desc = 'Navigate Left' })
vim.keymap.set('n', '<C-l>', ':<C-U>TmuxNavigateRight<CR>', { noremap = true, silent = true, desc = 'Navigate Right' })
vim.keymap.set('n', '<C-j>', ':<C-U>TmuxNavigateDown<CR>', { noremap = true, silent = true, desc = 'Navigate Down' })
vim.keymap.set('n', '<C-k>', ':<C-U>TmuxNavigateUp<CR>', { noremap = true, silent = true, desc = 'Navigate Up' })
vim.keymap.set(
  'n',
  '<C-\\>',
  ':<C-U>TmuxNavigatePrevious<CR>',
  { noremap = true, silent = true, desc = 'Navigate Previous' }
)

-- Resize window using <alt> arrow keys
vim.keymap.set('n', '<M-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height', noremap = true, silent = true })
vim.keymap.set(
  'n',
  '<M-Down>',
  '<cmd>resize -2<CR>',
  { desc = 'Decrease window height', noremap = true, silent = true }
)
vim.keymap.set(
  'n',
  '<M-Left>',
  '<cmd>vertical resize -2<CR>',
  { desc = 'Decrease window width', noremap = true, silent = true }
)
vim.keymap.set(
  'n',
  '<M-Right>',
  '<cmd>vertical resize +2<CR>',
  { desc = 'Increase window width', noremap = true, silent = true }
)

-- Line navigation
vim.keymap.set('n', 'H', '^', { desc = 'Go to start of line' })
vim.keymap.set('n', 'L', 'g_', { desc = 'Go to end of line' })
vim.keymap.set('v', 'H', '^', { desc = 'Go to start of line (visual)' })
vim.keymap.set('v', 'L', 'g_', { desc = 'Go to end of line (visual)' })

-- Buffer navigation
vim.keymap.set('n', 'qn', ':bprevious<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })
vim.keymap.set('n', 'wn', ':bnext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })

-- Moving lines in visual mode
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', { desc = 'Move line up' })
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { desc = 'Move line down' })

-- Make file executable
vim.keymap.set('n', '<leader>ch', ':!chmod +x %<CR>', { desc = 'Make file executable', noremap = true, silent = true })

-- Lazydocker toggle
local Terminal = require('toggleterm.terminal').Terminal
local lazydocker = Terminal:new({
  cmd = 'lazydocker',
  hidden = true,
  close_on_exit = true,
  direction = 'float',
  float_opts = {
    border = 'double',
  },
})
vim.keymap.set('n', '<leader>dd', function()
  lazydocker:toggle()
end, { desc = 'Lazydocker', noremap = true, silent = true })

-- Quick escape in insert mode
vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true, desc = 'Quick escape from insert mode' })
