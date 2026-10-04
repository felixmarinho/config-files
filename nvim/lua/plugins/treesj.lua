return {
	"Wansmer/treesj",

	-- TreeSJ uses Tree-sitter to understand the structure of your code.
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},

	opts = {
		-- Disable TreeSJ's default keymaps because all keymaps
		-- are kept in keymaps.lua.
		use_default_keymaps = false,

		-- Do not format nodes that contain Tree-sitter syntax errors.
		check_syntax_error = true,

		-- Do not join a node if the resulting line would exceed this length.
		max_join_length = 120,

		-- Keep the cursor on the same logical location after formatting.
		cursor_behavior = "hold",

		-- Show a notification when TreeSJ encounters a problem.
		notify = true,

		-- Allow TreeSJ actions to be repeated with `.`.
		dot_repeat = true,
	},
}
