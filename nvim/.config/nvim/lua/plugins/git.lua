return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    cmd = 'Neogit',
    branch = 'master',
    keys = {
      { '<leader>gn', '<cmd>Neogit<cr>', desc = 'Open Neogit' },
    },
    opts = {
      integrations = {
        diffview = true, -- Enable integration with Diffview
      },
    },
  },
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
      'DiffviewRefresh',
      'DiffviewFileHistory',
    },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open Diffview' },
    },
    opts = {
      view = {
        default = {
          layout = 'diff2_horizontal', -- Example customization for Diffview layout
        },
      },
    },
  },
}
