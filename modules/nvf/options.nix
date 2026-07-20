{ ... }: {
  programs.nvf.settings.vim = {
    globals = {
      timeoutlen = 3000;
    };
    diagnostics.nvim-lint.enable = true;
    treesitter = {
      enable = true;
      indent.enable = false;
    };
    options = {
      autoindent = true;
      number = true;
      relativenumber = false;
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
    luaConfigPost = ''
      require('mini.surround').setup({
        mappings = {
          add = 'gsa',
          delete = 'gsd',
          find = 'gsf',
          find_left = 'gsF',
          highlight = 'gsh',
          replace = 'gsr',
          update_n_lines = 'gsn',
        },
      })
    '';
  };
}
