return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		sort = {"alphanum"},
		spec = {
			{'<leader>', group = 'leader'},
			{'<leader>f', group = 'file'},
			{'<leader>t', group = 'toggle'},
			{'<leader>c', group = 'code'},
			{'<leader>cT', group = 'treesitter'},
			{'<leader>cL', group = 'LSP setrings'},
			{'<leader>g', group = 'git'},
			{'<leader>h', group = 'help'},
			{'<leader>s', group = 'search/replace'},
			{'<leader><Enter>', group = 'bookmarks'},
			{'<leader>w', group = 'windows', proxy = "<C-w>"},
			{'<leader>b', group = 'buffers', expand = function()
				return require ("which-key.extras").expand.buf()
			end},
		},
	},
	keys = {
		{
			'<leader>?',
			function()
				require('which-key').show({ global = false })
			end,
			desc = 'Local keymaps',
		},
		{
			'<leader>/',
			function()
				require('which-key').show({ global = true })
			end,
			desc = 'Global keymaps',
		},
	},
}
