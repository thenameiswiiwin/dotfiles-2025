#!/bin/bash
#
# Displays current Watson project status and total tracked time.
# https://github.com/TailorDev/Watson

function mrwatson() {
	# Default icon indicates "running"
	local status_icon=""

	# If no project is started, switch icon to something else
	if [[ "$(watson status)" == "No project started." ]]; then
		status_icon=""
	fi

	# Extract total time from Watson report
	local total_time
	total_time=$(watson report -dcG | grep 'Total:' | sed 's/Total: //')

	# Print icon and total time
	printf "%s %s\n" "$status_icon" "$total_time"
}

# Execute the function
mrwatson
