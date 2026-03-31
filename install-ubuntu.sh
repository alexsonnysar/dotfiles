#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"

PREREQUISITES=(
    build-essential
    curl
    git
    unzip
    zip
    zsh
)
BREW_PACKAGES=(
    stow
    starship
    zoxide
    fzf
    eza
    zsh-syntax-highlighting
    zsh-autosuggestions
    fastfetch
    mise
    wget
    nvim
)

# ── Colors ─────────────────────────────────────────────────────────────────────

RESET="\033[0m"
CYAN="\033[0;96m"
YELLOW="\033[0;93m"
RED="\033[0;91m"
GREEN="\033[0;92m"

# ── Helpers ────────────────────────────────────────────────────────────────────

log()   { echo -e "${CYAN}[INFO]${RESET} $*"; }
warn()  { echo -e "${YELLOW}[WARN]${RESET} $*"; }
error() { echo -e "${RED}[ERROR]${RESET} $*" >&2; exit 1; }
success()  { echo -e "${GREEN}[SUCCESS]${RESET} $*"; }

# ── Steps ──────────────────────────────────────────────────────────────────────

request_sudo() {
    log "🔒 Requesting sudo privileges..."
    sudo -v || error "Failed to obtain sudo privileges."
    success "Sudo privileges granted."
}

install_prerequisites() {
    log "📦 Installing prerequisites..."
    sudo apt update && sudo apt install -y --no-upgrade "${PREREQUISITES[@]}"
    success "Prerequisites installed."
}

configure_shell() {
    log "💲 Setting Zsh as default shell..."
    sudo usermod -s "$(which zsh)" "$USER"
    success "Default shell set to Zsh."
}

install_homebrew() {
    if command -v brew &>/dev/null; then
        warn "Homebrew already installed, skipping."
        return
    fi
    log "🍺 Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    success "Homebrew installed."
}

install_brew_packages() {
    log "📦 Installing packages..."
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
    install_prerequisites
    configure_shell
    install_homebrew
    install_brew_packages
    stow_dotfiles
    success "Dotfiles installed successfully."
}

main "$@"
