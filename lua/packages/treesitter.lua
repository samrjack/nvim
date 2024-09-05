return {
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-refactor',
			'RRethy/nvim-treesitter-textsubjects',
			'RRethy/nvim-treesitter-endwise',
			'windwp/nvim-ts-autotag',
		},
		build = ':TSUpdate',
		config = function()
			require('configurations.treesitter')
		end,
	},
	{
		'nvim-treesitter/playground',
		dependencies = {
			'nvim-treesitter/nvim-treesitter'
		},
		config = true,
		keys = {
			{'<leader>cTd', ':TSPlaygroundToggle<CR>', desc = 'Visualization'},
		}
	}
}
