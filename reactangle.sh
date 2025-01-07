#!/bin/bash

# Auto Import Rectangle Configuration

# Specify the path to your RectangleConfig.json file
config_file="$HOME/RectangleConfig.json" # Change to your actual config file path

# Check if Rectangle is installed
if ! command -v rectangle >/dev/null 2>&1; then
	echo "Error: Rectangle is not installed. Please install Rectangle first."
	exit 1
fi

# Check if the configuration file exists
if [ ! -f "$config_file" ]; then
	echo "Error: RectangleConfig.json file not found at '$config_file'. Please provide the correct path."
	exit 1
fi

# Import the configuration
if rectangle config import "$config_file"; then
	echo "Rectangle configuration imported successfully."
else
	echo "Error: Failed to import Rectangle configuration."
	exit 1
fi

exit 0
