return {
	'norcalli/nvim-colorizer.lua',
	lazy = true,
	event = 'BufWinEnter',
	opts = {
		'*',        -- Highlight all files, but customize some others.
		css = {
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			rgb_fn   = true, -- CSS rgb() and rgba() functions
			hsl_fn   = true, -- CSS hsl() and hsla() functions
			css      = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn   = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		},
		html = {
			RRGGBBAA = true, -- #RRGGBBAA hex codes
		},
		javascript = {
			RRGGBBAA = true, -- #RRGGBBAA hex codes
		}
	},
}
