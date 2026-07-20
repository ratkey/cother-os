{ pkgs, lib, ... }:
let
  logos = import ./logos.nix;
  luaLogos = lib.concatStringsSep ",\n  " (
    map (l: "vim.split([==[${l}]==], \"\\n\")") logos
  );
in
{
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
        setupOpts.symbol = "↓";
      };
    };

    session.persisted = {
      enable = true;
      setupOpts = {
        use_git_branch = true;
        autoload = false;
      };
    };

    extraPlugins = {
      dashboard = {
        package = pkgs.vimPlugins.dashboard-nvim;
        setup = ''
          math.randomseed(os.time())
          local logos = {
            ${luaLogos}
          }
          local logo = logos[math.random(#logos)]
          require('dashboard').setup({
            theme = 'doom',
            config = {
              header = logo,
              center = {
                { action = 'lua require("persisted").load()', desc = ' Restore Session', icon = '󰦛 ', key = 's' },
                { action = 'Telescope find_files',            desc = ' Find file',        icon = ' ', key = 'f' },
                { action = 'enew',                            desc = ' New file',         icon = ' ', key = 'n' },
                { action = 'Telescope oldfiles',              desc = ' Recent files',     icon = '󰋚 ', key = 'r' },
                { action = 'lua require("telescope.builtin").live_grep({ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] })', desc = ' Find text', icon = ' ', key = 'g' },
                { action = 'qa',                              desc = ' Quit',             icon = ' ', key = 'q' },
              },
            },
          })
        '';
      };

      typescript-tools = {
        package = pkgs.vimPlugins.typescript-tools-nvim;
        setup = "require('typescript-tools').setup({})";
      };
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
