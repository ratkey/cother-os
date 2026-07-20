{ pkgs, ... }: {
  programs.nvf.settings.vim = {
    ui.colorizer.enable = true;

    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
      transparent = true;
    };

    statusline.lualine.enable = true;

    telescope = {
      enable = true;
      extensions = [
        {
          name = "fzf";
          packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
          setup.fzf.fuzzy = true;
        }
      ];
    };

    autocomplete.nvim-cmp.enable = true;

    mini = {
      icons.enable = true;
      tabline.enable = true;
      animate.enable = true;
      move.enable = true;
      surround.enable = true;
      indentscope = {
        enable = true;
        setupOpts = {
          symbol = "↓";
        };
      };
    };

    extraPlugins.typescript-tools = {
      package = pkgs.vimPlugins.typescript-tools-nvim;
      setup = "require('typescript-tools').setup({})";
    };

    utility = {
      smart-splits.enable = true;
      oil-nvim = {
        enable = true;
        gitStatus.enable = true;
        setupOpts = {
          default_file_explorer = true;
          float.border = "rounded";
          view_options.show_hidden = true;
        };
      };
    };
  };
}
