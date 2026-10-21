return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		local hooks = require("ibl.hooks")

		local function set_ibl_highlights()
			vim.api.nvim_set_hl(0, "IblScope", {
				fg = "#505568",
			})

			vim.api.nvim_set_hl(0, "IblIndent", {
				link = "Normal",
			})

			vim.api.nvim_set_hl(0, "IblWhitespace", {
				link = "Normal",
			})
		end

		hooks.register(hooks.type.HIGHLIGHT_SETUP, set_ibl_highlights)

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = set_ibl_highlights,
		})

		require("ibl").setup({
			indent = {
				char = " ",
				highlight = "IblIndent",
			},
			scope = {
				char = "▏",
				highlight = "IblScope",
			},
		})

		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
