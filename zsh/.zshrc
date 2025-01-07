#!/usr/bin/env bash

# Load Zap configuration if it exists
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Plugins for Zsh
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/exa"
plug "zap-zsh/vim"
plug "wintermi/zsh-fnm"

# Aliases
alias dockerps="docker ps --format 'table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}'"

# Function to run npm scripts using fzf for selection
function runr() { 
  jq -r '.scripts | keys[]' package.json |
    fzf \
      --header="Select a script to run…" \
      --prompt="󰎙 Script  " \
      --preview "jq -r '.scripts | { {1} } | .[]' package.json" \
      --preview-window="down,1,border-horizontal" \
      --height="50%" \
      --layout="reverse" | \
    xargs -o npm run
}

# Source custom aliases
source ~/.aliases

# jqf: Interactive jq playground with fzf
function jqf() {
  echo "" | \
    fzf \
      --disabled \
      --print-query \
      --preview "jq -C {q} $1" \
      --prompt="Query  " \
      --header="Interactive jq playground" \
      --preview-window="down:90"
}

# tzf: Select and list timezones
function tzf() {
  tz -list | fzf -m | awk '{print $4}' | tr "\n" ";" | xargs -I {} sh -c "TZ_LIST='{}' tz"
}

# ghpr: List and view GitHub pull requests with fzf
function ghpr() {
  GH_FORCE_TTY=100% gh pr list | fzf --query "$1" --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout -f  
}

# ghgist: List and edit GitHub gists with fzf
function ghgist() {
  GH_FORCE_TTY=100% gh gist list --limit 20 | fzf --ansi --preview 'GH_FORCE_TTY=100% gh gist view {1}' --preview-window down | awk '{print $1}' | xargs gh gist edit
}

# Function to select and open a specific Neovim configuration
function nvims() {
  items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
bindkey -s "^b" "nvims\n"

# Developer tools alias
local dev_commands=(
  'tz' 'task' 'watson' 'archey' 'ncdu'
  'fkill' 'lazydocker' 'ntl' 'ranger'
  'speed-test' 'serve' 'vtop' 'htop' 'btop'
  'lazygit' 'gitui' 'tig' 'tldr'
  'calcurse' 'cmatrix' 'exa' 'fd' 'dooit' 'taskell' 'gh' 'gitui' 'hyperfine'
  'mc' 'navi' 'neofetch' 'nnn' 'tree' 'vhs' 'vifm' 'zellij' 'tmux' 'zoxide'
)

alias dev='printf "%s\n" "${dev_commands[@]}" | fzf --height 20% --header Commands | bash'

# Bind tmux sessionizer to a hotkey
bindkey -s "^f" "tmux-sessionizer\n"
# bindkey -s ^f "zellij-switch\n"  # Uncomment to use with Zellij

# Source fzf if it exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source private zshrc if it exists
[ -r ~/private/.zshrc ] && source ~/private/.zshrc

# Initialize completion system
autoload -Uz compinit
compinit

# Initialize environment variables and tools
eval "$(/usr/local/bin/brew shellenv)"  # For Homebrew
eval "$(fnm env --use-on-cd --log-level=quiet)"  # For fnm (Node.js version manager)
eval "$(zoxide init zsh)"  # For zoxide (faster navigation)

# Uncomment for GitHub Copilot CLI if needed
# eval "$(github-copilot-cli alias -- "$0")"
