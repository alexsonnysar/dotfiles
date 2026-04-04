#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"

CASK_PACKAGES=(
    font-jetbrains-mono-nerd-font
    ghostty
    microsoft-edge
    spotify
    visual-studio-code
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

install_xcode_cli() {
    if xcode-select -p &>/dev/null; then
        warn "Xcode Command Line Tools already installed, skipping."
        return
    fi
    log "🛠️ Installing Xcode Command Line Tools..."
    xcode-select --install
    success "Xcode Command Line Tools installed."
}

install_homebrew() {
    if command -v brew &>/dev/null; then
        warn "Homebrew already installed, skipping."
        return
    fi
    log "🍺 Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    success "Homebrew installed."
}

install_cli_tools() {
    log "📦 Installing CLI tools..."
    brew bundle install
    success "CLI tool installation complete."
}

install_gui_apps() {
    log "📦 Installing GUI apps..."
    brew install --cask "${CASK_PACKAGES[@]}"
    success "GUI app installation complete."
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
    install_xcode_cli
    install_homebrew
    install_cli_tools
    install_gui_apps
    stow_dotfiles
    success "Dotfiles installed successfully."
}

main "$@"
