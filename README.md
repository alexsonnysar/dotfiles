# My Dotfiles

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

The script will:

1. Prompt for `sudo` credentials
2. Install all packages via `pacman`
3. Stow all dotfile packages

### macOS

```bash
bash install-macos.sh
```

The script will:

1. Prompt for `sudo` credentials
2. Install Xcode Command Line Tools
3. Install [Homebrew](https://brew.sh/)
4. Install all packages via Homebrew
5. Stow all dotfile packages

### Ubuntu

```bash
bash install-ubuntu.sh
```

The script will:

1. Prompt for `sudo` credentials
2. Run `apt update && apt upgrade` and install core packages (`zsh`, `stow`, `git`, `curl`, `build-essential`, etc.)
3. Set Zsh as the default shell
4. Install [Homebrew](https://brew.sh/)
5. Install CLI tools via Homebrew
6. Stow all dotfile packages

### WSL

If running on WSL, first open PowerShell and install a distro:

```powershell
wsl --list --online
wsl --install Ubuntu-<version>
```

Then clone and run the Ubuntu install script as above.

---

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
