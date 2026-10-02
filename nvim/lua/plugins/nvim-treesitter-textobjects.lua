return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        enable = true,
        lookahead = true,
        include_surrounding_whitespace = true,
      },

      swap = {
        enable = true,
      },
    })
  end,
}
