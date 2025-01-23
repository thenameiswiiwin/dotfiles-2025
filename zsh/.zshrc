# Path to your oh-my-zsh installation.
# Reevaluate the prompt string each time it's displaying a prompt
setopt prompt_subst
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit
source <(kubectl completion zsh)
complete -C '/usr/local/bin/aws_completer' aws

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Source fzf if it exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source custom aliases
[ -f ~/.aliases ] && source ~/.aliases

bindkey -s "^f" "tmux-sessionizer\n"

eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval $(thefuck --alias)
eval $(thefuck --alias fk)
eval "$(zoxide init zsh)"
eval "$(fnm env)"

# Initialize completion system
autoload -Uz compinit
compinit
