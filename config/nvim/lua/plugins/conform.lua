return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      prettier = {
        -- Explicitly tells conform to execute via the system PATH variable
        condition = function()
          return vim.fn.executable("prettier") == 1
        end,
      },
    },
  },
}
