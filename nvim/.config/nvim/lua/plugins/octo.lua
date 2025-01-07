return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required dependency for async operations
    'nvim-telescope/telescope.nvim', -- Integration with Telescope
    'nvim-tree/nvim-web-devicons', -- For file icons
  },
  config = function()
    require('octo').setup({
      default_remote = { 'upstream', 'origin' }, -- Order to find remote for issues/PRs
      reaction_viewer_hint_icon = '', -- Icon for reactions
      user_icon = ' ', -- Icon for user mentions
      timeline_marker = '', -- Marker for timeline entries
      timeline_indent = '2', -- Indentation for timeline entries
      right_bubble_delimiter = '', -- Right bubble delimiter
      left_bubble_delimiter = '', -- Left bubble delimiter
      use_sign_column = true, -- Show icons in the sign column
    })
  end,
}
