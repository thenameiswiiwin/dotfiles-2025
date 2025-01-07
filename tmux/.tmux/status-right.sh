#!/bin/bash

# Set cache TTL for bkt (to optimize repeated commands)
bkt_ttl='15s'

# Define color palette
white='#f8f8f2'
gray='#44475a'
dark_gray='#282a36' # Dracula theme
light_purple='#bd93f9'
dark_purple='#6272a4'
cyan='#8be9fd'
green='#50fa7b'
orange='#ffb86c'
red='#ff5555'
pink='#ff79c6'
yellow='#f1fa8c'

# Function to generate powerline segment
generate_segment() {
	printf "#[fg=%s]#[fg=%s]#[bg=%s] %s #[bg=%s]" "$1" "$2" "$1" "$3" "$1"
}

# CPU usage segment
cpu() {
	local cpu_value=$(bkt --ttl=$bkt_ttl -- ps -A -o %cpu | awk -F. '{s+=$1} END {print s}')
	local cpu_cores=$(bkt --ttl=$bkt_ttl -- sysctl -n hw.logicalcpu)
	local cpu_usage=$((cpu_value / cpu_cores))
	local display=$(printf "  %02d%%" "$cpu_usage")
	generate_segment "$1" "$2" "$display"
}

# Battery segment
battery() {
	local status=$(bkt --ttl=$bkt_ttl -- pmset -g batt | awk -F';' 'NR==2 {print $2}' | tr -d ' ')
	local percentage=$(bkt --ttl=$bkt_ttl -- pmset -g batt | grep -Eo '[0-9]+%' | tr -d '%')
	local icon=""

	if [[ "$status" == "charging" ]]; then
		icon=$([[ "$percentage" -eq 100 ]] && echo "" || echo "")
	else
		icon=$([[ "$percentage" -eq 100 ]] && echo "" || echo "")
	fi

	local display=$(printf "%s %s%%" "$icon" "$percentage")
	generate_segment "$1" "$2" "$display"
}

# Watson time tracker segment
mrwatson() {
	local status=$(bkt --ttl=$bkt_ttl -- watson status)
	local icon=$([[ "$status" == "No project started." ]] && echo "" || echo "")
	local total=$(bkt --ttl=$bkt_ttl -- watson report -dcG | awk '/Total:/ {print $2}')
	local display=$(printf "%s %s" "$icon" "$total")
	generate_segment "$1" "$2" "$display"
}

# Date and time segment
datetime() {
	local date_time=$(bkt --ttl=$bkt_ttl -- date +'%b-%d %I:%M %p')
	local display=$(printf "  %s" "$date_time")
	generate_segment "$1" "$2" "$display"
}

# Node.js and NPM versions segment
node_npm_version() {
	local node_version=$(bkt --ttl=$bkt_ttl -- node --version | sed 's/v//')
	local npm_version=$(bkt --ttl=$bkt_ttl -- npm --version)
	local display=$(printf " %s  %s" "$node_version" "$npm_version")
	generate_segment "$1" "$2" "$display"
}

# Spotify segment
function spotify() {
	local status=$(osascript -e 'tell application "Spotify" to if it is running then player state as string')
	local artist=""
	local track=""

	if [[ "$status" == "playing" ]]; then
		artist=$(osascript -e 'tell application "Spotify" to artist of current track as string')
		track=$(osascript -e 'tell application "Spotify" to name of current track as string')
		printf "#[fg=$1]#[fg=$2]#[bg=$1] ♫ Playing: %s - %s #[bg=$1]" "$artist" "$track"
	elif [[ "$status" == "paused" ]]; then
		printf "#[fg=$1]#[fg=$2]#[bg=$1] ♫ Paused #[bg=$1]"
	else
		printf "#[fg=$1]#[fg=$2]#[bg=$1] ♫ Not Playing #[bg=$1]"
	fi
}

# Main function to construct the status bar
main() {
	cpu "$pink" "$dark_gray"
	battery "$orange" "$dark_gray"
	mrwatson "$yellow" "$dark_gray"
	datetime "$cyan" "$dark_gray"
	printf " "
}

# Execute the main function
main
