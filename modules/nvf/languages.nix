{ ... }: {
  programs.nvf.settings.vim.languages = {
    enableLSP = true;
    enableTreesitter = true;

    nix.enable = true;
    go.enable = true;
    ruby.enable = true;
    tsx = {
      enable = true;
      lsp.enable = false;
    };
    typescript = {
      enable = true;
      lsp.enable = false;
    };
    json.enable = true;
    yaml.enable = true;
    css.enable = true;
    lua.enable = true;
    markdown.enable = true;
    qml.enable = true;
    env.enable = true;
  };
}
