#!/bin/bash

echo "Starting macOS Customization Script for macOS Sequoia (15.2)..."

# Request administrator privileges upfront
sudo -v
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

echo "Customizing General UI/UX settings..."

# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelayhigh 86400
sudo pmset -a standbydelaylow 86400

# Disable sound effects on boot
sudo nvram SystemAudioVolume=" "

# Reduce transparency for better performance
defaults write com.apple.universalaccess reduceTransparency -bool true

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Expand save and print panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once jobs are complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Check for software updates daily
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable smart quotes and dashes (useful for coding)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

###############################################################################
# SSD Tweaks                                                                  #
###############################################################################

echo "Applying SSD tweaks..."

# Disable local Time Machine snapshots
sudo tmutil disablelocal

# Disable hibernation for faster sleep mode
sudo pmset -a hibernatemode 0

# Remove sleep image file to save disk space
sudo rm -f /private/var/vm/sleepimage
sudo touch /private/var/vm/sleepimage
sudo chflags uchg /private/var/vm/sleepimage

# Disable sudden motion sensor (not useful for SSDs)
sudo pmset -a sms 0

###############################################################################
# Trackpad, Mouse, and Keyboard                                               #
###############################################################################

echo "Configuring trackpad, mouse, and keyboard settings..."

# Enable tap-to-click for the trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable “natural” scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

###############################################################################
# Finder                                                                      #
###############################################################################

echo "Configuring Finder settings..."

# Show all hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Set default Finder location to Home folder
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Avoid creating .DS_Store files on network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

###############################################################################
# Dock                                                                        #
###############################################################################

echo "Configuring Dock settings..."

# Set Dock size
defaults write com.apple.dock tilesize -int 48

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Minimize windows into application icons
defaults write com.apple.dock minimize-to-application -bool true

# Disable recent applications in Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Safari                                                                      #
###############################################################################

echo "Configuring Safari settings..."

# Show full URL in address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Prevent Safari from opening 'safe' files automatically
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Enable Developer menu and Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Terminal & iTerm2                                                           #
###############################################################################

echo "Configuring Terminal & iTerm2 settings..."

# Use only UTF-8 in Terminal
defaults write com.apple.terminal StringEncodings -array 4

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

###############################################################################
# Activity Monitor                                                            #
###############################################################################

echo "Configuring Activity Monitor..."

# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Kill Affected Applications                                                  #
###############################################################################

echo "Restarting affected applications..."

for app in "Activity Monitor" "Dock" "Finder" "Safari" "SystemUIServer" \
	"Terminal"; do
	killall "${app}" &>/dev/null
done

echo "Customization script completed! Note: Some changes may require a logout or restart to take effect."
