#!/bin/bash

# Color definitions
white='#f8f8f2'
gray='#44475a'
dark_gray='#282a36' # Dracula theme
# dark_gray='#504945' # Gruvbox (uncomment if you prefer a lighter background)
light_purple='#bd93f9'
dark_purple='#6272a4'
cyan='#8be9fd'
green='#50fa7b'
orange='#ffb86c'
red='#ff5555'
pink='#ff79c6'
yellow='#f1fa8c'

###############################################################################
# Helper Functions
###############################################################################

# segment: Wrapper that calls 'powerline' for building tmux segments.
function segment() {
	powerline "$@"
}

# powerline: Creates a colored powerline-like arrow and text for tmux status line.
#            Usage: powerline BG_COLOR FG_COLOR "MESSAGE"
function powerline() {
	printf "#[fg=%s]#[fg=%s]#[bg=%s] %s #[bg=%s]" \
		"$1" "$2" "$1" "$3" "$1"
}

# basicline: Prints a minimal line with a separator (uncomment or modify as needed).
function basicline() {
	printf "#[fg=%s]#[bg=%s] | %s" "$1" "$2" "$3"
}

###############################################################################
# Main Function
###############################################################################
function main() {
	# Example usage: creating two segments with different colors and messages
	segment "$pink" "$dark_gray" "Hello"
	segment "$orange" "$dark_gray" "World!"

	# Add a trailing space at the end (helps with spacing in the tmux status line)
	printf " "
}

# Call the main function
main
