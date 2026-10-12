-- Kanagawa
local NewCursorColor = "#e26c88"
local CursorLineColor = "#202022"
local LineNumbers = "#5d5d69"
local DimmedForeground = "#8f8f9f"
local FloatBorder = "#d9d5bb"
local MsgLineFgColor = "#bdbdcf"
local Whitespaces = "#313131"
local Selection = "#393d47"

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
					["@keyword.operator"] = { link = "Keyword" },

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
					Title = { bold = false },
					Operator = { bold = false },

					-- Sign Column
					SignColumn = {
						bg = "NONE",
					},
					-- Fold Column
					FoldColumn = {
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
						fg = LineNumbers,
						bg = "NONE",
					},
					-- Current line number
					CursorLineNr = {
						bg = "NONE",
						bold = true,
					},
					-- Current line background
					CursorLine = {
						bg = "#262628",
					},
					-- Current line background
					Cursor = {
						bg = NewCursorColor,
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

					MsgSeparator = {
						bg = "NONE",
					},
					ErrorMsg = {
						bg = "NONE",
					},
					WarningMsg = {
						bg = "NONE",
					},
					ModeMsg = {
						bg = "NONE",
					},
					MoreMsg = {
						bg = "NONE",
					},
					-- floating windows
					FloatBorder = {
						fg = FloatBorder,
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
						fg = MsgLineFgColor,
						bg = "none",
						-- bold = false,
					},
					-- Tabline
					TabLine = {
						fg = DimmedForeground,
						bg = "NONE",
					},

					TabLineFill = {
						bg = "NONE",
					},

					TabLineSel = {
						fg = MsgLineFgColor,
						bg = "NONE",
						bold = false,
					},
					WinBarNC = {
						bg = "NONE",
						-- bold = false,
					},
					Visual = {
						bg = Selection,
						-- bold = false,
					},
					FzfLuaCustomBorder = {
						fg = FloatBorder,
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
