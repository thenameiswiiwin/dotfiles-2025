-- Bootstrap Lazy.nvim, LazyVim, and user plugins
local lazy_config_path = 'config.lazy'

-- Check if the required configuration file exists
local status_ok, _ = pcall(require, lazy_config_path)
if not status_ok then
  error('Failed to load Lazy.nvim configuration at: ' .. lazy_config_path)
end
