-- Kanagawa
local DarkGrayEyes = "#202023"
local DarkGrayEyesFloatBg = "#1a1a1e"
local NewCursorColor = "#e26c88"
local CursorLineColor = "#262628"
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
			-- transparent = true,
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

					-- Normal BG
					Normal = {
						bg = DarkGrayEyes,
					},
					-- Sign Column
					SignColumn = {
						bg = DarkGrayEyes,
					},
					-- Fold Column
					FoldColumn = {
						bg = DarkGrayEyes,
					},
					-- Sign column on the current line
					CursorLineSign = {
						bg = DarkGrayEyes,
					},
					-- LSP Diagnostic Signs
					DiagnosticSignError = {
						fg = colors.palette.samuraiRed,
						bg = DarkGrayEyes,
					},
					DiagnosticSignWarn = {
						fg = colors.palette.roninYellow,
						bg = DarkGrayEyes,
					},
					DiagnosticSignInfo = {
						fg = colors.palette.dragonBlue,
						bg = DarkGrayEyes,
					},
					DiagnosticSignHint = {
						fg = colors.palette.waveAqua1,
						bg = DarkGrayEyes,
					},
					DiagnosticSignOk = {
						fg = colors.palette.springGreen,
						bg = DarkGrayEyes,
					},
					-- Line number column
					LineNr = {
						fg = LineNumbers,
						bg = DarkGrayEyes,
					},
					-- Current line number
					CursorLineNr = {
						bg = DarkGrayEyes,
						bold = true,
					},
					-- Current line background
					CursorLine = {
						bg = CursorLineColor,
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
						bg = DarkGrayEyesFloatBg,
					},

					MsgSeparator = {
						bg = DarkGrayEyes,
					},
					ErrorMsg = {
						bg = DarkGrayEyes,
					},
					WarningMsg = {
						bg = DarkGrayEyes,
					},
					ModeMsg = {
						bg = DarkGrayEyes,
					},
					MoreMsg = {
						bg = DarkGrayEyes,
					},
					-- floating windows
					FloatBorder = {
						fg = FloatBorder,
						bg = DarkGrayEyesFloatBg,
					},

					NormalFloat = {
						bg = DarkGrayEyesFloatBg,
					},
					FloatTitle = {
						fg = MsgLineFgColor,
						bg = DarkGrayEyesFloatBg,
						-- bold = false,
					},
					Winbar = {
						fg = MsgLineFgColor,
						bg = DarkGrayEyes,
						-- bold = false,
					},
					-- Tabline
					TabLine = {
						fg = DimmedForeground,
						bg = DarkGrayEyes,
					},

					TabLineFill = {
						bg = DarkGrayEyes,
					},

					TabLineSel = {
						fg = MsgLineFgColor,
						bg = DarkGrayEyes,
						bold = false,
					},
					WinBarNC = {
						bg = DarkGrayEyes,
						-- bold = false,
					},
					Visual = {
						bg = Selection,
						-- bold = false,
					},
					VisualNOS = {
						bg = Selection,
						-- bold = false,
					},
					Search = {
						bg = "#383c98",
						-- bold = false,
					},
					IncSearch = {
						bg = "#f8fc88",
						-- bold = false,
					},
					CurSearch = {
						bg = "#c83c93",
						-- bold = false,
					},
					FzfLuaCustomBorder = {
						fg = FloatBorder,
						-- bg = DarkGrayEyes,
					},
					fzfluaBackdrop = {
						bg = "#000000",
					},
					-- Gitsigns: match sign backgrounds to the editor
					GitSignsAdd = {
						-- fg = colors.palette.autumnGreen,
						bg = DarkGrayEyes,
					},
					GitSignsChange = {
						-- fg = colors.palette.waveAqua1,
						bg = DarkGrayEyes,
					},
					GitSignsDelete = {
						-- fg = colors.palette.autumnRed,
						bg = DarkGrayEyes,
					},
					GitSignsChangedelete = {
						-- fg = colors.palette.waveAqua1,
						bg = DarkGrayEyes,
					},
					GitSignsTopdelete = {
						-- fg = colors.palette.autumnRed,
						bg = DarkGrayEyes,
					},
					GitSignsUntracked = {
						-- fg = colors.palette.autumnGreen,
						bg = DarkGrayEyes,
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
