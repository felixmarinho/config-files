-- Progress to Line Numbers Function

local function progress_p()
    local total = vim.fn.line("$")
    return string.format("%d",total)
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()

        local custom_kanagawa = require('lualine.themes.kanagawa')

        -- Change the background of lualine_c section for normal mode
        -- custom_kanagawa.normal.c.bg = '#1a1a23'
        custom_kanagawa.normal.c.bg = '#1f1f28'
        -- custom_kanagawa.normal.c.bg = '#202228'


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
                        'mode',
                        fmt = function(str)
                            local modes = {
                                NORMAL = 'N',
                                INSERT = 'I',
                                VISUAL = 'V',
                                ['V-LINE'] = 'VL',
                                ['V-BLOCK'] = 'VB',
                                REPLACE = 'R',
                                COMMAND = 'C',
                                TERMINAL = 'T',
                            }

                            return modes[str] or str
                        end,
                    },
                },
                lualine_b = {
                    {
                        'buffers',
                        buffers_color = {
                            active = {
                                fg = '#f2ecbc',
                                bg = '#3a455e',
                            },
                            inactive = {
                                fg = '#727169',
                                -- bg = '#1a1a23',
                                -- bg = '#26272f',
                                bg = '#1f1f28',
                            },
                        },
                    },
                },
                lualine_c = {},
                lualine_x = {'branch', 'diff', 'diagnostics'},
                lualine_y = {progress_p},
                lualine_z = {'location'},
            },
            inactive_sections = {
                lualine_a = {
                    {
                        'buffers',
                    },
                },
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {},
                lualine_x = {'filetype'},
                lualine_y = {progress_p},
                lualine_z = {'location'}
            },
        })
    end,
}
