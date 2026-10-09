return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            picker = {
                enabled = true,
                ui_select = true,
            },

            input = {
                enabled = true,
            },

            notifier = {
                enabled = true,
            },
            scroll = {
                enabled = true,
                animate = {
                    duration = { step = 10, total = 80 },
                    easing = "linear",
                },
                animate_repeat = {
                    delay = 100,
                    duration = { step = 5, total = 50 },
                    easing = "linear",
                },
            },
            dashboard = {
                enabled = true,
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                    { section = "startup" },
                },
            },
        },
    },
}
