{
  config,
  pkgs,
  inputs,
  ...
}:
{
  # Import the nvf home manager module using the flake inputs
  imports = [
    inputs.nvf.homeManagerModules.default
  ];
  programs.ripgrep.enable = true;
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        globals = {
          # Time neovim waits for you to finish keymap combo
          timeoutlen = 3000;
        };
        options = {
          number = true;
          relativenumber = false;
          autoindent = true;
          smartindent = true;
          hlsearch = true;
          backup = false;
          showcmd = true;
          cmdheight = 0;
          laststatus = 0;
          expandtab = true;
          scrolloff = 10;
          inccommand = "split";
          ignorecase = true;
          smarttab = true;
          breakindent = true;
          shiftwidth = 2;
          tabstop = 2;
          wrap = false;
          splitbelow = true;
          splitright = true;
          splitkeep = "cursor";
          mouse = "";
          termguicolors = true;
        };
        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
          registers = "unnamedplus";
        };
        keymaps = [
          {
            key = "-";
            mode = [ "n" ];
            action = "<cmd>Oil --float<CR>";
            silent = true;
            desc = "File explorer";
          }
          # mini.tabline ---------
          {
            key = "H";
            mode = [ "n" ];
            action = "<cmd>bprevious<CR>";
            silent = true;
            desc = "Previous buffer tab";
          }
          {
            key = "L";
            mode = [ "n" ];
            action = "<cmd>bnext<CR>";
            silent = true;
            desc = "Next buffer tab";
          }
          {
            key = "<leader>bd";
            mode = [ "n" ];
            action = "<cmd>bdelete<CR>";
            silent = true;
            desc = "Close current buffer tab";
          }
          {
            key = "<leader>bo";
            mode = [ "n" ];
            action = "<cmd>lua vim.cmd('%bd|e#|bd#')<CR>";
            silent = true;
            desc = "Close all buffers except the current";
          }
          # split window ---------
          {
            key = "<leader>j";
            mode = [ "n" ];
            action = "<cmd>split<CR>";
            silent = true;
            desc = "Split below";
          }
          {
            key = "<leader>l";
            mode = [ "n" ];
            action = "<cmd>vsplit<CR>";
            silent = true;
            desc = "Split right";
          }
          # telescope -------
          {
            key = "<leader><leader>";
            mode = [ "n" ];
            action = "<cmd>Telescope find_files<CR>";
            silent = true;
            desc = "Find files";
          }
          {
            key = "<leader>sg";
            mode = [ "n" ];
            action = "<cmd>Telescope live_grep<CR>";
            silent = true;
            desc = "Find files";
          }
        ];
        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lightbulb.autocmd.enable = true;
          lspSignature.enable = true;
          mappings = {
            goToDefinition = "gd";
          };
        };

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
              setup = {
                fzf = {
                  fuzzy = true;
                };
              };
            }
          ];
        };
        autocomplete.nvim-cmp.enable = true;

        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
          go.enable = true;
          ruby.enable = true;
          json.enable = true;
          env.enable = true;
          css.enable = true;
          lua.enable = true;
          yaml.enable = true;
          typescript.enable = true;
          markdown.enable = true;
        };

        mini = {
          icons.enable = true;
          tabline.enable = true;
        };

        utility = {
          smart-splits.enable = true;
          oil-nvim = {
            enable = true;
            gitStatus.enable = true;
            setupOpts = {
              default_file_explorer = true;
              float = {
                border = "rounded";
              };
              view_options = {
                show_hidden = true;
              };
            };
          };
        };
      };
    };
  };
}
