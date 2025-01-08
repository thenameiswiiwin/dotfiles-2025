local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required dependency for Telescope
      "debugloop/telescope-undo.nvim", -- Undo history extension
      "nvim-telescope/telescope-file-browser.nvim", -- File browser extension
      { 
        "nvim-telescope/telescope-fzf-native.nvim", -- Fuzzy finder native extension
        build = "make", -- Ensure it is compiled after installation
      },
    },
    keys = {
      { 
        "<leader>fR", 
        function() Util.telescope("resume") end, 
        desc = "Resume last search" 
      },
      {
        "<leader>sB",
        function()
          require("telescope").extensions.file_browser.file_browser({
            path = vim.fn.expand("%:p:h"), -- Open file browser in the current file's directory
            cwd = vim.fn.getcwd(), -- Use the current working directory
          })
        end,
        desc = "Browse Files",
      },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          -- Add your Telescope default configurations here, if any
        },
        extensions = {
          -- Configure extensions if needed
          undo = {
            -- Optional: customize the `telescope-undo.nvim` extension behavior
          },
          file_browser = {
            -- Optional: customize the file browser extension behavior
          },
        },
      })

      -- Load extensions
      telescope.load_extension("undo")
      telescope.load_extension("file_browser")
      telescope.load_extension("fzf") -- Ensure fzf extension is loaded
    end,
  },
}
