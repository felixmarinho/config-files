-- Leader

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- General

-- Exit insert mode

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("v", "<C-c>", "<Esc>", { desc = "Exit visual mode" })

-- Command line

vim.keymap.set("n", "<leader>;", ":", { desc = "Command line" })

-- Save

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })

-- Quit

vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>q!<CR>", { desc = "Quit without saving" })
vim.keymap.set("n", "<leader>QQ", "<cmd>qa!<CR>", { desc = "Quit all without saving" })

-- Clear search highlighting

vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<CR>", {
    desc = "Clear search highlights",
})

-- Toggle word wrap

vim.keymap.set("n", "<leader>e", function()
    vim.opt.wrap = not vim.opt.wrap:get()
    vim.notify("Wrap: " .. (vim.opt.wrap:get() and "ON" or "OFF"))
end, { desc = "Toggle word wrap" })

-- Conceal Level

vim.keymap.set("n", "<leader>co", function()
    local level = vim.opt.conceallevel:get()
    local next = (level + 1) % 4

    vim.opt.conceallevel = next
    vim.notify("Conceal " .. next)
end, { desc = "Cycle conceal level" })

-- Toggle whitespace

vim.keymap.set("n", "<leader>l", "<cmd>set list!<CR>", {
    desc = "Toggle whitespace",
})

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

-- Resize windows

vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", {
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

-- Comments

-- Requires Comment.nvim

vim.keymap.set("n", "<leader>c", "gcc", {
    remap = true,
    desc = "Toggle comment",
})

vim.keymap.set("v", "<leader>c", "gc", {
    remap = true,
    desc = "Toggle comment",
})

-- File / Oil

vim.keymap.set("n", "-", function()
	require("oil").open_float(nil, {
		preview = {
			vertical = true,
		},
	})
end, {
	desc = "Open parent directory in Oil",
})

-- Diagnostics

vim.keymap.set("n", "<leader>td", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, {
	desc = "Toggle diagnostics",
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

vim.keymap.set("n", "<Enter>", function()
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

-- Telescope

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {
    desc = "Find files",
})

vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
    desc = "Live grep",
})

vim.keymap.set("n", "<leader>fb", builtin.buffers, {
    desc = "Find buffers",
})

vim.keymap.set("n", "<leader>fh", builtin.help_tags, {
    desc = "Find help",
})

-- TreeSJ
-- Split/join the code block under the cursor.
-- <leader> = Space, so this is Space + Shift-M.

vim.keymap.set("n", "<leader>m", function()
	require("treesj").toggle()
end, {
	desc = "TreeSJ: Toggle split/join",
})
