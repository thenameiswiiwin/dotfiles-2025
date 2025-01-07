return {
  {
    'neovim/nvim-lspconfig',
    init = function()
      local keys = require('lazyvim.plugins.lsp.keymaps').get()
      table.insert(keys, { 'K', false }) -- Disable the default `K` keymap
      table.insert(keys, { 'gK', vim.lsp.buf.hover, desc = 'LSP Hover' }) -- Add custom keymap for hover
    end,
  },
  {
    'VidocqH/lsp-lens.nvim',
    opts = {
      enable = true,
      include_declaration = false, -- Exclude references to declarations
      sections = {
        definition = false, -- Disable definition requests
        references = true, -- Enable references
        implementation = true, -- Enable implementation requests
      },
      ignore_filetype = {
        'prisma', -- Ignore specific filetypes
      },
    },
  },
  {
    'mhanberg/output-panel.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>uo', '<cmd>OutputPanel<cr>', desc = 'Toggle LSP Output Panel' },
    },
    config = true,
  },
}
