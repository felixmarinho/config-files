-- Leader

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- General

-- Exit insert mode

vim.keymap.set({ "i", "v", "c" }, "<C-c>", "<Esc>", { desc = "Exit modes" })

-- Exit terminal mode

vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Save

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Restart Neovim

vim.keymap.set("n", "<leader>r", "<cmd>restart<CR>", { desc = "Restart Neovim" })

-- Quit

vim.keymap.set("n", "<leader>1", "<cmd>q<CR>", { desc = "Quit" })

vim.keymap.set("n", "<leader>2", "<cmd>q!<CR>", { desc = "Quit without saving" })

-- Delete Buffer, Keep Split; Preserve Persistent Terminals

local function delete_buffer_keep_window(force)
	local current = vim.api.nvim_get_current_buf()
	local current_win = vim.api.nvim_get_current_win()
	local is_terminal = vim.bo[current].buftype == "terminal"

	if not is_terminal and not force and vim.bo[current].modified then
		vim.notify("Buffer has unsaved changes", vim.log.levels.WARN)
		return
	end

	local function is_file_buffer(buf)
		return vim.api.nvim_buf_is_valid(buf)
			and vim.bo[buf].buflisted
			and vim.bo[buf].buftype == ""
			and vim.api.nvim_buf_get_name(buf) ~= ""
			and vim.bo[buf].filetype ~= "dashboard"
	end

	local visible = {}
	local normal_windows = {}
	local current_visible_elsewhere = false

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)

		if config.relative == "" then
			table.insert(normal_windows, win)
		end

		if win ~= current_win then
			local buf = vim.api.nvim_win_get_buf(win)
			visible[buf] = true

			if buf == current then
				current_visible_elsewhere = true
			end
		end
	end

	-- Find an unused file buffer
	local next_buf

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and is_file_buffer(buf) and not visible[buf] then
			next_buf = buf
			break
		end
	end

	if next_buf then
		vim.api.nvim_win_set_buf(current_win, next_buf)

		-- Never delete a persistent terminal buffer
		if not is_terminal and not current_visible_elsewhere then
			vim.api.nvim_buf_delete(current, { force = force })
		end

		return
	end

	-- Close only this split if other normal windows remain
	if #normal_windows > 1 then
		vim.api.nvim_win_close(current_win, force)

		-- Preserve terminal sessions when hiding their split
		if not is_terminal and not current_visible_elsewhere and vim.api.nvim_buf_is_valid(current) then
			vim.api.nvim_buf_delete(current, { force = force })
		end

		return
	end

	-- Do not quit Neovim just to close a persistent terminal
	if is_terminal then
		vim.notify("No unused file buffer available; terminal session preserved", vim.log.levels.INFO)
		return
	end

	-- Count normal file buffers, ignoring persistent terminals
	local file_buffers = 0

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if is_file_buffer(buf) then
			file_buffers = file_buffers + 1
		end
	end

	if file_buffers <= 1 then
		vim.cmd(force and "qa!" or "qa")
	else
		vim.notify("No unused file buffer available", vim.log.levels.INFO)
	end
end

vim.keymap.set("n", "<leader>q", function()
	delete_buffer_keep_window(false)
end, {
	desc = "Delete buffer, keep split",
})

vim.keymap.set("n", "<leader>bq", function()
	delete_buffer_keep_window(true)
end, {
	desc = "Force delete buffer, keep split",
})

-- Delete Split

vim.keymap.set("n", "<leader>sq", "<cmd>close<cr>", { desc = "Close split" })

-- Clear search highlighting

vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<CR>", {
	desc = "Clear search highlights",
})

-- TreeSJ
-- Split/join the code block under the cursor.
-- <leader> = Space, so this is Space + Shift-M.

vim.keymap.set("n", "<leader>j", function()
	local before = vim.api.nvim_buf_line_count(0)

	require("treesj").toggle()

	local after = vim.api.nvim_buf_line_count(0)

	if after > before then
		vim.notify("Code block: SPLIT")
	elseif after < before then
		vim.notify("Code block: JOINED")
	else
		vim.notify("Code block: UNCHANGED")
	end
end, {
	desc = "TreeSJ: Toggle split/join",
})

