#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"

PREREQUISITES=(
    base-devel
    git
    curl
    wget
    zip
    unzip
)
PACKAGES=(
    zsh
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

install_prerequisites() {
    log "📦 Installing prerequisites..."
    sudo pacman -S --noconfirm --needed "${PREREQUISITES[@]}"
    success "Prerequisites installed."
}

install_packages() {
    log "📦 Installing packages..."
    sudo pacman -S --noconfirm --needed "${PACKAGES[@]}"
    success "Package installation complete."
}

stow_dotfiles() {
    log "➡️ Stowing dotfiles..."
    cd "$DOTFILES_DIR"
    stow --adopt */
    git restore .
    success "Stow complete."
}

configure_shell() {
    log "💲 Setting Zsh as default shell..."
    sudo usermod -s "$(which zsh)" "$USER"
    success "Default shell set to Zsh."
}

# ── Main ───────────────────────────────────────────────────────────────────────

main() {
    request_sudo
    log "Starting dotfiles installation..."
    install_prerequisites
    install_packages
    configure_shell
    stow_dotfiles
    success "Dotfiles installed successfully."
}

main "$@"
