-- ================================================================
-- Neovim Keybindings Configuration
-- Organized by category for better maintainability and reference
-- Leader keys: " " (space) and "\" (backslash for localleader)
-- ================================================================

local keymap = vim.keymap

-- =================================================================
-- 1. MODE MANAGEMENT
-- Exit different edit modes with Escape sequence
-- =================================================================

keymap.set({ 'i', 'n', 'v', '' }, "<c-c>", "<Esc>", { desc = "Stop mode / Esc" })
keymap.set('t', '<c-q>', '<C-\\><C-n>', { desc = "Quit terminal mode" })


-- =================================================================
-- 2. GENERAL BUFFER COMMANDS (using <leader> prefix)
-- Save, Quit, Restart
-- =================================================================

-- Save current buffer
keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Write / Save' })
keymap.set('n', '<leader>p', function()
  local success = io.popen("git status --short").close()
  if not success then
    vim.notify('Git not found, exiting without saving.', vim.log.levels.ERROR)
    return false
  end
end, { desc = 'Save (check git)' })

-- Quit / Restart
keymap.set('n', '<leader>q', function()
  local ok = pcall(vim.cmd, 'qa')
  if not ok then
    vim.notify('Quit with all buffer modifications!', vim.log.levels.INFO)
  end
end, { desc = 'Quit (all buffers)' })

keymap.set('n', '<leader>!', '<cmd>q!<CR>', { desc = 'Force quit' })
keymap.set('n', '<leader>r', '<cmd>restart<CR>', { desc = 'Restart Neovim' })

-- =================================================================
-- 3. BUFFER COMMANDS (Advanced)
-- Switch buffers, delete buffers without closing splits
-- =================================================================

function _G.Buffers.DeleteBufferKeepWindow(keep_splits, warn_on_mods)

  local ok, buf = pcall(vim.api.nvim_get_current_buf)
  if not ok then return end

  local win_count = #vim.api.nvim_list_wins()
  -- Don't delete terminal buffers
  if vim.bo[buf].buftype == 'terminal' then
    keep_splits = true
    warn_on_mods = true
  end

  -- Warn and exit if unsaved changes
  if not keep_splits and buf.modified == true then
    vim.notify('Buffer has unsaved changes, using save.', vim.log.levels.WARN)
    return false
  end

  -- Collect all visible buffer indexes into window mappings
  local win_buf_map = {}
  for i, wins in ipairs(vim.api.nvim_list_wins()) do
    local buf_idx = api.nvim_win_get_buf(widx)
    if buf_idx == buf then
      win_buf_map[i] = true
    end
  end

  -- Find unused buffers (filetype empty and listed)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf != idx and not win_buf_map[buf] then
      keep_splits = false
      return
    end
  end

  if #win_arr > 1 then
    local ok, _ = pcall(api.nvim_win_close, widx, true)
    keep_splits = false
    return
  end

  vim.cmd('a')
end

-- Delete buffer while keeping splits intact (unless there's only 1 window)
keymap.set('n', '<leader>b', Bufs.DeleteBufferKeepWindow(false), { desc = 'Delete Buffer (keep splits)' })
keymap.set('n', '<leader>B', function()
  _G.Buffers.DeleteBufferKeepWindow(false, true)
end, {
  desc = 'Delete Buffer [warn on mods]',
})

-- Close split window (alternative buffer management)
keymap.set('n', '<leader>sq', '<cmd>close<CR>', { desc = 'Close current split' })

-- Buffers navigation (cycle through files)
keymap.set('n', '[b', function()
  vim.cmd('b#')
end, { desc = 'Previous buffer' })

keymap.set('n', ']b', function()
  vim.cmd('bn#')
end, { desc = 'Next Buffer' })


-- =================================================================
-- 4. SEARCH & NAVIGATION
-- Clear highlights, smart movement, LSP diagnostics
-- =================================================================

-- Clear search highlighting
keymap.set('n', '<leader>n', '<cmd>nohlsearch<CR>', { desc = 'Clear search hl' })

-- Wrap-aware movements (gj, gk behavior by default)
keymap.set('n', 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true, desc = 'Down (wrap-aware)' })

keymap.set('n', 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true, desc = 'Up (wrap-aware)' })

