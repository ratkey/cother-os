return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      qmlls = {
        cmd = { "qmlls", "-E" },
        filetypes = { "qml" },
        root_dir = function(fname)
          local util = require("lspconfig.util")
          -- Try to find a root marker first, otherwise fallback to the directory of the current file
          return util.root_pattern("shell.qml", "qmldir", ".git")(fname) or util.path.dirname(fname)
        end,
      },
    },
  },
}
