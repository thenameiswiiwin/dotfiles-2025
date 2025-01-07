return {
  -- Uncomment the following block if you want to use the "tmux.nvim" plugin for advanced tmux integration
  -- {
  --   "aserowy/tmux.nvim",
  --   config = function()
  --     require("tmux").setup({
  --       navigation = {
  --         enable_default_keybindings = true,
  --         cycle_navigation = true, -- Cycle to the opposite border
  --       },
  --       resize = {
  --         enable_default_keybindings = true,
  --       },
  --     })
  --   end,
  -- },

  -- Plugin for seamless navigation between tmux panes and Vim splits
  {
    'christoomey/vim-tmux-navigator',
    lazy = false, -- Ensures the plugin is loaded immediately for smooth navigation
    description = 'Seamless navigation between Vim splits and tmux panes',
  },
}
