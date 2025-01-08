# Add custom directories to the PATH
export PATH="$HOME/bin:$PATH"                  # User-specific scripts
export PATH="$HOME/go/bin:$PATH"               # Go binary directory
export PATH="$HOME/.cargo/bin:$PATH"           # Rust's Cargo binary directory
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH" # Neovim binary directory for Bob
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH" # Homebrew paths for macOS

# Set editor preferences to use Neovim
export GIT_EDITOR="nvim"   # Editor for Git commit messages
export VISUAL="nvim"       # Visual editor preference
export EDITOR="nvim"       # Default editor preference

# Set terminal type for better compatibility
export TERM="xterm-256color"

# Load Cargo environment for Rust tools
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
