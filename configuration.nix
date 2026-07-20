{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable Docker virtualisation daemon
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
  networking = {
    hostName = "CotherOS";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 53317 ];
    firewall.allowedUDPPorts = [ 53317 ];

    # Development configs
    hosts = {
      "127.0.0.1" = [
        "ciasa.haikanetwork.local"
        "fred.haikanetwork.local"
        "fred.haikanetwork.com"
        "yaqui.haikanetwork.local"
        "elmundodeltornillo.haikanetwork.local"
        "ciasa.localhost.com"
        "yaqui.localhost.com"
        "elmundodeltornillo.localhost.com"
        "auth.localhost.com"
        "nacionferreteralg.localhost.local"
        "nacionferreteralg.haikanetwork.local"
        "nacionferreteralg.localhost.com"
      ];
    };
  };

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

  # --- for quickshell to display battery
  services.upower.enable = true;

  users.users.cother = {
    isNormalUser = true;
    description = "cother";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [ ];
  };

  # --- System Packages & Settings ---
  nixpkgs.config.allowUnfree = true;

  # Leave only base command line utilities needed before logging in
  environment.systemPackages = with pkgs; [
    wget
  ];

  # --- Desktop Environment (Hyprland System-level Hook) ---
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # --- Fonts ---
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrains Mono Nerd Font" ];
      };
    };
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  # --- Hardware Support ---
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  hardware.opentabletdriver.enable = true;

  # --- Services ---
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.tailscale.enable = true;

  security.rtkit.enable = true; # Highly recommended for PipeWire realtime priority

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- Nix Configuration ---
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  system.stateVersion = "25.11";
}
