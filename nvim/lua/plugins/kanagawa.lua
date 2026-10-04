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
						bg = "#1f1f28",
					},
					-- Line number column
					LineNr = {
						fg = "#54546d",
						bg = "#1f1f28",
					},

					-- Current line number
					CursorLineNr = {
						--fg = "#e6c384",
						bg = "#2a2a37",
						bold = true,
					},

					-- Current line background
					CursorLine = {
						bg = "#252531",
					},

					-- Non Text
					Whitespace = {
						fg = "#2c2c2e",
					},

					-- Color column
					ColorColumn = {
						bg = "#22222b",
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
