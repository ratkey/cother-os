return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<cmd>Oil --float<CR>", desc = "File Explorer" },
  },
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 99,
      max_height = 100,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
  },
}
