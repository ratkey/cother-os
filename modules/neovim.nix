{ pkgs, ... }:
{
  # Link the declarative config from your repository
  xdg.configFile."nvim".source = ../config/nvim;

  home.packages = with pkgs; [
    # Core tools often needed by LazyVim/Mason external to nvim wrapper
    ripgrep
    fd
    lazygit
    fzf
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;


    extraWrapperArgs = [
      "--set" "LIBSQLITE" "${pkgs.sqlite.out}/lib/libsqlite3.so"
      "--set" "NVIM_SQLITE_PATH" "${pkgs.sqlite.out}/lib/libsqlite3.so"
    ];
    
    # Tools strictly for Neovim's internal wrapper
    extraPackages = with pkgs; [
      # Core Build/Parserr Essentials
      gcc
      unzip
      wget
      curl
      tree-sitter

      # Clipboard
      xclip
      wl-clipboard

      # Snacks.nvim dependencies
      ghostscript
      tectonic
      sqlite

      # LSPs and Tools
      lua-language-server
      nixd
      gotools
      gofumpt

      # Formatters
      nodePackages.prettier
      stylua
      black
      nixpkgs-fmt

    ];
  };
}
