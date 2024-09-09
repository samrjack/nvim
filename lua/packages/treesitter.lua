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
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		lazy = true,
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
		event = { 'BufReadPre', 'BufNewFile' },
		-- For future text objects, check https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		config = function()
			local opts = {
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							['if'] = { query = '@function.inner', desc = 'Inner function' },
						}
					},
					swap = {
						enable = true,
						swap_next = {
							['<leader>c>'] = '@parameter.inner',
						},
						swap_previous = {
							['<leader>c<'] = '@parameter.inner',
						},
					},
				},
			}

			require('nvim-treesitter.configs').setup(opts)
		end
	},
}
