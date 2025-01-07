return {
  {
    'stevearc/oil.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- For file icons
    },
    keys = {
      {
        '-', -- Keybinding to open the parent directory
        function()
          require('oil').open()
        end,
        desc = 'Open parent directory',
      },
    },
    opts = {
      columns = {
        'icon', -- Display file icons
      },
      view_options = {
        show_hidden = true, -- Show hidden files
      },
      keymaps = {
        ['<CR>'] = 'actions.select', -- Open files or directories
        ['q'] = 'actions.close', -- Close the oil buffer
        ['-'] = 'actions.parent', -- Go to parent directory
        ['_'] = 'actions.open_cwd', -- Open current working directory
        ['~'] = 'actions.open_home', -- Open home directory
      },
      float = {
        padding = 2,
        border = 'rounded',
      },
    },
  },
}
