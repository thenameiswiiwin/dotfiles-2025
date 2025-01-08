# Dotfiles 2025

## Getting Started

### Install Brew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Clone this Repo

```bash
git clone git@github.com:thenameiswiiwin/dotfiles-2025.git ~/.dotfiles
```

### List Files

```bash
tree -a -I '.git|.DS_Store'
```

### Install Packages

```bash
brew bundle
```

### Symlink dotfiles

```bash
stow aliases rectangle github-copilot hushlogin stow bin kitty lazygit nvim tmux wezterm zsh zellij bat lf pistol
```

## Scripts

- **osx.sh**: Configures macOS-specific settings to optimize your development environment.
- **install.sh**: Automates the installation of essential tools and configurations. Run this to set up your environment quickly.

### Run Scripts

```bash
chmod +x osx.sh install.sh
./install.sh
./osx.sh
```

## Features

### Neovim

- [Neovim](https://neovim.io/) - A modern, extensible Vim-based text editor.
- **LazyVim** - A pre-configured Neovim setup that optimizes for productivity.
- **AstroNvim** - A highly customizable Neovim user interface framework.

### Kitty

- [Kitty](https://sw.kovidgoyal.net/kitty/) - A GPU-based terminal emulator that is fast and feature-rich.

### WezTerm

- [WezTerm](https://wezfurlong.org/wezterm/) - A GPU-accelerated terminal emulator and multiplexer.

### Stow

- [Stow](https://www.gnu.org/software/stow/) - A symlink farm manager that makes managing dotfiles easy.

### Bat

- [Bat](https://github.com/sharkdp/bat) - A cat clone with syntax highlighting and Git integration.

### Zellij

- [Zellij](https://zellij.dev/) - A terminal workspace and multiplexer.

### Btop

- [Btop](https://github.com/aristocratos/btop) - A resource monitor that displays stats for CPU, memory, disks, network, and processes.

### Dooit

- [Dooit](https://dooit-org.github.io/dooit/) - A task manager for the terminal.

### Copilot.vim

- [Copilot.vim](https://github.com/github/copilot.vim) - GitHub Copilot integration for Neovim.

### Hammerspoon

- [Hammerspoon](https://www.hammerspoon.org/) - Automation for macOS using Lua scripting.

### Hushlogin

- [Hushlogin](https://www.cyberciti.biz/howto/turn-off-the-login-banner-in-linux-unix-with-hushlogin-file/) - Suppress login banners in Unix/Linux.

### Lazygit

- [Lazygit](https://github.com/jesseduffield/lazygit) - A terminal-based Git client with a keyboard-driven interface.

### LF

- [LF](https://github.com/gokcehan/lf) - A terminal file manager.

## Rectangle

- [Rectangle](https://rectangleapp.com/) - A window manager for macOS.

### Taskell

- [Taskell](https://taskell.app/) - A command-line Kanban board/task manager.

### Tmux

- [Tmux](https://github.com/tmux/tmux) - A terminal multiplexer for managing multiple terminal sessions.

### AstroVim

- [AstroVim](https://astronvim.com/) - A customizable Neovim user interface.

### LazyVim

- [LazyVim](https://github.com/LazyVim/LazyVim) - A pre-configured Neovim setup optimized for developers.

### Atuin

- [Atuin](atuin.sh) - Sync, search and backup shell history with Atuin

---
