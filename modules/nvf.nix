{ inputs, ... }: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./nvf/options.nix
    ./nvf/keymaps.nix
    ./nvf/lsp.nix
    ./nvf/languages.nix
    ./nvf/plugins.nix
  ];

  programs.ripgrep.enable = true;
  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = false;
      vimAlias = true;
    };
  };
}