-- Toggle Word Wrap

vim.keymap.set("n", "<leader>k", function()
	vim.opt.wrap = not vim.opt.wrap:get()
	vim.notify("Wrap: " .. (vim.opt.wrap:get() and "ON" or "OFF"))
end, { desc = "Toggle word wrap" })

-- Toggle Whitespace

vim.keymap.set("n", "<leader>l", function()
	vim.opt.list = not vim.opt.list:get()

	if vim.opt.list:get() then
		vim.notify("Toggle Whitespace ON")
	else
		vim.notify("Toggle Whitespace OFF")
	end
end, {
	desc = "Toggle whitespace",
})
-- Toggle Diagnostics and Diagnostics Handling

vim.keymap.set("n", "<leader>;", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
	vim.notify("Diagnostics: " .. (vim.diagnostic.is_enabled() and "ON" or "OFF"))
end, { desc = "Toggle diagnostics" })

vim.keymap.set("n", "df", function()
	vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
	desc = "Previous Diagnostic",
})

-- Conceal Level

vim.keymap.set("n", "<leader>co", function()
	local level = vim.opt.conceallevel:get()
	local next = (level + 1) % 4

	vim.opt.conceallevel = next
	vim.notify("Conceal " .. next)
end, { desc = "Cycle conceal level" })

-- Navigation

-- Wrap-aware movement

vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, {
	expr = true,
	silent = true,
	desc = "Down (wrap-aware)",
})

vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, {
	expr = true,
	silent = true,
	desc = "Up (wrap-aware)",
})

-- Keep search results centered

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })

vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Keep half-page jumps centered

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })

vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })

-- Editing

-- Paste without replacing yank register

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Delete without yanking

vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

-- Find and Replace

vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Move lines

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })

vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Indent and keep selection

vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })

vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

vim.keymap.set("n", "<leader>ap", "ma=ap`a", { desc = "Reindent paragraph and restore cursor" })

-- Join lines without moving cursor

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })

-- Navigate windows / tmux panes

vim.keymap.set({ "n", "t" }, "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Move left" })

vim.keymap.set({ "n", "t" }, "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Move down" })

vim.keymap.set({ "n", "t" }, "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Move up" })

vim.keymap.set({ "n", "t" }, "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Move right" })

-- Split windows

vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertically" })

vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split horizontally" })

-- Switch split positions for 2 splits

vim.keymap.set("n", "<leader>si", function()
	local layout = vim.fn.winlayout()

	-- Vertical split → horizontal split
	if layout[1] == "row" then
		vim.cmd("wincmd J")

	-- Horizontal split → vertical split
	elseif layout[1] == "col" then
		vim.cmd("wincmd L")
	end
end, { desc = "Toggle split orientation" })

-- Switch split positions for 3 splits or more

vim.keymap.set("n", "<leader>so", function()
	local current = vim.api.nvim_get_current_win()

	if vim.api.nvim_win_get_config(current).relative ~= "" then
		return
	end

	local current_pos = vim.api.nvim_win_get_position(current)
	local current_row, current_col = current_pos[1], current_pos[2]
	local current_height = vim.api.nvim_win_get_height(current)
	local current_width = vim.api.nvim_win_get_width(current)

	local function overlap(a1, a2, b1, b2)
		return math.min(a2, b2) > math.max(a1, b1)
	end

	local best_win
	local best_distance = math.huge
	local orientation
	local current_after

	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if
			win ~= current
			and vim.api.nvim_win_is_valid(win)
			and vim.api.nvim_win_get_config(win).relative == ""
			and vim.api.nvim_win_get_number(win) > 0
		then
			local pos = vim.api.nvim_win_get_position(win)
			local row, col = pos[1], pos[2]
			local height = vim.api.nvim_win_get_height(win)
			local width = vim.api.nvim_win_get_width(win)

			-- Side-by-side windows: change to a horizontal split.
			if overlap(current_row, current_row + current_height, row, row + height) then
				local distance

				if col >= current_col + current_width then
					distance = col - (current_col + current_width)
				elseif current_col >= col + width then
					distance = current_col - (col + width)
				end

				if distance and distance < best_distance then
					best_win = win
					best_distance = distance
					orientation = "vertical"
					current_after = current_col > col
				end
			end

			-- Above/below windows: change to a vertical split.
			if overlap(current_col, current_col + current_width, col, col + width) then
				local distance

				if row >= current_row + current_height then
					distance = row - (current_row + current_height)
				elseif current_row >= row + height then
					distance = current_row - (row + height)
				end

				if distance and distance < best_distance then
					best_win = win
					best_distance = distance
					orientation = "horizontal"
					current_after = current_row > row
				end
			end
		end
	end

	if not best_win or not vim.api.nvim_win_is_valid(best_win) then
		return
	end

	-- Resolve valid window numbers in the current tab.
	local current_nr = vim.api.nvim_win_get_number(current)
	local target_nr = vim.api.nvim_win_get_number(best_win)

	if current_nr == 0 or target_nr == 0 then
		return
	end

	local ok, result = pcall(vim.fn.win_splitmove, current_nr, target_nr, {
		vertical = orientation == "horizontal",
		rightbelow = current_after,
	})

	if not ok or result ~= 0 then
		vim.notify("Split orientation failed: " .. tostring(result), vim.log.levels.WARN)
		return
	end

	if vim.api.nvim_win_is_valid(current) then
		vim.api.nvim_set_current_win(current)
	end
end, { desc = "Toggle split orientation" })

-- Resize windows

vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })

vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })

vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })

-- Buffers

vim.keymap.set("n", "<leader>[b", "<cmd>bnext<CR>", { desc = "Next buffer" })

vim.keymap.set("n", "<leader>]b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- File / Oil

vim.keymap.set("n", "-", function()
	require("oil").open_float()
end, {
	desc = "Open parent directory in Oil (float)",
})

-- File path

vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, {
	desc = "Copy full file path",
})

-- Tree-sitter incremental selection

vim.keymap.set("n", "=", function()
	vim.treesitter.select("parent")
end, {
	desc = "Treesitter: start selection",
})

vim.keymap.set("x", "=", function()
	vim.treesitter.select("parent")
end, {
	desc = "Treesitter: expand selection",
})

vim.keymap.set("x", "<Backspace>", function()
	vim.treesitter.select("child")
end, {
	desc = "Treesitter: shrink selection",
})

-- Tree-sitter textobjects

local select = require("nvim-treesitter-textobjects.select")

vim.keymap.set({ "x", "o" }, "af", function()
	select.select_textobject("@function.outer", "textobjects")
end, {
	desc = "Treesitter: around function",
})

vim.keymap.set({ "x", "o" }, "if", function()
	select.select_textobject("@function.inner", "textobjects")
end, {
	desc = "Treesitter: inside function",
})

vim.keymap.set({ "x", "o" }, "ac", function()
	select.select_textobject("@class.outer", "textobjects")
end, {
	desc = "Treesitter: around class",
})

vim.keymap.set({ "x", "o" }, "ic", function()
	select.select_textobject("@class.inner", "textobjects")
end, {
	desc = "Treesitter: inside class",
})

vim.keymap.set("n", "<leader>a", function()
	require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end, {
	desc = "Swap with next parameter",
})

vim.keymap.set("n", "<leader>A", function()
	require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
end, {
	desc = "Swap with previous parameter",
})

-- Quick Fix

vim.keymap.set("n", "qo", "<cmd>copen<CR>", { desc = "Open quickfix" })

-- vim.keymap.set("n", "<leader>qq", "<cmd>cclose<CR>", { desc = "Close quickfix" })

vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })

vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

vim.keymap.set("n", "ql", function()
	vim.diagnostic.setqflist()
end, {
	desc = "Diagnostics to Quickfix",
})

vim.keymap.set("n", "qc", function()
	vim.fn.setqflist({})
end, {
	desc = "Clear Quickfix List",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "dd", function()
			local idx = vim.api.nvim_win_get_cursor(0)[1]
			local items = vim.fn.getqflist()

			if idx > #items then
				return
			end

			table.remove(items, idx)
			vim.fn.setqflist(items, "r")

			if #items > 0 then
				vim.api.nvim_win_set_cursor(0, {
					math.min(idx, #items),
					0,
				})
			end
		end, { buffer = true, desc = "Remove quickfix item" })
	end,
})

-- Location Lists

vim.keymap.set("n", "<M-n>", "<cmd>lnext<CR>zz", { desc = "Next LocationList item" })

vim.keymap.set("n", "<M-p>", "<cmd>lprev<CR>zz", { desc = "Previous LocationList  item" })

-- Lsp

local builtin = require("fzf-lua")

vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "LSP: Goto Definition" })

vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "LSP: Goto References" })

vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "LSP: Goto Implementation" })

vim.keymap.set("n", "gt", builtin.lsp_typedefs, { desc = "LSP: Type Definition" })

vim.keymap.set("n", "gs", builtin.lsp_document_symbols, { desc = "LSP: Document Symbols" })

vim.keymap.set("n", "gw", builtin.lsp_live_workspace_symbols, { desc = "LSP: Workspace Symbols" })

vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP: Rename" })

vim.keymap.set({ "n", "x" }, "ga", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })

vim.keymap.set("n", "<leader>gd", vim.lsp.buf.declaration, { desc = "LSP: Goto Declaration" })

-- Lsp restart

vim.keymap.set("n", "<leader>zig", "<cmd>lsp restart<CR>", { desc = "Restart LSP" })

-- fzf-lua
-- fzf-lua grep open files
local fzf = require("fzf-lua")

local function live_grep_open_files()
	local paths = {}

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			local name = vim.api.nvim_buf_get_name(bufnr)

			if name ~= "" and vim.fn.filereadable(name) == 1 then
				table.insert(paths, name)
			end
		end
	end

	if #paths == 0 then
		vim.notify("No open files to grep", vim.log.levels.INFO)
		return
	end

	fzf.live_grep({
		search_paths = paths,
	})
end

vim.keymap.set("n", "<leader>fbb", live_grep_open_files, {
	desc = "Live grep open files",
})

-- Flash Nvim
-- local Flash = require("flash")

local function flash_2char_jump()
	---@param opts Flash.Format
	local function format(opts)
		return {
			{ opts.match.label1, "FlashMatch" },
			{ opts.match.label2, "FlashLabel" },
		}
	end

	Flash.jump({
		search = { mode = "search" },
		label = {
			after = false,
			before = { 0, 0 },
			uppercase = false,
			format = format,
		},
		pattern = [[\<]],
		action = function(match, state)
			state:hide()

			Flash.jump({
				search = { max_length = 0 },
				highlight = { matches = false },
				label = { format = format },
				matcher = function(win)
					return vim.tbl_filter(function(m)
						return m.label == match.label and m.win == win
					end, state.results)
				end,
				labeler = function(matches)
					for _, m in ipairs(matches) do
						m.label = m.label2
					end
				end,
			})
		end,
		labeler = function(matches, state)
			local labels = state:labels()

			for m, match in ipairs(matches) do
				match.label1 = labels[math.floor((m - 1) / #labels) + 1]
				match.label2 = labels[(m - 1) % #labels + 1]
				match.label = match.label1
			end
		end,
	})
end

vim.keymap.set("n", "z", flash_2char_jump, { desc = "Flash 2-char jump" })

-- Terminals
-- Toggle bottom terminal in the current file's directory
local terminal_win = nil
local terminal_buf = nil

local function toggle_terminal()
	local api = vim.api

	-- Close the terminal if it is already open
	if
		terminal_win
		and api.nvim_win_is_valid(terminal_win)
		and terminal_buf
		and api.nvim_buf_is_valid(terminal_buf)
		and api.nvim_win_get_buf(terminal_win) == terminal_buf
	then
		if #api.nvim_list_wins() > 1 then
			api.nvim_win_close(terminal_win, true)
		else
			-- Keep Neovim's last window alive
			api.nvim_win_set_buf(terminal_win, api.nvim_create_buf(true, false))
		end

		terminal_win = nil
		terminal_buf = nil
		return
	end

	terminal_win = nil
	terminal_buf = nil

	-- Determine the directory of the current file
	local buf = api.nvim_get_current_buf()
	local name = api.nvim_buf_get_name(buf)
	local dir = vim.fn.getcwd()

	if vim.bo[buf].buftype == "" and name ~= "" and not name:match("^%w[%w+.-]*://") then
		dir = vim.fn.fnamemodify(name, ":p:h")
	end

	-- Open a fresh 10-line bottom split
	vim.cmd("botright 10new")

	terminal_win = api.nvim_get_current_win()
	terminal_buf = api.nvim_get_current_buf()

	-- Discard the buffer when its window is closed
	vim.bo[terminal_buf].bufhidden = "wipe"

	-- Disable line numbers
	vim.wo[terminal_win].number = false
	vim.wo[terminal_win].relativenumber = false
	vim.wo[terminal_win].signcolumn = "no"

	-- Start a new shell in the file's parent directory
	local job = vim.fn.termopen({ vim.o.shell }, { cwd = dir })

	if job <= 0 then
		vim.notify("Failed to start terminal", vim.log.levels.ERROR)
		api.nvim_win_close(terminal_win, true)
		terminal_win = nil
		terminal_buf = nil
		return
	end

	vim.cmd("startinsert")
end

vim.keymap.set({ "n", "t" }, "<leader>th", toggle_terminal, {
	desc = "Toggle bottom terminal",
})

--Vertical terminal
-- Toggle right-side terminal in the current file's directory
local terminal_win = nil
local terminal_buf = nil

local function toggle_terminal()
	local api = vim.api

	-- Close the terminal if it is already open
	if
		terminal_win
		and api.nvim_win_is_valid(terminal_win)
		and terminal_buf
		and api.nvim_buf_is_valid(terminal_buf)
		and api.nvim_win_get_buf(terminal_win) == terminal_buf
	then
		if #api.nvim_list_wins() > 1 then
			api.nvim_win_close(terminal_win, true)
		else
			-- Keep Neovim's last window alive
			api.nvim_win_set_buf(terminal_win, api.nvim_create_buf(true, false))
		end

		terminal_win = nil
		terminal_buf = nil
		return
	end

	terminal_win = nil
	terminal_buf = nil

	-- Determine the directory of the current file
	local buf = api.nvim_get_current_buf()
	local name = api.nvim_buf_get_name(buf)
	local dir = vim.fn.getcwd()

	if vim.bo[buf].buftype == "" and name ~= "" and not name:match("^%w[%w+.-]*://") then
		dir = vim.fn.fnamemodify(name, ":p:h")
	end

	-- Open a 40-column vertical split on the right
	vim.cmd("botright 60vnew")

	terminal_win = api.nvim_get_current_win()
	terminal_buf = api.nvim_get_current_buf()

	-- Discard the buffer when its window is closed
	vim.bo[terminal_buf].bufhidden = "wipe"

	-- Disable line numbers
	vim.wo[terminal_win].number = false
	vim.wo[terminal_win].relativenumber = false
	vim.wo[terminal_win].signcolumn = "no"

	-- Start a new shell in the file's parent directory
	local job = vim.fn.termopen({ vim.o.shell }, { cwd = dir })

	if job <= 0 then
		vim.notify("Failed to start terminal", vim.log.levels.ERROR)
		api.nvim_win_close(terminal_win, true)
		terminal_win = nil
		terminal_buf = nil
		return
	end

	vim.cmd("startinsert")
end

vim.keymap.set({ "n", "t" }, "<leader>tv", toggle_terminal, {
	desc = "Toggle right-side terminal",
})
