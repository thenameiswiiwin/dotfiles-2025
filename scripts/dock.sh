#1/bin/bash

# Remove Dock items
echo -b 'Setting defaults for Dock...'

main() {
	if type dockutil &>/dev/null; then

		dockutil --no-restart \
			--remove 'System Preferences' \
			--remove 'App Store' \
			--remove 'Maps' \
			--remove 'Photos' \
			--remove 'Messages' \
			--remove 'Contacts' \
			--remove 'Calendar' \
			--remove 'FaceTime' \
			--remove 'Feedback Assistant' \
			--remove 'Siri' \
			--remove 'Launchpad' \
			--remove 'Numbers' \
			--remove 'Pages' \
			--remove 'Keynote' \
			--remove 'iBooks' \
			--remove 'Mail' \
			--remove 'Music' \
			--remove 'Podcasts' \
			--remove 'Safari' \
			--remove 'TV' \
			--remove 'News' \
			--remove 'Notes' \
			--add /Applications/kitty.app \
			--add /Applications/Brave\ Browser.app \
			&>/dev/null

		killall cfprefsd &>/dev/null
		killall -HUP Dock &>/dev/null

	else
		echo 'ERROR: dockutil not found'
	fi
}

main
