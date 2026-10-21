return {
	"marko-cerovac/material.nvim",

	lazy = false,
	priority = 1000,

	config = function()
		-- THEME STYLE
		vim.g.material_style = "oceanic"

		require("material").setup({

			-- CONTRAST
			contrast = {
				terminal = false,
				sidebars = false,
				floating_windows = false,
				cursor_line = false,
				lsp_virtual_text = false,
				non_current_windows = false,
				filetypes = {},
			},

			-- SYNTAX STYLES
			styles = {
				comments = {},
				strings = {},
				keywords = {},
				functions = {},
				variables = {},
				operators = {},
				types = {},
			},

			-- PLUGIN INTEGRATIONS
			plugins = {
				-- Add integrations for plugins you use.
				-- Examples:
				"blink",
				-- "fidget",
				-- "gitsigns",
				-- "indent-blankline",
				-- "noice",
				-- "which-key",
			},

			-- DISABLE THEME FEATURES
			disable = {
				colored_cursor = false,
				borders = false,
				background = true,
				term_colors = false,
				eob_lines = false,
			},

			-- HIGH VISIBILITY
			high_visibility = {
				lighter = false,
				darker = false,
			},

			-- PERFORMANCE
			async_loading = false,

			-- CUSTOM COLORS
			custom_colors = nil,

			-- CUSTOM HIGHLIGHTS
			custom_highlights = {},
		})

		-- APPLY COLORSCHEME
		vim.cmd.colorscheme("material")
	end,
}
