#!/usr/bin/env bash

# Change working directory to the last visited directory in `lf`.

lfcd() {
	local tmp dir
	tmp="$(mktemp -t lfcd.XXXXXX)"

	command lf --last-dir-path="$tmp" "$@"

	if [[ -f "$tmp" ]]; then
		dir="$(<"$tmp")"
		rm -f "$tmp"

		if [[ -d "$dir" && "$dir" != "$(pwd)" ]]; then
			cd "$dir" || return
		fi
	fi
}
