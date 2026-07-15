{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.username = "cother";
  home.homeDirectory = "/home/cother";
  home.stateVersion = "25.11";

  imports = [
    ./modules/bash.nix
    ./modules/fish.nix
    ./modules/kitty.nix
    ./modules/nvf.nix
    ./modules/tmux.nix
    ./modules/rofi.nix
    ./modules/dunst.nix
    ./modules/git.nix
    ./modules/btop.nix
    ./modules/cursor.nix
    ./modules/gtk.nix
    ./modules/eza.nix
    ./modules/fastfetch.nix
    ./modules/obsidian.nix
    ./modules/hyprland.nix
    ./modules/quickshell.nix
  ];

  home.packages = with pkgs; [
    # Global Programming Languages & Development Toolchains
    go
    nodejs_24
    python3

    cava # audio bars

    tailscale
    unzip

    docker-compose
    wl-clipboard
    cliphist
    pamixer
    vscode
    brightnessctl
    swww # Background manager
    obs-studio
    vlc
    godot

    # Bluetooth
    blueman # The standard GTK Bluetooth manager (GUI)
    bluez-tools # Extra CLI tools
    bluetui # TUI bluetooth manager

    grim # The screenshot tool
    slurp # The region selector
    libnotify # Notification alerts
    yaak # GUI api client
    # gemini-cli
    gh # TUI Github-cli
    claude-code
    krita # Drawing

    # Browsers
    firefox

    azahar # Nintendo 3DS emulator
    localsend # GUI for sharing files across network
    yazi # TUI file manager
    xfce.thunar # GUI File manager (works natively in dark mode!)
    nwg-displays # GUI for configuring Monitors
    waypaper # GUI wallpaper selector for swww
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = [
      "hyprland"
      "gtk"
    ];
  };
}
