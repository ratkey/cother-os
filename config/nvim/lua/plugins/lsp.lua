return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- Tell LazyVim/lspconfig exactly how to manage qmlls
      qmlls = {
        cmd = { "qmlls" },
        filetypes = { "qml" },
        root_dir = function(fname)
          local util = require("lspconfig.util")
          -- Fallback safely to current working directory so it never fails to start
          return util.root_pattern(".git")(fname) or vim.uv.cwd()
        end,
        single_file_support = true,
      },
    },
  },
}
