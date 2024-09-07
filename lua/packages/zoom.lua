return {
	'nyngwang/NeoZoom.lua',
	config = true,
	keys = {
		{'<C-w>z', function() require('neo-zoom').neo_zoom() end, desc = 'Zoom'},
	}
}
