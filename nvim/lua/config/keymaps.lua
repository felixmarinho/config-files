

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- General

-- Exit insert mode

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("v", "<C-c>", "<Esc>", { desc = "Exit visual mode" })

-- Save

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-c>", "<Esc><cmd>w<CR>", { desc = "Save file" })
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

vim.keymap.set("n", "<cmd>resize +2<CR>", "<C-Up>", {
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
vim.keymap.set("n", "<leader>bq", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Force close
vim.keymap.set("n", "<leader>bqx", "<cmd>bdelete!<CR>", { desc = "Force close buffer" })

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
			vertical = false,
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

-- Quick Fix

vim.keymap.set("n", "<leader>vo", "<cmd>copen<CR>", { desc = "Open quickfix" })

vim.keymap.set("n", "<leader>vc", "<cmd>cclose<CR>", { desc = "Close quickfix" })

vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>", { desc = "Next quickfix item" })

vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })


