return {
  "nvim-telescope/telescope.nvim",
  version = "*",

  dependencies = {
    "nvim-lua/plenary.nvim",

    {
      "nvim-mini/mini.icons",
      config = function()
        require("mini.icons").setup()
        require("mini.icons").mock_nvim_web_devicons()
      end,
    },

    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },

  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        layout_strategy = "horizontal",

        layout_config = {
          horizontal = {
            width = 0.99,
            height = 0.99,
            preview_width = 0.6,
          },
        },
      },
    })

    telescope.load_extension("fzf")
  end,
}
