return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
	lazy = false,

    config = function()
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
            },
        })
    end,
}

