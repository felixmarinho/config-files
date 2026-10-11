return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local kanagawa = require("lualine.themes.kanagawa")

    -- change the background of lualine_c section for normal mode
    kanagawa.normal.b.bg = "NONE"
    kanagawa.normal.c.bg = "NONE"

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = kanagawa,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              local modes = {
                NORMAL = "N",
                INSERT = "I",
                VISUAL = "V",
                ["V-LINE"] = "VL",
                ["V-BLOCK"] = "VB",
                REPLACE = "R",
                COMMAND = "C",
                TERMINAL = "T",
              }
              return modes[str] or str
            end,
            color = { gui = "bold" },
          },
        },
        -- lualine_b = { { "filename", color = { fg = "#e0c48c" } } },
        lualine_b = { "filename" },
        lualine_c = { "branch", "diff" },
        lualine_x = { "diagnostics", "lsp_status" },
        lualine_y = { { "%L", color = { gui = "bold" } } },
        lualine_z = { { "%l|%c", color = { gui = "bold" } } },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = { { "%L", color = { gui = "bold" } } },
        lualine_z = { { "%l|%c", color = { gui = "bold" } } },
      },
    })
    vim.cmd("highlight StatusLine guibg=NONE")
    vim.cmd("highlight StatusLineNC guibg=NONE")
  end,
}
