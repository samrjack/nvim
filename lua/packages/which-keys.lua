return {
	"folke/which-key.nvim",
	lazy = true,
	event = 'VeryLazy',
	opts = {
		sort = { "alphanum" },
		spec = {
			{ '<leader>',        group = 'Leader' },
			{ '<leader>f',       group = 'File' },
			{ '<leader>t',       group = 'Toggle' },
			{ '<leader>c',       group = 'Code' },
			{ '<leader>cT',      group = 'Treesitter' },
			{ '<leader>cL',      group = 'LSP setrings' },
			{ '<leader>g',       group = 'Git' },
			{ '<leader>a',       group = 'AI' },
			{ '<leader>h',       group = 'Help' },
			{ '<leader>s',       group = 'Search/Replace' },
			{ '<leader><Enter>', group = 'Bookmarks' },
			{ '<leader>w',       group = 'Windows',       proxy = "<C-w>" },
			{
				'<leader>b',
				group = 'Buffers',
				expand = function()
					return require("which-key.extras").expand.buf()
				end
			},
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
