return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function(_, opts)
      -- Update the `lualine_y` section
      opts.sections.lualine_y = {
        { '%S' }, -- Displays the current session name (if using session management)
        { 'progress', separator = ' ', padding = { left = 1, right = 0 } }, -- Displays file progress
        { 'location', padding = { left = 0, right = 1 } }, -- Displays cursor location
      }

      -- Update the `lualine_z` section to display the current time
      opts.sections.lualine_z = {
        function()
          return ' ' .. os.date('%I:%M %p') -- Display time in HH:MM AM/PM format
        end,
      }
    end,
  },
}
