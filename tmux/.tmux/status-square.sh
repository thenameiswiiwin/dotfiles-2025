#!/bin/bash

# Define color variables
white='#f8f8f2'
gray='#44475a'
dark_gray='#282a36' # Dracula theme
# dark_gray='#504945' # Uncomment for Gruvbox-Light theme
light_purple='#bd93f9'
dark_purple='#6272a4'
cyan='#8be9fd'
green='#50fa7b'
orange='#ffb86c'
red='#ff5555'
pink='#ff79c6'
yellow='#f1fa8c'

# Function to format a powerline segment
function segment() {
	powerline "${@}"
}

# Function to create a powerline-style segment
function powerline() {
	printf "#[fg=%s]#[fg=%s]#[bg=%s] %s #[bg=%s]" "$1" "$2" "$1" "$3" "$1"
}

# Function to create a basic line segment
function basicline() {
	printf "#[fg=%s]#[bg=%s] | %s" "$1" "$2" "$3"
}

# Main function to assemble and display the status line
function main() {
	twitter "$cyan" "$dark_gray"
	printf " "
}

# Execute the main function
main
