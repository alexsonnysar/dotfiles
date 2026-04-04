# My Dotfiles

<p align="center">
  <img width="800" height="503" alt="Screenshot 2026-04-04 at 7 42 05 AM" src="https://github.com/user-attachments/assets/4a7d51fe-7dca-4220-abd0-2894d11fead8" />
</p>

Hey y'all! This is how I setup my dotfiles when switching between macOS, Arch, and Ubuntu. I'm using [GNU Stow](https://www.gnu.org/software/stow/) to symlink configuration files from this repo into `~`.

## Installation

Clone the repo, then run the install script for your platform:

```bash
git clone https://github.com/alexsonnysar/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### Arch

```bash
bash install-arch.sh
```

### macOS

```bash
bash install-macos.sh
```

### Ubuntu

```bash
bash install-ubuntu.sh
```

## CLI Tools & Plugins

| Tool | Description |
| ---- | ----------- |
| [starship](https://starship.rs/) | Cross-shell prompt |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [eza](https://github.com/eza-community/eza) | Modern `ls` replacement |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Fish-like syntax highlighting |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-like autosuggestions |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | System info fetch tool |
| [mise](https://mise.jdx.dev/) | Runtime version manager (node, python, etc.) |

---

## Dotfiles Structure

Each top-level folder is a stow package. Stow symlinks its contents relative to `~`.

| Package    | Description              |
| ---------- | ------------------------ |
| `git/`     | Git config               |
| `mise/`    | mise runtime config      |
| `starship/`| Starship prompt config   |
| `zsh/`     | Zsh config (`.zshrc`)    |
