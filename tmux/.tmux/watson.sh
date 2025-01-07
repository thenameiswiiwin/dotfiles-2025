#!/bin/bash

# Function to display the current Watson status and total time spent on tasks
function mrwatson() {
	# Default status icon for an active project
	local status=""

	# Check if no project is started
	if [[ "$(watson status 2>/dev/null)" == "No project started." ]]; then
		status=""
	fi

	# Get the total time spent on tasks
	local total
	total=$(watson report -dcG | awk '/Total:/ {gsub("Total: ", ""); print $0}')

	# Print the status and total time
	printf "%s %s\n" "${status}" "${total}"
}

# Execute the function
mrwatson
