return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
        winopts = {
            height = 0.75,
            width = 0.75,
            border = "rounded",

            preview = {
                layout = "vertical",
                vertical = "down:60%",
                border = "rounded",
            },
            winblend = true,
            backdrop = 0,
        },
        fzf_colors = {
            ["bg"] = "-1",
            ["bg+"] = "-1",
            ["gutter"] = "-1",
        },

        fzf_opts = {
            ["--ansi"] = true,
            ["--layout"] = "reverse",
            ["--info"] = "inline-right",
            ["--highlight-line"] = true,
        },
        hls = {
            border = "FzfLuaCustomBorder",
            preview_border = "FzfLuaCustomBorder",
        },
        keymap = {
            builtin = {
                ["<C-d>"] = "preview-half-page-down",
                ["<C-u>"] = "preview-half-page-up",
            },
            -- fzf's native previewer
            fzf = {
                ["ctrl-d"] = "preview-page-down",
                ["ctrl-u"] = "preview-page-up",
            },
        },
        actions = {
            files = {
                true,

                ["alt-q"] = {
                    fn = function(selected, opts)
                        require("fzf-lua.actions").file_sel_to_qf(selected, opts)
                    end,
                    prefix = "select-all",
                },
            },
        },
        git = {
            commits = {
                actions = {
                    ["ctrl-d"] = false,

                    ["ctrl-o"] = function(selected, opts)
                        if not selected[1] then
                            return
                        end

                        local commit = selected[1]:match("[^ ]+")
                        local result = vim.system({
                            "git",
                            "show",
                            "--no-ext-diff",
                            "--no-color",
                            commit,
                        }, {
                                cwd = opts.cwd or vim.fn.getcwd(),
                                text = true,
                            }):wait()

                        if result.code ~= 0 then
                            vim.notify(result.stderr, vim.log.levels.ERROR)
                            return
                        end

                        vim.cmd("vnew")

                        local buf = vim.api.nvim_get_current_buf()
                        local lines = vim.split(result.stdout, "\n", {
                            plain = true,
                        })

                        if lines[#lines] == "" then
                            table.remove(lines)
                        end

                        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

                        vim.bo[buf].buftype = "nofile"
                        vim.bo[buf].bufhidden = "wipe"
                        vim.bo[buf].swapfile = false
                        vim.bo[buf].filetype = "diff"
                        vim.bo[buf].modifiable = false
                    end,
                },
            },
        },
    },


    keys={
        {
            "<leader>ft",
            function() require('fzf-lua').colorschemes() end,
            desc="Find Themes"
        },

        {
            "<leader>ff",
            function() require('fzf-lua').files() end,
            desc="Find Files in project directory"
        },
        {
            "<leader><leader>",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "[,] Find existing buffers",
        },
        {
            "<leader>fr",
            function()
                require("fzf-lua").oldfiles()
            end,
            desc = "[F]ind [O]ld Files",
        },
        {
            "<leader>fw",
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "[F]ind current [W]ord",
        },
        {
            "<leader>fW",
            function()
                require("fzf-lua").grep_cWORD()
            end,
            desc = "[F]ind current [W]ORD",
        },
        {
            "<leader>fb",
            function()
                require("fzf-lua").lgrep_curbuf()
            end,
            desc = "[/] Live grep the current buffer",
        },
        {
            "<leader>fg",
            function() require('fzf-lua').live_grep() end,
            desc="Find by grepping in project directory"
        },
        {
            "<leader>fc",
            function() require('fzf-lua').files({cwd=vim.fn.stdpath("config")}) end,
            desc="Find in neovim configuration"
        },
        {
            "<leader>fcc",
            function()
                require("fzf-lua").builtin()
            end,
            desc = "[F]ind [B]uiltin FZF",
        },
        {
            "<leader>fh",
            function()
                require("fzf-lua").helptags()
            end,
            desc = "[F]ind [H]elp",
        },
        {
            "<leader>fk",
            function()
                require("fzf-lua").keymaps()
            end,
            desc = "[F]ind [K]eymaps",
        },
        {
            "<leader>fl",
            function()
                require("fzf-lua").diagnostics_document()
            end,
            desc = "[F]ind [D]iagnostics",
        },
        {
            "<leader>fj",
            function()
                require("fzf-lua").resume()
            end,
            desc = "[F]ind [R]esume",
        },
        {
            "<leader>gs",
            function()
                require("fzf-lua").git_status()
            end,
            desc = "[F]ind Git Status",
        },
        {
            "<leader>gc",
            function()
                require("fzf-lua").git_commits()
            end,
            desc = "[F]ind Git Commits",
        },
        {
            "<leader>bc",
            function()
                require("fzf-lua").changes()
            end,
            desc = "[F]ind Buffer Changes",
        },
    }
}
