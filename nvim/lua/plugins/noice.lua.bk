return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function()

    -- ENABLE / DISABLE

    local kanagawa_noice = true
    local kanagawa_popup = true
    local kanagawa_popupmenu = true
    local kanagawa_notifications = true
    local kanagawa_notification_levels = true


    -- KANAGAWA: NOICE COMMAND LINE

    if kanagawa_noice then
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", {
        bg = "#1F1F28",
        fg = "#DCD7BA",
      })

      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", {
        bg = "#1F1F28",
        fg = "#7E9CD8",
      })
    end


    -- KANAGAWA: NOICE POPUPS

    if kanagawa_popup then
      vim.api.nvim_set_hl(0, "NoicePopup", {
        bg = "#2A2A37",
        fg = "#DCD7BA",
      })

      vim.api.nvim_set_hl(0, "NoicePopupBorder", {
        bg = "#2A2A37",
        fg = "#7E9CD8",
      })
    end


    -- KANAGAWA: NOICE POPUP MENU

    if kanagawa_popupmenu then
      vim.api.nvim_set_hl(0, "NoicePopupmenu", {
        bg = "#2A2A37",
        fg = "#DCD7BA",
      })

      vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", {
        bg = "#2A2A37",
        fg = "#7E9CD8",
      })
    end


    -- KANAGAWA: NOTIFICATIONS
    -- Disable this entire section if you want nvim-notify
    -- to use its default colors.

    if kanagawa_notifications then
      vim.api.nvim_set_hl(0, "NotifyBackground", {
        bg = "#1F1F28",
      })

      vim.api.nvim_set_hl(0, "NotifyBorder", {
        fg = "#7E9CD8",
        bg = "#1F1F28",
      })

      vim.api.nvim_set_hl(0, "NotifyTitle", {
        fg = "#DCD7BA",
        bg = "#1F1F28",
      })
    end


    -- KANAGAWA: NOTIFICATION LEVELS
    -- Semantic colors are intentionally preserved.

    if kanagawa_notification_levels then
      vim.api.nvim_set_hl(0, "NotifyERRORBorder", {
        fg = "#E46876",
        bg = "#1F1F28",
      })

      vim.api.nvim_set_hl(0, "NotifyWARNBorder", {
        fg = "#E6C384",
        bg = "#1F1F28",
      })

      vim.api.nvim_set_hl(0, "NotifyINFOBorder", {
        fg = "#98BB6C",
        bg = "#1F1F28",
      })

      vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", {
        fg = "#727169",
        bg = "#1F1F28",
      })
    end


    -- NOICE

    require("noice").setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    })
  end,
}
