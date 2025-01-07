return {
  'folke/noice.nvim',
  opts = {
    presets = {
      lsp_doc_border = true, -- Adds a border around LSP hover docs
    },
    lsp = {
      progress = {
        enabled = true, -- Enables LSP progress messages
      },
    },
    messages = {
      enabled = false, -- Disables Noice messages to avoid clutter
    },
  },
}
