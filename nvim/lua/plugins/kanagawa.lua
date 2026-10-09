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
-- local BackgroundColor = "#1f1f28"
local BackgroundColor = "NONE"
-- local BackgroundDarkerColor = "#1d2027"
-- local DragonBlack =	"#0d0c0c"
local DimmedForeground = "#54546d"
local CursorLineColor = "NONE"
-- local CursorLineColor = "#22222b"
local MsgLineColor = "NONE"
-- local MsgLineColor = "#22222b"
local MsgLineFgColor = "#7d7d9a"
local Whitespaces = "#2c2c2e"
-- local Selection = "#393d47"

return {
	"rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({
			compile = true,
			transparent = true,
			background = {
				dark = "wave",
			},
			overrides = function(colors)
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
						bg = "NONE",
					},
					-- Sign column on the current line
					CursorLineSign = {
						bg = "NONE",
					},
					-- LSP Diagnostic Signs
					DiagnosticSignError = {
						fg = colors.palette.samuraiRed,
						bg = "NONE",
					},
					DiagnosticSignWarn = {
						fg = colors.palette.roninYellow,
						bg = "NONE",
					},
					DiagnosticSignInfo = {
						fg = colors.palette.dragonBlue,
						bg = "NONE",
					},
					DiagnosticSignHint = {
						fg = colors.palette.waveAqua1,
						bg = "NONE",
					},
					DiagnosticSignOk = {
						fg = colors.palette.springGreen,
						bg = "NONE",
					},
					-- Line number column
					LineNr = {
						-- fg = DimmedForeground,
						bg = "NONE",
					},
					-- Current line number
					CursorLineNr = {
						bg = "NONE",
						bold = true,
					},
					-- Current line background
					CursorLine = {
						bg = "NONE",
					},
					-- Current line background
					Cursor = {
						bg = "#e26c88",
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
					MsgArea = {
						fg = MsgLineFgColor,
						bg = "NONE",
					},
					-- floating windows
					FloatBorder = {
						-- fg = dimmedforeground,
						bg = "none",
					},

					NormalFloat = {
						bg = "none",
					},
					FloatTitle = {
						fg = MsgLineFgColor,
						bg = "NONE",
						-- bold = false,
					},
					Winbar = {
						-- fg = dimmedforeground,
						bg = "none",
						-- bold = false,
					},
					WinBarNC = {
						bg = "NONE",
						-- bold = false,
					},
					FzfLuaCustomBorder = {
						fg = "#54546d",
						bg = "NONE",
					},
				}
			end,
		})
		vim.cmd("colorscheme kanagawa")
	end,
	build = function()
		vim.cmd("KanagawaCompile")
	end,
}
