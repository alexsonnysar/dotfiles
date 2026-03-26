# Detect OS
if [[ "$(uname)" == "Darwin" ]]; then
  OS="macos"
elif [[ "$(uname)" == "Linux" ]]; then
  OS=$(grep ^ID= /etc/os-release | cut -d= -f2)
fi

# Homebrew
if [[ "$OS" == "macos" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
elif [[ "$OS" == "ubuntu" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# Completion
autoload -Uz compinit
compinit

# Aliases
alias ls="eza --icons"
alias la="eza --all --icons"
alias lt="eza --tree --icons"

# Starship
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# Mise
eval "$(mise activate zsh)"

# Plugins
if [[ "$OS" == "macos" || "$OS" == "ubuntu" ]]; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ "$OS" == "arch" ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
