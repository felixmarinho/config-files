-- Colors Onedark Match
-- local BackgroundColor = "#272a31"
-- local BackgroundDarkerColor = "#1d2027"
-- local DragonBlack =	"#0d0c0c"
-- local DimmedForeground= "#54545f"
-- local CursorLineColor = "#26292f"
-- local MsgLineColor = "#202228"
-- local Whitespaces = "#38383f"
-- local Selection = "#393d47"

-- Kanagawa
local BackgroundColor = "#1f1f28"
-- local BackgroundDarkerColor = "#1d2027"
-- local DragonBlack =	"#0d0c0c"
local DimmedForeground= "#54546d"
local CursorLineColor = "#22222b"
local MsgLineColor = "#22222b"
local MsgLineFgColor = "#adadba"
local Whitespaces = "#2c2c2e"
-- local Selection = "#393d47"

return {
    "rebelot/kanagawa.nvim",
    config = function()
        require("kanagawa").setup({
            compile = true,
            background = {
                dark = "wave",
            },
            overrides=function(colors)
                return {
                    ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
                    ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
                    ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
                    ["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
                    ["@markup.list.markdown"] = { link = "Function" }, -- + list
                    ["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
                    ["@markup.list.checked.markdown"] = { link = "WarningMsg" }, -- - [X] checked list item

                    ["@property.json"] = { bold = false },
                    ["@string.json"] = { bold = false },
                    ["@number.json"] = { bold = false },
                    ["@boolean.json"] = { bold = false },
                    ["@constant.json"] = { bold = false },
                    ["@keyword.json"] = { bold = false },

                    ["@punctuation.bracket.json"] = { bold = false },


                    -- Statements
                    Statement = { bold = false },
                    Boolean = { bold = false },
                    Keyword = { bold = false },
                    Type = { bold = false },
                    Function = { bold = false },
                    Constant = { bold = false },
                    Identifier = { bold = false },
                    Special = { bold = false },
                    String = { bold = false },
                    Comment = { bold = false },
                    Number = { bold = false },

                    -- Sign Column 
                    SignColumn = {
                        bg = BackgroundColor,
                    },
                    -- Line number column
                    LineNr = {
                        -- fg = DimmedForeground,
                        bg = BackgroundColor,
                    },
                    -- Current line number
                    CursorLineNr = {
                        bg = CursorLineColor,
                        bold = true,
                    },

                    -- Current line background
                    CursorLine = {
                        bg = CursorLineColor,
                    },

                    -- Non Text
                    Whitespace = {
                        fg = Whitespaces,
                    },

                    -- Color column
                    ColorColumn = {
                        bg = CursorLineColor,
                    },
                    -- Winsepator Color
                    WinSeparator = {
                        fg = DimmedForeground,
                    },
                    -- -- Telescope
                    -- TelescopeNormal = {
                    --     bg = MsgLineColor,
                    -- },
                    --
                    -- TelescopeBorder = {
                    --     fg = DimmedForeground,
                    --     bg = MsgLineColor,
                    -- },
                    --
                    -- TelescopePromptNormal = {
                    --     bg = MsgLineColor,
                    -- },
                    --
                    -- TelescopePromptBorder = {
                    --     fg = DimmedForeground,
                    --     bg = MsgLineColor,
                    -- },
                    --
                    -- TelescopeResultsNormal = {
                    --     bg = MsgLineColor,
                    -- },
                    --
                    -- TelescopeResultsBorder = {
                    --     fg = DimmedForeground,
                    --     bg = MsgLineColor,
                    -- },
                    -- TelescopeResultsName = {
                    --     fg = DimmedForeground,
                    -- },
                    --
                    -- TelescopePreviewNormal = {
                    --     bg = MsgLineColor,
                    -- },
                    --
                    -- TelescopePreviewBorder = {
                    --     fg = DimmedForeground,
                    --     bg = MsgLineColor,
                    -- },
                    MsgArea = {
                        fg =MsgLineFgColor,
                        -- bg = MsgLineColor,
                    },
                    -- -- Selection
                    -- Visual = {
                    --     bg = Selection,
                    -- },
                    -- -- Floating windows
                    -- FloatBorder = {
                    --     fg = DimmedForeground,
                    --     bg = MsgLineColor,
                    -- },
                    --
                    -- NormalFloat = {
                    --     bg = MsgLineColor,
                    -- },
                    -- WinBar = {
                    --     fg = DimmedForeground,
                    --     bg = MsgLineColor,
                    --     bold = false,
                    -- },
                }
            end,
        })
        vim.cmd("colorscheme kanagawa")
    end,
    build = function()
        vim.cmd("KanagawaCompile")
    end,
}
