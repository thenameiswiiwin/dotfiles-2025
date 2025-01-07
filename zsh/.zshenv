# Add custom directories to the PATH
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"  # Adjusted to include bin folder for cargo
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Set editor preferences to use Neovim
export GIT_EDITOR="nvim"
export VISUAL="nvim"
export EDITOR="nvim"

# Set terminal type
export TERM="xterm-256color"

# Load Cargo environment
. "$HOME/.cargo/env"
