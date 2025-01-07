return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      -- Add any custom options here
      size = 20,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = 'float', -- options: 'horizontal', 'vertical', 'tab', 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved', -- options: 'single', 'double', 'shadow', 'curved'
        winblend = 3,
      },
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)
    end,
  },
}
