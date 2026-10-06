return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()

        local custom_kanagawa = require('lualine.themes.kanagawa')

        -- Change the background of lualine_c section for normal mode
        -- custom_kanagawa.normal.c.bg = '#18181d'

        require('lualine').setup ({
            options = {
                icons_enabled = true,
                theme = custom_kanagawa,
                component_separators = '|',
                section_separators = '',
                globalstatus = true,
            },
            sections = {
                lualine_a = {
                    {
                        'buffers',
                        buffers_color = {
                            active = {
                                fg = '#f2ecbc',
                                bg = '#3a455e',
                            },
                            inactive = {
                                fg = '#727169',
                                bg = '#242636',
                            },
                        },
                    },
                },
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {},
                lualine_x = {'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },

            inactive_sections = {
                lualine_a = {
                    {
                        'buffers',
                        buffers_color = {
                            active = {
                                fg = '#f2ecbc',
                                bg = '#3a455e',
                            },
                            inactive = {
                                fg = '#727169',
                                bg = '#242636',
                            },
                        },
                    },
                },
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {},
                lualine_x = {'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
        })
    end,
}
