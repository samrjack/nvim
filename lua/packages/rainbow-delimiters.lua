return {
	'hiphish/rainbow-delimiters.nvim',
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
	},
	opts = {},
	main = 'rainbow-delimiters.setup',
	keys = {
		{
			'<leader>tr',
			function()
				require('rainbow-delimiters').toggle()
			end,
			desc = 'rainbow delimiters'
		},
	},
}
