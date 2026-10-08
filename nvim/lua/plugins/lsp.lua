return {
  "neovim/nvim-lspconfig",

  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
  },

  config = function()
    -- Highlight references under the cursor
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-highlight", { clear = true }),

      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if not client then
          return
        end

        if client:supports_method("textDocument/documentHighlight") then
          vim.api.nvim_create_autocmd(
            { "CursorHold", "CursorHoldI" },
            {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            }
          )

          vim.api.nvim_create_autocmd(
            { "CursorMoved", "CursorMovedI" },
            {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            }
          )
        end
      end,
    })

    -- Diagnostics
    vim.diagnostic.config({
      severity_sort = true,

      float = {
        border = "rounded",
        source = "if_many",
      },

      underline = {
        severity = vim.diagnostic.severity.ERROR,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      },

      virtual_text = {
        source = "if_many",
        spacing = 2,
      },
    })

    -- LSP capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Language servers
    local servers = {
      bashls = {},
      marksman = {},
      ts_ls = {},

      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      },
    }

    -- Make Mason install the servers above
    local ensure_installed = vim.tbl_keys(servers)

    vim.list_extend(ensure_installed, {
      "stylua",
    })

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
    })

    require("mason-lspconfig").setup({
      ensure_installed = {},
      automatic_installation = false,
    })

    -- Configure and enable LSP servers
    for server, config in pairs(servers) do
      config.capabilities = vim.tbl_deep_extend(
        "force",
        {},
        capabilities,
        config.capabilities or {}
      )

      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end,
}
