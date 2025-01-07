#!/bin/sh

echo "Mac OS Install Setup Script"

# Request sudo upfront and keep it alive
echo "Requesting sudo privileges..."
sudo -v
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

echo "Installing Xcode Command Line Tools..."
if ! xcode-select --print-path &>/dev/null; then
    xcode-select --install
else
    echo "Xcode Command Line Tools are already installed."
fi

# Install Homebrew
echo "Installing Homebrew..."
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
    brew update && brew upgrade
fi

# Install packages and applications
echo "Installing packages and applications via Homebrew..."
brew install bat
brew install btop
brew install brave-browser
brew install cleanmymac
brew install dooit
brew install eza
brew install fd
brew install fzf
brew install gdu
brew install gh
brew install git
brew install glow
brew install hyperfine
brew install jq
brew install kitty
brew install lazydocker
brew install lazygit
brew install nordvpn
brew install rectangle
brew install ripgrep
brew install spotify
brew install stow
brew install taskell
brew install tmux
brew install trash-cli
brew install viddy
brew install viu
brew install watson
brew install wezterm
brew install wifi-password
brew install zellij
brew install zoxide
brew install 1password
brew install 1password-cli

# Install zap - this didn't work via script
# zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

# Node.js and npm setup
echo "Installing Node.js via fnm..."
brew install fnm
eval "$(fnm env)"
fnm install --lts
fnm use --lts
fnm default --lts

echo "Installing global npm packages..."
npm install -g fkill-cli @githubnext/github-copilot-cli npkill
brew install yarn

# Rust setup
echo "Installing Rust..."
if ! command -v rustc &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
fi

echo "Installing Rust applications..."
cargo install bob-nvim
bob install stable
bob use stable

# Python setup
echo "Installing Python..."
if ! command -v python3 &> /dev/null; then
    brew install python3
else
    echo "Python3 is already installed. Upgrading..."
    brew upgrade python3
fi

echo "Setting up Python environment..."
python3 -m ensurepip --upgrade
python3 -m pip install --upgrade pip setuptools wheel

# Python applications
echo "Installing Python packages..."
pip3 install --user pylint flake8

# GUI applications
echo "Installing GUI applications..."
# brew install azure-data-studio
# brew install meetingbar
brew install orbstack

# Clean up
echo "Cleaning up Homebrew..."
brew cleanup

# Fonts
echo "Installing fonts..."
brew install --cask font-jetbrains-mono font-jetbrains-mono-nerd-font font-victor-mono font-victor-mono-nerd-font font-symbols-only-nerd-font

# Git configuration
echo "Setting up Git..."
git config --global user.name 'Huy Nguyen'
git config --global user.email 'huyn.nguyen95@gmail.com'
git config --global credential.helper store

# Tmux Plugin Manager
echo "Installing Tmux Plugin Manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "Tmux Plugin Manager is already installed."
fi

# Personal dotfiles
echo "Installing personal dotfiles..."
if [ ! -d "$HOME/dotfiles" ]; then
    git clone https://github.com/thenameiswiiwin/dotfiles-2025.git ~/dotfiles
    cd ~/dotfiles
else
    echo "Dotfiles repository already cloned."
fi

echo ""
echo "Installation complete!"
