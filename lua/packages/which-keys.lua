return {
	"folke/which-key.nvim",
	lazy = true,
	event = 'VeryLazy',
	opts = {
		sort = { "alphanum" },
		spec = {
			{ '<leader>',        group = 'Leader' },
			{ '<leader><Enter>', group = 'Bookmarks' },
			{ '<leader>a',       group = 'AI' },
			{ '<leader>c',       group = 'Code' },
			{ '<leader>cL',      group = 'LSP settings' },
			{ '<leader>cT',      group = 'Treesitter' },
			{ '<leader>cm',      group = 'Markdown settings' },
			{ '<leader>f',       group = 'File' },
			{ '<leader>g',       group = 'Git' },
			{ '<leader>h',       group = 'Help' },
			{ '<leader>s',       group = 'Search/Replace' },
			{ '<leader>t',       group = 'Toggle' },
			{ '<leader>w',       group = 'Windows',          proxy = "<C-w>" },
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
