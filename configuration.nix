{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable Docker virtualisation aemon
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
  };

  # --- Bootloader Configuration ---
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };

  # --- Networking ---
  networking.hostName = "CotherOS";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];

  # --- Localization & Timezone ---
  time.timeZone = "America/Mazatlan";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_MX.UTF-8";
    LC_IDENTIFICATION = "es_MX.UTF-8";
    LC_MEASUREMENT = "es_MX.UTF-8";
    LC_MONETARY = "es_MX.UTF-8";
    LC_NAME = "es_MX.UTF-8";
    LC_NUMERIC = "es_MX.UTF-8";
    LC_PAPER = "es_MX.UTF-8";
    LC_TELEPHONE = "es_MX.UTF-8";
    LC_TIME = "es_MX.UTF-8";
  };

  # --- Keymaps (Console & X11) ---
  console.keyMap = "la-latin1";
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };

  # --- User Configuration ---
  services.getty.autologinUser = "cother";
  
  users.users.cother = {
    isNormalUser = true;
    description = "cother";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ ];
  };

  # --- System Packages & Settings ---
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    tailscale

    # Global Programming Languages & Development Toolchains
    go
    rust-analyzer
    cargo
    rustc
    nodejs_24
    python3
    # nvim-treesitter requirement
    tree-sitter
  ];

  # --- Desktop Environment (Hyprland) ---
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # programs.hyprlock.enable = true;

  # --- Fonts ---
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # --- Hardware Support ---
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true; # Enables battery percentage reporting
      };
    };
  };

  # Graphics Tablet
  hardware.opentabletdriver.enable = true;

  # --- Services ---
  # File Management Services
  services.gvfs.enable = true;    # Mount, trash, and other functionality
  services.tumbler.enable = true; # Thumbnail support for images
  services.tailscale.enable = true;

  # Audio (Pipewire)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- Nix Configuration ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "25.11";
}
