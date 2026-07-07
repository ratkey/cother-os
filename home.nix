{ config, pkgs, lib, inputs, ... }: {
  home.username = "cother";
  home.homeDirectory = "/home/cother";
  home.stateVersion = "25.11";

  imports = [
    ./modules/bash.nix
    ./modules/fish.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/tmux.nix
    # ./modules/zellij.nix
    ./modules/rofi.nix
    ./modules/dunst.nix
    ./modules/git.nix
    ./modules/brave.nix
    ./modules/btop.nix
    ./modules/nautilus.nix
    # ./modules/hyprlock.nix
    # ./modules/hypridle.nix
    ./modules/cursor.nix
    ./modules/gtk.nix
    ./modules/eza.nix
    ./modules/fastfetch.nix
    ./modules/obsidian.nix
    ./modules/hyprland.nix
    ./modules/quickshell.nix
  ];

home.packages = with pkgs; [
    # Core tools needed globally by LazyVim
    ripgrep
    fd
    lazygit
    fzf

    # Utilities to fix Snacks.nvim & Grug-far health checks
    ast-grep         
    trash-cli        
    mermaid-cli      
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    extraPackages = with pkgs; [
      # Core Build/Parser Essentials
      gcc
      unzip
      wget
      curl
      tree-sitter

      # Clipboard
      xclip
      wl-clipboard

      # LSPs, Linters and Diagnostics tools
      lua-language-server
      nixd
      gotools              
      gofumpt
      nodePackages.prettier

      # Formatters
      stylua
      black
      nixpkgs-fmt
    ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.file.".config/waypaper/config.ini".text = ''
    [Settings]
    folder = ~/walls
    backend = swww
    fill = fill
    sort = name
    color = #282828
    subfolders = false
  '';
}