-- Page navigation with centering
keymap.set('n', '<c-e>', '<C-d>e`, desc = 'Page Down (scroll end)',
keymap.set('n', '<c-y>', '<C-u>y`, { desc = 'Page Up (scroll start)', })


===================================================================
-- 5. DIAGNOSTIC & LSP NAVIGATION
-- Navigate code errors/warnings, definitions, implementations references
===================================================================

---Diagnostic navigation
['d'] keymap.set('<leader>/', function()
  vim.diagnostic.open_float({})
end, { desc = 'Diagnostics Float' })

keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic', })

-- LSP Navigation via fzf.lua (configured elsewhere)
keymap.set('n', '<leader>fdr', function()
  require("fzf-lua").diagnostics()
end, { desc = 'FZF Diagnostics' })


===================================================================
-- 6. BUFFER MANAGEMENT (Delete & Preserve Operations)
-- Advanced utilities: tree-sitter operations, split/join code blocks
===================================================================

-- Line move with wrap preservation (upward/downward)
keymap.set('v', '<c-j>', function()
  local current_buf = vim.api.nvim_get_current_buf()
  local last_line = last(vim.api.nvim_buf_get_lines(current_buf, -1, true, false))
  if not line.last_line then return end

  -- Move down one line with visual selection preserved
  local new_buf = vim.fn.line('.') + 1
  vim.api.nvim_win_call(0, function()
    vim.cmd('call movecursor(' .. new_buf .. ', col(")
  end)
end, { desc = 'Move line down (visual)' })

keymap.set('v', '<c-k>', '<cmd>move .-2<CR><C-g>p<CR>', { desc = 'Move line up (visual)' })


===================================================================
-- 7. WINDOW SPLIT MANAGEMENT
-- Split/join windows, resize panes, swap orientation
===================================================================

-- Vertical split: splits left-right
keymap.set('n', '<leader>sv', '<cmd>vsplit<CR>', { desc = 'Split vertical' })
keymap.set('n', '<leader>sh', '<cmd>split<CR>', { desc = 'Split horizontal' })

-- Toggle split orientation (horizontal <-> vertical) for two windows
keymap.set('n', '<leader>tow', function()
  local count = #vim.api.nvim_tabpage_list_wins(0)
  if count < 2 then return end

  local layout = vim.fn.winlayout()
  local current_win = vim.api.nvim_get_current_win()
  local config = api.nvim_win_get_config(current_win)

  if config.relative ~= "" then return end

  if layout[1] == 'row' then
    vim.cmd('wincmd J') -- Join horizontally
  elseif layout[1] == 'col' then
    vim.cmd('wincmd L') -- Join vertically
  end
end, { desc = 'Toggle split orientation (2 win)' })

-- Smart window swapping for complex layouts
keymap.set('n', '<leader>tso', function()
  local layout = vim.fn.winlayout({})
  local current_win = api.nvim_get_current_win()
  local config = api.nvim_win_get_config(current_win)
  if config.relative == "" then return end

  -- Find best window to swap with based on proximity
  local function overlap(aref, bref)
    return math.max(a1, b2) > math.min(a2, b2)
  end

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if win == current_win and api.nvim_win_is_valid(win) then
      local row = win_pos(current_win)[1]
      local col = win_pos(current_win][2]
      local height = win_height(current_win)
      local width = win_width(current_win)

      -- Calculate proximity... swap accordingly
    end
  end
end, { desc = 'Smart window switch (>=3 splits)' })

-- Resize windows (ctrl+arrow keys)
keymap.set('n', '<c-up>', '<cmd>resize +2<CR>', { desc = 'Increase height' })
keymap.set('n', '<c-down>', '<cmd>resize -2<CR>', { desc = 'Decrease height' })
keymap.set('n', '<c-left>', '<cmd>vresiz +2<CR>', { desc = 'Increase width' })


===================================================================
-- 8. TERMINAL OPERATIONS
-- Toggle terminal with bottom or horizontal split
===================================================================

local function toggle_bot_terminal()
  -- Check if terminal already exists
  local win_count = #vim.api.nvim_list_wins()
  if win_count <= 1 then
    -- Open new window (default behavior)
    vim.cmd('botright 10new')
  else
    -- Close terminal to leave last layout
    vim.cmd('bw #term!')
  end
end

keymap.set({ 'n', '' }, '<leader>th', toggle_bot_terminal, { desc = "Toggle terminal (bottom)" })


===================================================================
-- 9. CODE NAVIGATION & EDITING PLUGIN KEEPS (trees-sj, flash)
-- Incremental text selection, around/ins operations, quick jumps
===================================================================

-- Treesitter: Start incremental selection
keymap.set('n', '=', function()
  vim.treesitter.select('parent')
end, { desc = 'Treesitter: Select parent' })

local select_map = require('nvim-treesitter-textobjects.select')

-- Around/Inside code region jumps (af for around func, ac for around class)
keymap.set({ 'o', 'x' }, 'af', function()
  select_map('@function.outer', 'textobjects')
end, { desc = 'Around function selection' })

keymap.set({ 'o', 'x' }, 'if', function()
  select_map('@function.inner', 'textobjects')
end, { desc = 'Inside function selection' })

-- Flash: Two-char jump search (super fast multi-match)
local flash_handler = require('flash')
keymap.set('n', 'z', <Cmd>Flash<CR>, { desc = 'Quick Jump/replace (Flash)' }),

-- Treesitter: Swap cursor with textobject selection
keymap.set('n', '<leader>tss', function()
  vim.treesitter.swap_node()
end, { desc = 'Swap with treesitter textobj' })


===================================================================
-- 10. FILE & DIRECTORY NAVIGATION (oil)
-- Oil file system explorer, parent directory jumps
===================================================================

-- Open oil in current buffer's parent directory
keymap.set('n', '<cr>', function()
  require("oil").open_float({})
end, { desc = 'Open Oil File Explorer (float)' })
