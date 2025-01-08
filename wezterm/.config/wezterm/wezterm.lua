local wezterm = require("wezterm")

-- Function to select color scheme based on appearance (Dark or Light)
local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Frappe" -- Use this for dark mode
	else
		return "Catppuccin Latte" -- Use this for light mode
	end
end

-- Define the main configuration table
local config = {
	-- Dynamic color scheme based on system appearance
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),

	-- Font settings with fallback options
	font = wezterm.font_with_fallback({
		"Victor Mono", -- Primary font
		"JetBrains Mono", -- Fallback font
		-- Uncomment if needed: "Rec Mono Duotone",
		{ family = "Symbols Nerd Font Mono", scale = 0.75 }, -- Nerd Font for symbols
	}),
	font_size = 16, -- Default font size

	-- Window appearance settings
	window_background_opacity = 0.9, -- Opacity of the terminal window
	macos_window_background_blur = 10, -- Blur effect for macOS
	force_reverse_video_cursor = true, -- Reverse cursor for better visibility
	window_decorations = "RESIZE", -- Show only resize decorations
	use_cap_height_to_scale_fallback_fonts = true, -- Align fallback fonts to cap height

	-- Terminal behavior
	scrollback_lines = 5000, -- Scrollback buffer size
	hide_tab_bar_if_only_one_tab = true, -- Hide tab bar if only one tab is open
	window_close_confirmation = "NeverPrompt", -- Disable close confirmation
	window_padding = { left = 20, right = 5, top = 10, bottom = 0 }, -- Padding around terminal

	-- Key behavior
	send_composed_key_when_left_alt_is_pressed = false, -- Left Alt key behavior
	send_composed_key_when_right_alt_is_pressed = true, -- Right Alt key behavior
	adjust_window_size_when_changing_font_size = false, -- Prevent window resizing on font size change
	warn_about_missing_glyphs = false, -- Suppress warnings for missing glyphs
}

-- Conditional configuration adjustments for recording mode
local isRecording = false -- Set to `true` when recording
if isRecording then
	config.color_scheme = "tokyonight_moon" -- Use a specific theme for recording
	config.font_size = 24 -- Increase font size for better visibility
	config.window_padding = { left = 20, right = 5, top = 10, bottom = 0 } -- Adjust padding
	config.window_background_opacity = 1.0 -- Remove opacity for recording clarity
	config.macos_window_background_blur = 0 -- Disable blur for recording
end

-- Return the final configuration table
return config
