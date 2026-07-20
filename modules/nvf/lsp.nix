{ ... }: {
  programs.nvf.settings.vim.lsp = {
    enable = true;
    formatOnSave = true;
    inlayHints.enable = true;
    trouble = {
      enable = true;
      mappings.documentDiagnostics = "<leader>xx";
    };
    lightbulb.autocmd.enable = true;
    lspSignature.enable = true;
    mappings.goToDefinition = "gd";
  };
}
