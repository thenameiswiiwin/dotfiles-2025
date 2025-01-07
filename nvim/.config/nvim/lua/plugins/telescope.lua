local Util = require('lazyvim.util')

return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    keys = {
      { '<leader>fR', Util.telescope('resume'), desc = 'Resume Last Search' },
      {
        '<leader>sB',
        function()
          require('telescope').extensions.file_browser.file_browser({
            path = vim.fn.expand('%:p:h'),
          })
        end,
        desc = 'Browse Files',
      },
    },
    opts = {
      extensions = {
        undo = {},
        file_browser = {
          hijack_netrw = true,
        },
      },
    },
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('undo')
      telescope.load_extension('file_browser')
    end,
  },
}
