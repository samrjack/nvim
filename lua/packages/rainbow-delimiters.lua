return {
	'hiphish/rainbow-delimiters.nvim',
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
	},
	config = function()
		local opts = {}
		require('rainbow-delimiters.setup').setup(opts)
	end,
	keys = {
		{ '<leader>tr',
		function()
			require('rainbow-delimiters').toggle()
		end,
		desc = 'rainbow delimiters' },
	},
}
