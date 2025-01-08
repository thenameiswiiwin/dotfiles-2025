return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = {
        enabled = false, -- Set to true if you want the panel
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },
}
