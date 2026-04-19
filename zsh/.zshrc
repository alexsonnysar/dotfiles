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

# Zinit
source "${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git/zinit.zsh"

# Plugins & Completion
autoload -Uz compinit && compinit
zinit light zsh-users/zsh-completions
zinit light aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Aliases
alias ls="eza --icons"
alias la="eza --all --icons"
alias lt="eza --tree --icons --git-ignore"

# Shell Integrations
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
eval "$(fzf --zsh)"
