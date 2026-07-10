return {
  "stevearc/conform.nvim",
  opts = {
    -- Globally prefer system binaries over Mason downloads
    prefer_local = true,

    formatters_by_ft = {
      qml = { "qmlformat" },
    },
    formatters = {
      qmlformat = {
        stdin = false,
        args = { "--inplace", "--indent-width", "2", "$FILENAME" },
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
