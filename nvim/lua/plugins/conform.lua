return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Conform will run multiple formatters sequentially
      -- You can customize some of the format options for the filetype (:help conform.format)
      lua = { "stylua" },
      html = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      python = { "isort", "black" },
      c = { "clang-format" },
      docker_compose = { "docker-compose-linter" },
      -- Regular YAML
      yaml = { "yamlfmt" },
      -- Docker Compose YAML
      ["yaml.docker-compose"] = { "yamlfmt" },

      dockerfile = { "dockerfmt" },
      jinja = { "djlint" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 600,
      lsp_format = "fallback",
    },
  },
}
