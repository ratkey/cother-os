{ ... }: {
  programs.nvf.settings.vim.keymaps = [
    # oil
    {
      key = "-";
      mode = [ "n" ];
      action = "<cmd>Oil --float<CR>";
      silent = true;
      desc = "File explorer";
    }
    # buffer tabs (mini.tabline)
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
    # splits
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
    # telescope
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
      action = "<cmd>lua require('telescope.builtin').live_grep({ cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] })<CR>";
      silent = true;
      desc = "Live grep from git root";
    }
    # LSP
    {
      key = "<leader>ca";
      mode = [ "n" "v" ];
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      silent = true;
      desc = "Code actions";
    }
    {
      key = "<leader>ri";
      mode = [ "n" ];
      action = "<cmd>TSToolsRemoveUnusedImports<CR>";
      silent = true;
      desc = "Remove unused imports";
    }
    # keep selection after indent
    {
      key = ">";
      mode = "v";
      action = ">gv";
      noremap = true;
    }
    {
      key = "<";
      mode = "v";
      action = "<gv";
      noremap = true;
    }
  ];
}
