#!/usr/bin/env bash

# Change working directory in the shell to the last directory visited in lf on exit.
#
# To use this script, either copy its contents into your shell configuration file
# (e.g., ~/.bashrc, ~/.zshrc) or source it directly:
#
#     LFCD="/path/to/lfcd.sh"
#     if [ -f "$LFCD" ]; then
#         source "$LFCD"
#     fi
#
# You can also bind a key (e.g., Ctrl-O) to this command:
#
#     bind '"\C-o":"lfcd\C-m"'  # bash
#     bindkey -s '^o' 'lfcd\n'  # zsh
#

lfcd() {
	local tmp dir

	# Create a temporary file to store the last directory path from lf
	tmp="$(mktemp -t lfcd.XXXXXX)"

	# Use `command` to call lf in case `lfcd` is aliased to `lf`
	command lf --last-dir-path="$tmp" "$@"

	# If the temporary file exists, read the directory path from it
	if [[ -f "$tmp" ]]; then
		dir="$(<"$tmp")"
		rm -f "$tmp" # Remove the temporary file

		# Check if the directory is valid and different from the current working directory
		if [[ -d "$dir" && "$dir" != "$(pwd)" ]]; then
			cd "$dir" || return
		fi
	fi
}
