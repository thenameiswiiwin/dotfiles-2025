#!/bin/bash
#
# Auto-detect macOS appearance (Dark/Light) and configure tmux to use
# the corresponding Catppuccin theme flavor.

###############################################################################
# get_system_mode
#   Checks the macOS default appearance setting (Dark or Light).
#   Returns "dark" if AppleInterfaceStyle is set to "Dark", otherwise "light".
###############################################################################
get_system_mode() {
	# Attempt to read the AppleInterfaceStyle setting. If light mode is enabled,
	# defaults read returns an error, so redirect stderr to /dev/null.
	local status
	status="$(defaults read -g AppleInterfaceStyle 2>/dev/null)"

	if [[ "$status" == "Dark" ]]; then
		echo "dark"
	else
		echo "light"
	fi
}

###############################################################################
# get_theme
#   Uses get_system_mode to determine if the system is in Dark or Light mode.
#   Prints "frappe" if mode is dark, or "latte" if mode is light.
###############################################################################
get_theme() {
	local mode
	mode="$(get_system_mode)"

	# You can set a custom tmux option here (like a prefix in your status)
	# or override any theme-based variable if needed.
	# Example: tmux set-option -g @catppuccin_prepend ""

	if [[ "$mode" == "dark" ]]; then
		echo "frappe"
	else
		echo "latte"
	fi
}

###############################################################################
# Main Script Logic
###############################################################################

# Determine the correct Catppuccin flavor based on current system appearance
theme="$(get_theme)"

# Set the Catppuccin flavor in tmux (requires the catppuccin/tmux plugin).
tmux set-option -g @catppuccin_flavour "$theme"
