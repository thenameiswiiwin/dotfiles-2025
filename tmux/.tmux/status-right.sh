#!/bin/bash

# Set your desired TTL (Time To Live) for bkt (https://github.com/dlecorfec/bkt)
bkt_ttl='15s'

# Define color constants (Dracula theme by default)
white='#f8f8f2'
gray='#44475a'
dark_gray='#282a36'
# Uncomment the following line to switch to a lighter background (e.g., Gruvbox)
# dark_gray='#504945'

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

# segment: Helper to create a segment via the powerline function
function segment() {
	powerline "$@"
}

# powerline: Prints a powerline segment with foreground and background colors
function powerline() {
	printf "#[fg=%s]#[fg=%s]#[bg=%s] %s #[bg=%s]" \
		"$1" "$2" "$1" "$3" "$1"
}

# basicline: Prints a minimal separator line
function basicline() {
	printf "#[fg=%s]#[bg=%s] | %s" "$1" "$2" "$3"
}

###############################################################################
# Metric Functions
###############################################################################

# cpu: Calculates CPU usage across all processes and formats it
function cpu() {
	# Summing integer part of %CPU for all processes
	local cpuvalue
	cpuvalue=$(bkt --ttl="$bkt_ttl" -- ps -A -o %cpu | awk -F. '{ s+=$1 } END { print s }')

	# Number of logical CPU cores
	local cpucores
	cpucores=$(bkt --ttl="$bkt_ttl" -- sysctl -n hw.logicalcpu)

	# Usage is integer division of total CPU usage by core count
	local cpuusage=$((cpuvalue / cpucores))
	local slot
	slot=$(printf "  %02d%%" "$cpuusage")
	segment "$1" "$2" "$slot"
}

# battery: Displays battery percentage and charging/discharging icon
function battery() {
	local status
	status=$(bkt --ttl="$bkt_ttl" -- pmset -g batt | sed -n 2p | cut -d ';' -f 2 | tr -d " ")
	local batt
	batt=$(bkt --ttl="$bkt_ttl" -- pmset -g batt | grep -Eo '[0-9]?[0-9]?[0-9]%')
	local percentage
	percentage=$(printf "%03s" "$batt")

	local chargingMap=("" "" "" "" "" "" "" "" "" "")
	local chargedMap=("" "" "" "" "" "" "" "" "" "")
	local icon=""

	if [[ $status == "charging" ]]; then
		if [[ $percentage == "100%" ]]; then
			icon=""
		else
			icon=${chargingMap[${percentage:0:1}]}
		fi
	else
		if [[ $percentage == "100%" ]]; then
			icon=""
		else
			icon=${chargedMap[${percentage:0:1}]}
		fi
	fi

	local slot
	slot=$(printf "%s %s" "$icon" "$percentage")
	segment "$1" "$2" "$slot"
}

# mrwatson: Displays current Watson project status
function mrwatson() {
	local status=""
	if [[ "$(bkt --ttl="$bkt_ttl" -- watson status)" == "No project started." ]]; then
		status=""
	fi

	local total
	total=$(bkt --ttl="$bkt_ttl" -- watson report -dcG | grep 'Total:' | sed 's/Total: //')

	local slot
	slot=$(printf "%s %s" "$status" "$total")
	segment "$1" "$2" "$slot"
}

# taskwarrior: Example for Taskwarrior tasks
function taskwarrior() {
	local outstanding
	outstanding=$(task count status:pending -TODAY)
	local urgent
	urgent=$(task count status:pending +TODAY)
	local slot
	slot=$(printf " %s  %s" "$urgent" "$outstanding")
	segment "$1" "$2" "$slot"
}

# datetime: Displays the current date and time
function datetime() {
	local dateTime
	dateTime=$(bkt --ttl="$bkt_ttl" -- date +'%h-%d %I:%M %p')
	local slot
	slot=$(printf "  %s" "$dateTime")
	segment "$1" "$2" "$slot"
}

# node_npm_version: Displays Node.js and npm versions
function node_npm_version() {
	local node_version
	node_version=$(bkt --ttl="$bkt_ttl" -- node --version | sed -e 's/v//g')
	local npm_version
	npm_version=$(bkt --ttl="$bkt_ttl" -- npm --version)
	local slot
	slot=$(printf " %s  %s" "$node_version" "$npm_version")
	segment "$1" "$2" "$slot"
}

# spotify: Placeholder for displaying Spotify status (currently not implemented)
function spotify() {
	printf "#[fg=%s]#[fg=%s]#[bg=%s] ♫ #{music_status} #{artist}: #{track} #[bg=%s]" \
		"$1" "$2" "$1" "$1"
}

###############################################################################
# Main Execution Function
###############################################################################

function main() {
	# CPU usage with pink text on a dark gray background
	cpu "$pink" "$dark_gray"

	# Battery indicator with orange text on dark gray background
	battery "$orange" "$dark_gray"

	# Current Watson project status with yellow text on dark gray background
	mrwatson "$yellow" "$dark_gray"

	# Uncomment to show Taskwarrior tasks
	# taskwarrior "$green" "$dark_gray"

	# Uncomment to show Node.js and npm versions
	# node_npm_version "$cyan" "$dark_gray"

	# Date and time with cyan text on dark gray background
	datetime "$cyan" "$dark_gray"

	# Add a trailing space or separator at the end
	printf " "
}

# Execute the script
main
