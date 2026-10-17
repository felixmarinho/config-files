return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		local hooks = require("ibl.hooks")

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- Muted rainbow scope highlights
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#554044" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#56503D" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#3D5550" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#59483F" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#414A3C" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#4D4659" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#3D5350" })

			-- Hide regular indentation guides
			vim.api.nvim_set_hl(0, "IblIndent", { fg = "#202023" })
			vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#313131" })

			-- Subtle active scope guide
			vim.api.nvim_set_hl(0, "IblScope", { fg = "#39393E" })
		end)

		require("ibl").setup({
			indent = {
				char = "▏",
			},
			scope = {
				char = "▏",
				highlight = highlight,
			},
		})

		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
