-- Detect macOS dark mode using the system command
local os_is_dark = function()
  return (vim.fn.system([[defaults read -g AppleInterfaceStyle 2>/dev/null || echo "light"]])):find('dark') ~= nil
end

return {
  {
    -- https://github.com/catppuccin/nvim
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      transparent_background = true,
      integrations = {
        notify = true,
        mini = true,
      },
    },
  },
  {
    'LazyVim/LazyVim',
    opts = function(_, opts)
      -- Dynamically set colorscheme based on macOS appearance
      opts.colorscheme = os_is_dark() and 'catppuccin-frappe' or 'catppuccin-latte'
    end,
  },
}
