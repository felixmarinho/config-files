return {
	"rmehri01/onenord.nvim",

	lazy = false,
	priority = 1000,

	config = function()
		require("onenord").setup({
			theme = "dark",
			borders = true,
			fade_nc = false,

			styles = {
				comments = "NONE",
				strings = "NONE",
				keywords = "NONE",
				functions = "NONE",
				variables = "NONE",
				diagnostics = "underline",
			},

			disable = {
				background = true,
				float_background = false,
				cursorline = false,
				eob_lines = true,
			},

			inverse = {
				match_paren = false,
			},

			-- Match the actual VS Code OneNord palette.
			custom_colors = {
				fg = "#C0D0E0",
				fg_light = "#C0D0E0",
				bg = "#2E3440",

				gray = "#7E8491",
				light_gray = "#6C7A96",

				cyan = "#88C0D0",
				blue = "#81A1C1",
				dark_blue = "#5E81AC",

				green = "#91C187",
				light_green = "#8FBCBB",

				dark_red = "#B84F59",
				red = "#D57780",
				light_red = "#DE878F",

				pink = "#E85B7A",
				dark_pink = "#E44675",

				orange = "#D08F70",
				yellow = "#EBCB8B",

				purple = "#B589D3",
				light_purple = "#B48EAD",

				-- Explicit derived palette colors.
				error = "#B84F59",
				warn = "#D08F70",
				info = "#91C187",
				hint = "#B589D3",

				-- Keep these aligned with the VS Code palette.
				active = "#353B49",
				float = "#3B4252",
				highlight = "#3F4758",
				highlight_dark = "#434C5E",
				selection = "#4C566A",
			},

			custom_highlights = {
				-- Editor foreground and background.
				Normal = {
					fg = "#C0D0E0",
					bg = "#2E3440",
				},

				-- Default VS Code token foreground.
				Identifier = { fg = "#C0D0E0" },
				Constant = { fg = "#C0D0E0" },

				-- Legacy syntax groups.
				Comment = { fg = "#6C7A96" },
				Type = { fg = "#B589D3" },
				Function = { fg = "#81A1C1" },
				Statement = { fg = "#B589D3" },
				Keyword = { fg = "#B589D3" },
				String = { fg = "#91C187" },
				Character = { fg = "#D08F70" },
				Number = { fg = "#D08F70" },
				Boolean = { fg = "#B589D3" },
				Operator = { fg = "#B589D3" },
				Delimiter = { fg = "#5E81AC" },
				StorageClass = { fg = "#B589D3" },
				Label = { fg = "#8FAfBB" },

				-- Tree-sitter: variables and properties.
				["@variable"] = { fg = "#C0D0E0" },
				["@variable.parameter"] = { fg = "#D08F70" },
				["@parameter.reference"] = { fg = "#D08F70" },
				["@variable.member"] = { fg = "#81A1C1" },
				["@variable.builtin"] = { fg = "#B589D3" },
				["@property"] = { fg = "#C0D0E0" },
				["@punctuation.delimiter"] = { fg = "#C0D0E0" },
				["@punctuation.bracket"] = { fg = "#8FBCBB" },
				["@constructor.lua"] = { fg = "#5E81AC" },

				-- Tree-sitter: types and namespaces.
				["@type"] = { fg = "#8FBCBB" },
				["@type.builtin"] = { fg = "#8FBCBB" },
				["@type.definition"] = { fg = "#EBCB8B" },
				["@constructor"] = { fg = "#EBCB8B" },
				["@module"] = { fg = "#C0D0E0" },
				["@namespace"] = { fg = "#8FBCBB" },

				-- Tree-sitter: functions and decorators.
				["@function"] = { fg = "#81A1C1" },
				["@function.method"] = { fg = "#81A1C1" },
				["@function.builtin"] = { fg = "#88C0D0" },
				["@attribute"] = { fg = "#81A1C1" },

				-- Tree-sitter: constants, strings, and operators.
				["@constant"] = { fg = "#C0D0E0" },
				["@constant.builtin"] = { fg = "#B589D3" },
				["@constant.macro"] = { fg = "#D57780" },
				["@boolean"] = { fg = "#B589D3" },
				["@character"] = { fg = "#D08F70" },
				["@number"] = { fg = "#D08F70" },
				["@number.float"] = { fg = "#D08F70" },
				["@string"] = { fg = "#91C187" },
				["@string.escape"] = { fg = "#88C0D0" },
				["@string.regexp"] = { fg = "#88C0D0" },
				["@keyword"] = { fg = "#B589D3" },
				["@keyword.operator"] = { fg = "#B589D3" },
				["@operator"] = { fg = "#B589D3" },

				-- Tree-sitter: markup and tags.
				["@tag"] = { fg = "#B589D3" },
				["@tag.attribute"] = { fg = "#D08F70" },
				["@tag.delimiter"] = { fg = "#5E81AC" },
				["@markup"] = { fg = "#C0D0E0" },
				["@markup.strong"] = {
					fg = "#C0D0E0",
					style = "bold",
				},
				["@markup.italic"] = {
					fg = "#C0D0E0",
					style = "italic",
				},
				["@markup.raw"] = { fg = "#91C187" },
				["@markup.link.url"] = {
					fg = "#7E8491",
					style = "underline",
				},

				-- LSP semantic tokens: match VS Code's semanticTokenColors.
				["@lsp.type.namespace"] = { fg = "#8FBCBB" },
				["@lsp.type.type"] = { fg = "#8FBCBB" },
				["@lsp.type.class"] = { fg = "#EBCB8B" },
				["@lsp.type.interface"] = { fg = "#8FBCBB" },
				["@lsp.type.enum"] = { fg = "#EBCB8B" },
				["@lsp.type.struct"] = { fg = "#EBCB8B" },
				["@lsp.type.typeParameter"] = { fg = "#EBCB8B" },

				["@lsp.type.parameter"] = { fg = "#D08F70" },
				["@lsp.type.variable"] = { fg = "#C0D0E0" },
				["@lsp.type.property"] = { fg = "#81A1C1" },
				["@lsp.type.enumMember"] = { fg = "#D57780" },

				["@lsp.type.function"] = { fg = "#81A1C1" },
				["@lsp.type.method"] = { fg = "#81A1C1" },
				["@lsp.type.decorator"] = { fg = "#81A1C1" },
				["@lsp.type.macro"] = { fg = "#D57780" },
				["@lsp.type.keyword"] = { fg = "#B589D3" },
				["@lsp.type.comment"] = { fg = "#6C7A96" },
				["@lsp.type.string"] = { fg = "#91C187" },
				["@lsp.type.number"] = { fg = "#D08F70" },
				["@lsp.type.regexp"] = { fg = "#88C0D0" },
				["@lsp.type.operator"] = { fg = "#B589D3" },

				["@lsp.typemod.function.defaultLibrary"] = {
					fg = "#88C0D0",
				},
				["@lsp.typemod.method.defaultLibrary"] = {
					fg = "#88C0D0",
				},
				["@lsp.typemod.variable.defaultLibrary"] = {
					fg = "#8FBCBB",
				},
				["@lsp.typemod.property.defaultLibrary"] = {
					fg = "#8FBCBB",
				},
			},
		})
	end,
}
