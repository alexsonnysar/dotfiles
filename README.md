# My Dotfiles

> **WIP:** This README is still a work in progress and largely AI-generated. Will be customized over time as I settle on a universal config across Ubuntu, Arch, and macOS.

Hey y'all! This is how I setup my dotfiles when switching between MacOS and Linux Distros. I'm using [GNU Stow](https://www.gnu.org/software/stow/) to symlink configuration files from this repo into `~`. I'll be updating this README as I get closer to a universal setup.

## Installation (Ubuntu)

Clone the repo, then run the install script:

```bash
git clone https://github.com/alexsonnysar/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash install-ubuntu.sh
```

The script will:

1. Prompt for `sudo` credentials
2. Run `apt update && apt upgrade`
3. Install core packages: `zsh`, `stow`, `git`, `zip`, `unzip`, `curl`, `bash`, `build-essential`
4. Set Zsh as the default shell
5. Stow all dotfile packages (`stow */`)
6. Install [Homebrew](https://brew.sh/) (if not already installed)
7. Install CLI tools via Homebrew: `starship`, `zoxide`, `fzf`, `eza`, `zsh-syntax-highlighting`, `zsh-autosuggestions`, `fastfetch`
8. Install dev tools:
   - **[mise](https://mise.jdx.dev/)** — runtime version manager (replaces asdf/nvm/pyenv)
   - **[SDKMAN](https://sdkman.io/)** — SDK manager for JVM-based tools (Java, Gradle, Maven, etc.)

Restart your terminal after the script completes to apply all changes.

---

### WSL Setup

If running on WSL, first open PowerShell and install a distro:

```powershell
wsl --list --online
wsl --install Ubuntu-<version>
```

Then clone and run the install script as above.

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
| [SDKMAN](https://sdkman.io/) | JVM SDK manager (Java, Gradle, Maven, etc.) |

---

## Dotfiles Structure

Each top-level folder is a stow package. Stow symlinks its contents relative to `~`.

| Package    | Description              |
| ---------- | ------------------------ |
| `git/`     | Git config               |
| `mise/`    | mise runtime config      |
| `starship/`| Starship prompt config   |
| `zsh/`     | Zsh config (`.zshrc`)    |
