return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        local treesitter = require("nvim-treesitter")

        treesitter.setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        treesitter.install({
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "elixir",
            "heex",
            "javascript",
            "html",
            "css",
            "python",
            "go",
            "php",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "elixir",
                "heex",
                "javascript",
                "html",
                "css",
                "python",
                "go",
                "php",
            },
            callback = function()
                -- Treesitter highlighting
                vim.treesitter.start()

                -- Treesitter indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
