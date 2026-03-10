# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal NixOS configuration using Nix Flakes and Home Manager. Manages system configuration for host `nixos` and user `cother`.

## Key Commands

**Apply configuration changes** (user executes this, not the agent):
```bash
sudo nixos-rebuild switch --flake .#nixos
```

**Update flake inputs:**
```bash
nix flake update
```

## Architecture

- `flake.nix` - Entry point defining inputs (nixpkgs 25.11, home-manager) and outputs
- `configuration.nix` - System-level: bootloader, networking, hardware, global services (Pipewire, Bluetooth)
- `home.nix` - User-level via Home Manager: packages, shell config, module imports
- `hardware-configuration.nix` - Auto-generated hardware config (do not edit manually)
- `modules/` - Modularized app configs (git.nix, neovim.nix, fish.nix, tmux.nix, etc.)
- `config/` - Raw config files symlinked to `~/.config/` (quickshell/, nvim/)

Home Manager is integrated as a NixOS module, so `nixos-rebuild switch` applies both system and user changes.

## Adding New Tools

1. Create a new `.nix` file in `modules/`
2. Import it in `home.nix`
3. For complex non-Nix configs, place files in `config/` and reference via:
   ```nix
   home.file.".config/<app>".source = ./config/<app>;
   ```

## Stack

- **Compositor:** Hyprland (Wayland) with QuickShell status bar
- **Terminal:** Kitty with Fish shell (VI keybindings)
- **Editor:** Neovim (LazyVim-based, configured in `config/nvim/`)
- **Multiplexers:** Tmux (primary), Zellij
- **Theme:** Gruvbox Dark throughout

## Conventions

- Use Gruvbox Dark color scheme for any new UI configurations
- VI keybindings are preferred across tools (Bash, Fish, Tmux all use VI mode)
- Font: JetBrainsMono Nerd Font
