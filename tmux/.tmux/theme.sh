#!/bin/bash

# Script to automatically switch between light and dark mode for tmux based on macOS system settings
# Source: https://github.com/victorkristof/tmux-auto-dark-mode/blob/master/scripts/auto-dark-mode.sh

# Function to get the current macOS system mode (light or dark)
get_system_mode() {
	# Check the status of macOS dark mode. Ignore errors if light mode is enabled.
	local status
	status=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
	# Determine the system mode based on the retrieved status.
	if [[ $status == "Dark" ]]; then
		echo "dark"
	else
		echo "light"
	fi
}

# Function to set the appropriate tmux theme based on the system mode
get_theme() {
	local mode
	mode=$(get_system_mode)
	# Clear any prepended options for the Catppuccin theme.
	tmux set-option -g @catppuccin_prepend ""

	# Return the appropriate theme based on the system mode.
	if [[ $mode == "dark" ]]; then
		echo "frappe" # Dark theme
	else
		echo "latte" # Light theme
	fi
}

# Retrieve the theme based on the current system mode and apply it to tmux
theme=$(get_theme)
tmux set-option -g @catppuccin_flavour "${theme}"
