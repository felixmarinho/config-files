return {
	"DrKJeff16/project.nvim",

	dependencies = {
		"ibhagwan/fzf-lua",
	},
	config = function()
		require("project").setup({
			-- If `false` then `git` will not be used to retrieve the current project's root.
			-- If `git` is not found, this will be ignored if enabled!
			use_git = true,

			-- Options for integration with `xieyonn/spinner.nvim`.
			-- Needs https://github.com/xieyonn/spinner.nvim or this will be ignored!
			spinner = { enabled = false, kind = "cursor" },

			lsp = {
				-- Whether to enable LSP-based detection
				enabled = true,

				-- LSP clients to ignore
				ignore = {},

				-- If `true`, no pattern matching will be used as a backup.
				-- WARNING: ENABLE AT YOUR OWN DISCRETION!!!!
				no_fallback = false,

				-- Whether to double-check the LSP root with the pattern matching method.
				use_pattern_matching = false,
			},

			-- Read the `Custom Projects` section below
			custom_projects = {},

			-- If enabled, projects will ONLY change manually
			manual_mode = false,

			-- Files and directories to look for to detect a root directory.
			-- These patterns will not affect LSP-based detection unless `lsp.use_pattern_matching`
			-- is set to `true`
			--
			-- This list is permanent, and any new entries are appended. You can leave this empty
			patterns = {
				".git",
				".github",
				"_darcs",
				".hg",
				".bzr",
				".svn",
				"Pipfile",
				"pyproject.toml",
				".pre-commit-config.yaml",
				".pre-commit-config.yml",
				".csproj",
				".sln",
				".nvim.lua",
				".neoconf.json",
				"neoconf.json",
			},

			different_owners = {
				-- Allow adding projects with a different owner to the project session
				allow = false,

				-- Notify the user when a project with a different owner is found
				notify = true,
			},

			-- Set this to `true` if you prefer having `vim.o.autochdir` set to `true`
			enable_autochdir = false,

			-- Show projects by their name instead of their full path
			show_by_name = false,

			-- Show hidden files (global)
			show_hidden = true,

			-- Add any directory to exclude (absolute path). Keep in mind that this is recursive
			exclude_dirs = {},

			-- If disabled, you'll be notified each time the project root directory is changed
			silent_chdir = true,

			-- Whether the CWD is changed globally (`'global'`), per-tab (`'tab'`) or per-window (`'win'`)
			---@type 'global'|'tab'|'win'
			scope_chdir = "global",

			history = {
				-- The directory in which the history will be stored at.
				-- NOTE: A subdirectory will be created called `project_nvim`, where the history file resides
				save_dir = vim.fn.stdpath("data"),

				-- The file name for the JSON project history
				save_file = "project_history.json",

				-- The maximum number of history entries to write in your history file
				size = 100,
			},

			log = {
				-- Whether to enable logging
				enabled = false,

				-- The maximum file size allowed for the log file before it gets cleaned
				-- This size is in Mebibytes (MiB), A.K.A. 1MiB -> 1024KiB
				max_size = 1.1,

				-- The directory where the log file will be written to
				logpath = vim.fn.stdpath("state"),
			},

			fzf_lua = {
				-- Enables fzf-lua picker integration
				enabled = true,

				-- Sort directories by the newest or oldest
				---@type 'newest'|'oldest'
				sort = "newest",

				-- Show project entries either by their path (`'paths'`) or their custom name (`'names'`)
				---@type 'paths'|'names'
				show = "paths",
			},

			disable_on = {
				-- The filetypes that this plugin should ignore.
				-- This list is permanent, and any new entries are appended. You can leave this empty
				ft = {
					"",
					"NvimTree",
					"TelescopePrompt",
					"TelescopeResults",
					"alpha",
					"checkhealth",
					"lazy",
					"log",
					"ministarter",
					"neo-tree",
					"notify",
					"nvim-pack",
					"packer",
					"qf",
				},

				-- The buftypes that this plugin should ignore.
				-- This list is permanent, and any new entries are appended. You can leave this empty
				bt = { "help", "nofile", "nowrite", "terminal" },
			},
		})
	end,
}
