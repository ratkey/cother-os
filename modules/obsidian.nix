{ ... }: {
  programs.obsidian = {
    enable = true;
    vaults = {
      "main" = { 
        enable = true;
        target = "Obsidian/main";
        settings = {
        };
      };
    };
  };
}
