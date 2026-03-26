#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
SPINCHARS='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'

run_step() {
    local msg="$1"; shift
    local i=0 code=0
    "$@" &>/dev/null &
    local pid=$!
    tput civis 2>/dev/null || true
    while kill -0 "$pid" 2>/dev/null; do
        printf "\r  ${SPINCHARS:$i:1} %s" "$msg"
        i=$(( (i + 1) % ${#SPINCHARS} ))
        sleep 0.08
    done
    tput cnorm 2>/dev/null || true
    wait "$pid" || code=$?
    if [ $code -eq 0 ]; then
        printf "\r  \033[0;32m✓\033[0m %s\n" "$msg"
    else
        printf "\r  \033[0;31m✗\033[0m %s (exit $code)\n" "$msg"
        exit $code
    fi
}

echo "🔒 Enter superuser credentials..."
sudo -v

echo ""
echo "📦 Updating and upgrading distro packages..."
run_step "apt update && apt upgrade"   sudo apt update && sudo apt upgrade -y
echo ""
echo "📦 Installing core packages..."
for pkg in zsh stow git zip unzip curl bash build-essential; do
    run_step "$pkg" sudo apt install -y "$pkg"
done

echo ""
echo "💲 Configuring shell..."
run_step "Set Zsh as default shell" sudo usermod -s "$(which zsh)" "$USER"

echo ""
echo "➡️ Symlinking dotfiles..."
run_step "stow dotfiles" bash -c "cd \"$DOTFILES_DIR\" && stow */"

echo ""
echo "📦 Installing Homebrew..."
if ! command -v brew &>/dev/null; then
    _brew_install=$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
    run_step "Homebrew" env NONINTERACTIVE=1 /bin/bash -c "$_brew_install"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    printf "  \033[0;32m✓\033[0m Homebrew already installed\n"
fi

echo ""
echo "🔌 Installing CLI tools..."
for pkg in starship zoxide fzf eza zsh-syntax-highlighting zsh-autosuggestions fastfetch; do
    run_step "$pkg" brew install "$pkg"
done

echo ""
echo "⚙️ Installing dev tools..."
run_step "mise" brew install mise
run_step "SDKMan" bash -c 'curl -s "https://get.sdkman.io" | bash'

echo ""
echo "Done! Please restart your terminal to apply all changes."
