#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"

PREREQUISITES=(
    git
    curl
    wget
    zip
    unzip
)

PACKAGES=(
    zsh
    stow
    zoxide
    fzf
    neovim
    eza
    fastfetch
    starship
    mise
)

COPR_REPOS=(
    atim/starship
    jdxcode/mise
)

# ── Colors ─────────────────────────────────────────────────────────────────────

RESET="\033[0m"
CYAN="\033[0;96m"
YELLOW="\033[0;93m"
RED="\033[0;91m"
GREEN="\033[0;92m"

# ── Helpers ────────────────────────────────────────────────────────────────────

log()     { echo -e "${CYAN}[INFO]${RESET} $*"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET} $*"; }
error()   { echo -e "${RED}[ERROR]${RESET} $*" >&2; exit 1; }
success() { echo -e "${GREEN}[SUCCESS]${RESET} $*"; }

# ── Steps ──────────────────────────────────────────────────────────────────────

request_sudo() {
    log "🔒 Requesting sudo privileges..."
    sudo -v || error "Failed to obtain sudo privileges."
    success "Sudo privileges granted."
}

install_prerequisites() {
    log "📦 Installing prerequisites..."
    sudo dnf install -y "${PREREQUISITES[@]}"
    success "Prerequisites installed."
}

install_cli_tools() {
    log "📦 Installing CLI tools..."
    for repo in "${COPR_REPOS[@]}"; do
        sudo dnf copr enable -y "$repo"
    done
    sudo dnf install -y "${PACKAGES[@]}"
    success "CLI tool installation complete."
}

configure_shell() {
    log "💲 Setting Zsh as default shell..."
    sudo usermod -s "$(which zsh)" "$USER"
    success "Default shell set to Zsh."
}

install_zinit() {
    log "🔌 Installing Zinit..."
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
    success "Zinit installed."
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
    install_cli_tools
    configure_shell
    install_zinit
    stow_dotfiles
    success "Dotfiles installed successfully."
}

main "$@"
