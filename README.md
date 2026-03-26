# My Dotfiles

> **WIP:** This README is still a work in progress and largely AI-generated. Will be customized over time as I settle on a universal config across Ubuntu, Arch, and macOS.

Hey y'all! This is how I setup my dotfiles when switching between MacOS and Linux Distros. I'm using [GNU Stow](https://www.gnu.org/software/stow/) to system link configuration files to my dotfiles repo. I'll be updating this README as I get closer to a universal setup.

## Installation

### 1. WSL

Open PowerShell and install a distro:

```powershell
# List available distros
wsl --list --online

wsl --install Ubuntu-<version>
```

### 2. Update packages

```bash
sudo apt update && sudo apt upgrade
```

### 3. Make Zsh the Default Shell

```bash
sudo apt install zsh
chsh -s $(which zsh)
```

### 4. Shell Prompt | [Starship](https://starship.rs/)

```bash
# Ubuntu 25.04+
sudo apt install starship

# Older versions
curl -sS https://starship.rs/install.sh | sh
```

### 5. Zsh Plugins & Utilities

```bash
sudo apt install zoxide fzf eza zsh-syntax-highlighting zsh-autosuggestions
```

| Package                                                                         | Description                   |
| ------------------------------------------------------------------------------- | ----------------------------- |
| [zoxide](https://github.com/ajeetdsouza/zoxide)                                 | Smarter `cd`                  |
| [fzf](https://github.com/junegunn/fzf)                                          | Fuzzy finder                  |
| [eza](https://github.com/eza-community/eza)                                     | Modern `ls` replacement       |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Fish-like syntax highlighting |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)         | Fish-like autosuggestions     |

### 6. Dev Tools

**[mise](https://mise.jdx.dev/)** — runtime version manager (replaces asdf/nvm/pyenv):

```bash
# Ubuntu 25.04+
sudo apt install mise

# Older versions
curl https://mise.run | sh
```

Config is managed at `~/.config/mise.toml` via the `mise` stow package. Currently manages:

- `node` (LTS)

**[SDKMAN](https://sdkman.io/)** — SDK manager for JVM-based tools (Java, Gradle, Maven, etc.):

```bash
# Ensure dependencies are installed first
sudo apt install bash zip unzip curl

curl -s "https://get.sdkman.io" | bash
```

Then install JVM tooling:

```bash
sdk install java    # latest LTS
sdk install gradle
sdk install maven
```

> SDKMAN manages its own init in `.zshrc` and does not require stowing.

### 7. Stow

```bash
sudo apt install stow
```

### 8. Git

```bash
git config --global init.defaultBranch main
```

---

## Dotfiles Setup

Clone the repo and use `stow` to symlink each config into your home directory:

```bash
git clone https://github.com/alexsonnysar/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Stow individual packages
stow git
stow zsh
stow mise
stow starship

# Or stow everything at once
stow */
```

Each folder corresponds to a package. Stow will symlink its contents relative to `~`.
