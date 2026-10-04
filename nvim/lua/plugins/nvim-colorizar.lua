return {
	"catgoose/nvim-colorizer.lua",

	opts = {
		options = {
			parsers = {
				names = { enable = true }, -- "Name" codes like Blue
				RGB = { enable = true }, -- #RGB hex codes
				RRGGBB = { enable = true }, -- #RRGGBB hex codes
				RRGBA = { enable = false }, -- #RGBA hex codes
				RRGGBBAA = { enable = false }, -- #RRGGBBAA hex codes
				rgb_fn = { enable = false }, -- CSS rgb() and rgba() functions
				hsl_fn = { enable = false }, -- CSS hsl() and hsla() functions
				css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			},

			display = {
				-- Available modes: foreground, background
				mode = "background", -- Set the display mode.
			},
		},
	},
}
