local function parse_output(proc)
  local result = proc:wait()
  local ret = {}

  if result.code == 0 then
    for line in vim.gsplit(result.stdout, "\n", {
      plain = true,
      trimempty = true,
    }) do
      line = line:gsub("/$", "")
      ret[line] = true
    end
  end

  return ret
end

local function new_git_status()
  return setmetatable({}, {
    __index = function(self, key)
      local ignore_proc = vim.system(
        {
          "git",
          "ls-files",
          "--ignored",
          "--exclude-standard",
          "--others",
          "--directory",
        },
        {
          cwd = key,
          text = true,
        }
      )

      local tracked_proc = vim.system(
        { "git", "ls-tree", "HEAD", "--name-only" },
        {
          cwd = key,
          text = true,
        }
      )

      local ret = {
        ignored = parse_output(ignore_proc),
        tracked = parse_output(tracked_proc),
      }

      rawset(self, key, ret)
      return ret
    end,
  })
end

local git_status = new_git_status()

function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)

  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

return {
  "stevearc/oil.nvim",

  ---@module "oil"
  ---@type oil.SetupOpts
  opts = {
    delete_to_trash = true,
    prompt_save_on_select_new_entry = true,
    watch_for_changes = true,

    view_options = {
      show_hidden = true,

      is_hidden_file = function(name, bufnr)
        local dir = require("oil").get_current_dir(bufnr)
        local is_dotfile = vim.startswith(name, ".") and name ~= ".."

        if not dir then
          return is_dotfile
        end

        if is_dotfile then
          return not git_status[dir].tracked[name]
        end

        return git_status[dir].ignored[name]
      end,

      is_always_hidden = function(name, bufnr)
        return false
      end,

      natural_order = "fast",
      case_insensitive = false,

      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },

      highlight_filename = function(
        entry,
        is_hidden,
        is_link_target,
        is_link_orphan
      )
        return nil
      end,
    },

    float = {
      padding = 5,
      max_width = 0,
      max_height = 0,
      border = nil,

      win_options = {
        winblend = 0,
      },

      preview_split = "auto",

      override = function(conf)
        return conf
      end,
    },

    preview_win = {
      update_on_cursor_moved = true,
      preview_method = "fast_scratch",

      disable_preview = function(filename)
        return false
      end,

      win_options = {},
    },

    confirmation = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,

      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,

      border = nil,

      win_options = {
        winblend = 0,
      },
    },

    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,

      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,

      border = nil,

      minimized_border = "none",

      win_options = {
        winblend = 0,
      },
    },

    ssh = {
      border = nil,
    },

    keymaps_help = {
      border = nil,
    },

    win_options = {
      winbar = "%!v:lua.get_oil_winbar()",
    },
  },

  dependencies = {
    { "nvim-mini/mini.icons", opts = {} },
  },

  lazy = false,

  config = function(_, opts)
    require("oil").setup(opts)

    -- Oil is now loaded, so oil.actions exists.
    local refresh = require("oil.actions").refresh
    local orig_refresh = refresh.callback

    refresh.callback = function(...)
      git_status = new_git_status()
      orig_refresh(...)
    end
  end,
}
