-- AUTOCMDS

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Format on save (ONLY real file buffers, ONLY when efm is attached)

vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = {
		"*.lua",
		"*.py",
		"*.go",
		"*.js",
		"*.jsx",
		"*.ts",
		"*.tsx",
		"*.json",
		"*.css",
		"*.scss",
		"*.html",
		"*.sh",
		"*.bash",
		"*.zsh",
		"*.c",
		"*.cpp",
		"*.h",
		"*.hpp",
	},
	callback = function(args)
		-- avoid formatting non-file buffers (helps prevent weird write prompts)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end
		if not vim.bo[args.buf].modifiable then
			return
		end
		if vim.api.nvim_buf_get_name(args.buf) == "" then
			return
		end

		local has_efm = false
		for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			if c.name == "efm" then
				has_efm = true
				break
			end
		end
		if not has_efm then
			return
		end

		pcall(vim.lsp.buf.format, {
			bufnr = args.buf,
			timeout_ms = 2000,
			filter = function(c)
				return c.name == "efm"
			end,
		})
	end,
})

-- highlight yanked text

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- return to last cursor position

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- wrap, linebreak and spellcheck on markdown and text files

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
})

-- Auto resize windows as terminal is resized
--
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})
-- Mdx reads as Markdown
--
vim.filetype.add({
	extension = {
		mdx = "markdown",
	},
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		-- -- Gitsigns Colors
		-- vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#73Daca", bold = true })
		-- vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#E0AF68", bold = true })
		-- vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#F7768E", bold = true })
		-- vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#FF4360", bold = true })
		-- vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#BB9AF7", bold = true })
		-- vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#7AA2F7", bold = true })
		--
		-- -- Diagnostics
		-- vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#F7768E" })
		-- vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#E0AF68" })
		-- vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#7AA2F7" })
		-- vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#73Daca" })
		-- vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = "#9ECE6A" })
		--
		-- vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#F7768E" })
		-- vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#E0AF68" })
		-- vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#7AA2F7" })
		-- vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#73Daca" })
		-- vim.api.nvim_set_hl(0, "DiagnosticSignOk", { fg = "#9ECE6A" })

		-- -- Line numbers
		-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#5a5D6f" })
		-- --
		-- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#d0d0d6", bold = true })

		-- Float Borders
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#b0bed5" })
		vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#b0bed5" })

		-- -- Comments
		-- vim.api.nvim_set_hl(0, "Comment", { fg = "#5F5F6F", italic = true })
		--
		-- -- Treesitter comments
		-- vim.api.nvim_set_hl(0, "@comment", { fg = "#5F5F6F", italic = true })

		-- -- Selection and search
		-- vim.api.nvim_set_hl(0, "Visual", { bg = "#2c2d34" })
		-- vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#2c2d34" })
		-- vim.api.nvim_set_hl(0, "Search", { bg = "#da0c5a", fg = "#ffffff" })
		-- vim.api.nvim_set_hl(0, "IncSearch", { bg = "#f8dc68", fg = "#111111" })
		-- vim.api.nvim_set_hl(0, "CurSearch", { bg = "#f8cc68", fg = "#111111" })
	end,
})

-- Apply immediately for the current colorscheme.
vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })
