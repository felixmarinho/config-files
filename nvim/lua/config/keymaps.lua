-- Leader

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- General

-- Exit insert mode

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("v", "<C-c>", "<Esc>", { desc = "Exit visual mode" })

-- Save

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Restart Neovim

vim.keymap.set("n", "<leader>r", "<cmd>restart<CR>", { desc = "Restart Neovim" })

-- Quit

vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

vim.keymap.set("n", "<leader>qq", "<cmd>q!<CR>", { desc = "Quit without saving" })

-- Clear search highlighting

vim.keymap.set("n", "<leader>c", "<cmd>nohlsearch<CR>", {
    desc = "Clear search highlights",
})

-- Toggle Diagnostics and Diagnostics Handling

vim.keymap.set("n", "<leader>;", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    vim.notify(
        "Diagnostics: " .. (vim.diagnostic.is_enabled() and "ON" or "OFF")
    )
end, { desc = "Toggle diagnostics" })

vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end,
    {desc="Open Diagnostics in Float"
    })

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
    desc = "Next Diagnostic",
})

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
    desc = "Previous Diagnostic",
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

vim.keymap.set("n", "n", "nzzzv", {
    desc = "Next search result",
})

vim.keymap.set("n", "N", "Nzzzv", {
    desc = "Previous search result",
})

-- Keep half-page jumps centered

vim.keymap.set("n", "<C-d>", "<C-d>zz", {
    desc = "Half page down",
})

vim.keymap.set("n", "<C-u>", "<C-u>zz", {
    desc = "Half page up",
})

-- Editing

-- Paste without replacing yank register

vim.keymap.set("x", "<leader>p", '"_dP', {
    desc = "Paste without yanking",
})

-- Delete without yanking

vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', {
    desc = "Delete without yanking",
})

-- Move lines

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", {
    desc = "Move line down",
})

vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", {
    desc = "Move line up",
})

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", {
    desc = "Move selection down",
})

vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", {
    desc = "Move selection up",
})

-- Indent and keep selection

vim.keymap.set("v", "<", "<gv", {
    desc = "Indent left",
})

vim.keymap.set("v", ">", ">gv", {
    desc = "Indent right",
})

-- Join lines without moving cursor

vim.keymap.set("n", "J", "mzJ`z", {
    desc = "Join lines",
})

-- Windows
-- Navigate windows / tmux panes

vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", {
    desc = "Move left",
})

vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", {
    desc = "Move down",
})

vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", {
    desc = "Move up",
})

vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", {
    desc = "Move right",
})

-- Split windows

vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", {
    desc = "Split vertically",
})

vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>", {
    desc = "Split horizontally",
})

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

    local function overlap(a1, a2, b1, b2)
	return math.min(a2, b2) - math.max(a1, b1) > 0
    end

    local current_pos = vim.api.nvim_win_get_position(current)
    local current_row = current_pos[1]
    local current_col = current_pos[2]
    local current_height = vim.api.nvim_win_get_height(current)
    local current_width = vim.api.nvim_win_get_width(current)

    local best_win = nil
    local best_distance = math.huge
    local orientation = nil
    local current_after = false

    for _, win in ipairs(vim.api.nvim_list_wins()) do
	if win ~= current and vim.api.nvim_win_is_valid(win) then
	    local pos = vim.api.nvim_win_get_position(win)
	    local row = pos[1]
	    local col = pos[2]
	    local height = vim.api.nvim_win_get_height(win)
	    local width = vim.api.nvim_win_get_width(win)

	    -- Windows side-by-side
	    if overlap(
		current_row,
		current_row + current_height,
		row,
		row + height
	    ) then
		local distance

		if col > current_col then
		    distance = col - (current_col + current_width)
		elseif current_col > col then
		    distance = current_col - (col + width)
		end

		if distance and distance >= 0 and distance < best_distance then
		    best_win = win
		    best_distance = distance
		    orientation = "vertical"
		    current_after = col > current_col
		end
	    end

	    -- Windows above/below
	    if overlap(
		current_col,
		current_col + current_width,
		col,
		col + width
	    ) then
		local distance

		if row > current_row then
		    distance = row - (current_row + current_height)
		elseif current_row > row then
		    distance = current_row - (row + height)
		end

		if distance and distance >= 0 and distance < best_distance then
		    best_win = win
		    best_distance = distance
		    orientation = "horizontal"
		    current_after = row > current_row
		end
	    end
	end
    end

    if not best_win then
	return
    end

    -- Vertical split → horizontal split
    if orientation == "vertical" then
	vim.fn.win_splitmove(current, best_win, {
	    vertical = false,
	    rightbelow = current_after,
	})

	-- Horizontal split → vertical split
    elseif orientation == "horizontal" then
	vim.fn.win_splitmove(current, best_win, {
	    vertical = true,
	    rightbelow = current_after,
	})
    end

    vim.api.nvim_set_current_win(current)
end, { desc = "Toggle split orientation" })


-- Resize windows

vim.keymap.set("n","<C-Up>", "<cmd>resize +2<CR>",  {
    desc = "Increase window height",
})

vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", {
    desc = "Decrease window height",
})

vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +2<CR>", {
    desc = "Increase window width",
})

vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -2<CR>", {
    desc = "Decrease window width",
})

-- Buffers

vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", {
    desc = "Next buffer",
})

vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", {
    desc = "Previous buffer",
})

-- Close current buffer
-- Force Close Buffer Keep Window

local function delete_buffer_keep_window(force)
    local current = vim.api.nvim_get_current_buf()
    local current_win = vim.api.nvim_get_current_win()

    -- Buffers visible in other windows
    local visible = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
	if win ~= current_win then
	    visible[vim.api.nvim_win_get_buf(win)] = true
	end
    end

    -- Find another listed buffer that isn't visible elsewhere
    local buffers = vim.api.nvim_list_bufs()
    local current_index = 0

    for i, buf in ipairs(buffers) do
	if buf == current then
	    current_index = i
	    break
	end
    end

    local next_buf

    for offset = 1, #buffers do
	local i = ((current_index + offset - 1) % #buffers) + 1
	local buf = buffers[i]

	if vim.api.nvim_buf_is_valid(buf)
	    and vim.bo[buf].buflisted
	    and not visible[buf]
	then
	    next_buf = buf
	    break
	end
    end

    if not next_buf then
	vim.notify("No unused buffer available", vim.log.levels.INFO)
	return
    end

    -- Switch first, then delete the old buffer
    vim.api.nvim_set_current_buf(next_buf)
    vim.api.nvim_buf_delete(current, { force = force })
end

-- Normal close
vim.keymap.set("n", "<leader>bq", function()
    delete_buffer_keep_window(false)
end, {
	desc = "Delete buffer, keep window",
    })

-- Force close
vim.keymap.set("n", "<leader>bqq", function()
    delete_buffer_keep_window(true)
end, { desc = "Force delete buffer, keep window",})


-- File / Oil

vim.keymap.set("n", "-", function()
    require("oil").open_float(nil, {
	preview = {
	    vertical = false,
	},
    })
end, {
	desc = "Open parent directory in Oil",
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

vim.keymap.set("n", "<leader><CR>", function()
    vim.treesitter.select("parent")
end, {
	desc = "Treesitter: start selection",
    })

vim.keymap.set("x", "<Enter>", function()
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

-- TreeSJ
-- Split/join the code block under the cursor.
-- <leader> = Space, so this is Space + Shift-M.

vim.keymap.set("n", "<leader>m", function()
    require("treesj").toggle()
end, {
	desc = "TreeSJ: Toggle split/join",
    })

-- Quick Fix

vim.keymap.set("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open quickfix" })

-- vim.keymap.set("n", "<leader>qq", "<cmd>cclose<CR>", { desc = "Close quickfix" })

vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>", { desc = "Next quickfix item" })

vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })

vim.keymap.set("n", "<leader>ql", function()
    vim.diagnostic.setqflist()
end, {
	desc = "Diagnostics to Quickfix",
    })

vim.keymap.set("n", "<leader>qc", function()
    vim.fn.setqflist({})
end, {
	desc = "Clear Quickfix List",
    })
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", {
    desc = "Next Quickfix Item",
})

vim.keymap.set("n", "[q", "<cmd>cprev<CR>", {
    desc = "Previous Quickfix Item",
})

-- Lsp

local builtin = require("fzf-lua")

vim.keymap.set("n", "gd", builtin.lsp_definitions, {
  desc = "LSP: Goto Definition",
})

vim.keymap.set("n", "gr", builtin.lsp_references, {
  desc = "LSP: Goto References",
})

vim.keymap.set("n", "gI", builtin.lsp_implementations, {
  desc = "LSP: Goto Implementation",
})

vim.keymap.set("n", "<leader>gt", builtin.lsp_typedefs, {
  desc = "LSP: Type Definition",
})

vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {
  desc = "LSP: Document Symbols",
})

vim.keymap.set("n", "<leader>ws", builtin.lsp_live_workspace_symbols, {
  desc = "LSP: Workspace Symbols",
})

vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {
  desc = "LSP: Rename",
})

vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, {
  desc = "LSP: Code Action",
})

vim.keymap.set("n", "gdd", vim.lsp.buf.declaration, {
  desc = "LSP: Goto Declaration",
})

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
--
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

vim.keymap.set("n", "z", flash_2char_jump, {
    desc = "Flash 2-char jump",
})
