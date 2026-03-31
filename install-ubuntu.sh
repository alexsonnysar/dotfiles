#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"

APT_PACKAGES=(
    zsh
    stow
    git
    zip
    unzip
    curl
    build-essential
)

BREW_PACKAGES=(
    starship
    zoxide
    fzf
    eza
    zsh-syntax-highlighting
    zsh-autosuggestions
    fastfetch
    mise
    wget
)

# ── Colors ─────────────────────────────────────────────────────────────────────

RESET="\033[0m"
CYAN="\033[0;96m"
YELLOW="\033[0;93m"
RED="\033[0;91m"
GREEN="\033[0;92m"

# ── Helpers ────────────────────────────────────────────────────────────────────

log()   { echo -e "${CYAN}[INFO]${RESET} $*"; }
warn()  { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
error() { echo -e "${RED}[ERROR]${RESET} $*" >&2; exit 1; }
success()  { echo -e "${GREEN}[SUCCESS]${RESET} $*"; }

# ── Steps ──────────────────────────────────────────────────────────────────────

request_sudo() {
    log "Requesting sudo privileges..."
    sudo -v || error "Failed to obtain sudo privileges."
    success "Sudo privileges granted."
}

install_apt_packages() {
    log "📦 Updating apt and installing core packages..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y "${APT_PACKAGES[@]}"
    success "APT package installation complete."
}

configure_shell() {
    log "💲 Setting Zsh as default shell..."
    sudo usermod -s "$(which zsh)" "$USER"
    success "Default shell set to Zsh."
}

install_homebrew() {
    log "📦 Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    success "Homebrew installed."
}

install_brew_packages() {
    log "📦 Installing CLI tools via Homebrew..."
    brew install "${BREW_PACKAGES[@]}"
    success "Brew package installation complete."
}

stow_dotfiles() {
    log "➡️ Stowing dotfiles..."
    cd "$DOTFILES_DIR"
    stow --adopt */
    git restore .
    success "Stow complete."
}

# ── Main ───────────────────────────────────────────────────────────────────────

main() {
    request_sudo
    log "Starting dotfiles installation..."
    install_apt_packages
    configure_shell
    install_homebrew
    install_brew_packages
    stow_dotfiles
    success "Dotfiles installed successfully."
}

main "$@"
