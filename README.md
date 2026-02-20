# NixOS Dotfiles

This repository contains my personal **NixOS configuration** managed with **Nix Flakes** and **Home Manager**. It is designed to be modular, reproducible, and aesthetically pleasing using the **Gruvbox Dark** color scheme.

## 🚀 Quick Start

To apply the configuration to your system (assuming you are on the `nixos` host):

```bash
sudo nixos-rebuild switch --flake .#nixos
```

To update the flake inputs:

```bash
nix flake update
```

## 🛠️ Tech Stack

- **OS:** NixOS 25.11 (`x86_64-linux`)
- **Compositor:** [Hyprland](https://hyprland.org/) (Wayland)
- **Bar:** [Waybar](https://github.com/Alexays/Waybar)
- **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/) & [Fish Shell](https://fishshell.com/)
- **Editor:** [Neovim](https://neovim.io/) (LazyVim based)
- **Multiplexers:** [Tmux](https://github.com/tmux/tmux) & [Zellij](https://zellij.dev/)
- **Theme:** Gruvbox Dark

## 📂 Project Structure

- `flake.nix`: Entry point for the Nix Flake configuration.
- `configuration.nix`: System-level settings (bootloader, hardware, networking, global packages).
- `home.nix`: User-level settings via Home Manager (dotfiles, user packages).
- `modules/`: Modularized configurations for specific applications (Git, Neovim, Fish, etc.).
- `config/`: Raw configuration files symlinked to `~/.config/` (Hyprland, Waybar, Neovim).

## ✨ Key Features

- **Modular Configuration:** Easy to enable/disable specific tools by editing `home.nix`.
- **Custom Scripts:**
  - `wallpaper-selector`: A Rofi-based script to select and set wallpapers.
  - `rofi-power`: A simple power menu for Suspend, Reboot, and Shutdown.
- **Vim Mode:** Bash is configured with `vi` keybindings.
- **Hyprland Integration:** Fully configured Wayland environment with `hyprlock`, `hypridle`, and `waybar`.

## 📜 Development Conventions

- Add new tools as modules in `modules/` and import them in `home.nix`.
- Keep complex non-Nix configurations in the `config/` directory.
- Avoid committing secrets or sensitive information.
