local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- Bootstrap lazy.nvim
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
  spec = {
    -- Add LazyVim and import its plugins
    { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
    -- Import and override with your plugins
    { import = 'plugins' },
    -- Import additional modules
    { import = 'lazyvim.plugins.extras.lang.typescript' },
    { import = 'lazyvim.plugins.extras.lang.json' },
    { import = 'lazyvim.plugins.extras.linting.eslint' },
    { import = 'lazyvim.plugins.extras.formatting.prettier' },
    { import = 'lazyvim.plugins.extras.coding.copilot' },
    { import = 'lazyvim.plugins.extras.lang.tailwind' },
    { import = 'lazyvim.plugins.extras.test.core' },
    { import = 'lazyvim.plugins.extras.dap.core' },
    { import = 'lazyvim.plugins.extras.ui.mini-animate' },
    { import = 'lazyvim.plugins.extras.util.mini-hipatterns' },
    { import = 'lazyvim.plugins.extras.coding.yanky' },
    { import = 'lazyvim.plugins.extras.editor.mini-files' },
    { import = 'lazyvim.plugins.extras.lsp.none-ls' },
  },
  defaults = {
    -- Lazy-load only LazyVim plugins by default; custom plugins load during startup.
    lazy = false,
    -- Leave versioning off for compatibility with plugins that may have outdated releases.
    version = false, -- use the latest git commit
  },
  install = {
    colorscheme = { 'catppuccin', 'tokyonight', 'habamax' },
  },
  checker = {
    enabled = false, -- Disable automatic plugin update checks
    notify = false, -- Disable notifications
  },
  debug = false,
  performance = {
    rtp = {
      -- Disable unused runtime plugins for better performance
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
