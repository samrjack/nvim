return {
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-refactor',
			'RRethy/nvim-treesitter-textsubjects',
			'RRethy/nvim-treesitter-endwise',
			'windwp/nvim-ts-autotag',
		},
		lazy = true,
		build = ':TSUpdate',
		config = function()
			require('configurations.treesitter')
		end,
		event = { 'BufReadPre', 'BufNewFile' },
	},
	{
		'nvim-treesitter/playground',
		dependencies = {
			'nvim-treesitter/nvim-treesitter'
		},
		lazy = true,
		opts = {},
		keys = {
			{ '<leader>cTd', ':TSPlaygroundToggle<CR>', desc = 'TS Visualization' },
		}
	},
}
