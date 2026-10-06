
-- Colors
local KanagawaDragon =  "#15161d"
local KanagawaWave_bg = "#1f1f28"
local DragonBlack =	"#0d0c0c"
local DarkFg	= "#54546d"
local DarkCursorLine	= "#22222b"
local Whitespaces = "#2c2c2e"

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
						bg = KanagawaWave_bg,
					},
					-- Line number column
					LineNr = {
						fg = DarkFg,
						bg = KanagawaWave_bg,
					},
					-- Current line number
					CursorLineNr = {
						bg = DarkCursorLine,
						bold = true,
					},

					-- Current line background
					CursorLine = {
						bg = DarkCursorLine,
					},

					-- Non Text
					Whitespace = {
						fg = Whitespaces,
					},

					-- Color column
					ColorColumn = {
						bg = DarkCursorLine,
					},
					-- Winsepator Color
					WinSeparator = {
						fg = DarkFg,
					},
					-- Telescope
					TelescopeNormal = {
						bg = KanagawaDragon,
					},

					TelescopeBorder = {
						fg = DarkFg,
						bg = KanagawaDragon,
					},

					TelescopePromptNormal = {
						bg = KanagawaDragon,
					},

					TelescopePromptBorder = {
						fg = DarkFg,
						bg = KanagawaDragon,
					},

					TelescopeResultsNormal = {
						bg = KanagawaDragon,
					},

					TelescopeResultsBorder = {
						fg = DarkFg,
						bg = KanagawaDragon,
					},

					TelescopePreviewNormal = {
						bg = KanagawaDragon,
					},

					TelescopePreviewBorder = {
						fg = DarkFg,
						bg = KanagawaDragon,
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
