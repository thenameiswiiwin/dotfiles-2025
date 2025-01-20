return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Load custom keymaps for LSP
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      -- Disable the default "K" keymap
      keys[#keys + 1] = { "K", false }

      -- Add custom keymap for LSP hover
      keys[#keys + 1] = { "gK", vim.lsp.buf.hover }
    end,
  },
  {
    "VidocqH/lsp-lens.nvim",
    opts = { -- Ensure the spelling is `opts`, not `ops`
      enable = true,
      include_declaration = false, -- References will not include declarations
      sections = { -- Enable/disable specific LSP requests
        definition = false,
        references = true,
        implementation = true,
      },
      ignore_filetype = { "prisma" }, -- Filetypes to ignore
    },
  },
  {
    "mhanberg/output-panel.nvim",
    event = "VeryLazy", -- Load lazily on demand
    keys = {
      -- Keymap for toggling the LSP output panel
      { "<leader>uo", "<cmd>OutputPanel<cr>", desc = "Toggle LSP output" },
    },
    config = true, -- Use default configuration
  },
}
