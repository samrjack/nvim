return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		sort = {"alphanum"},
		spec = {
			{'<leader>f', group = 'file'},
			{'<leader>t', group = 'toggle'},
			{'<leader>c', group = 'code'},
			{'<leader>cT', group = 'treesitter'},
			{'<leader>g', group = 'git'},
			{'<leader>h', group = 'help'},
			{'<leader>w', group = 'windows', proxy = "<C-w>"},
			{'<leader>b', group = 'buffers', expand = function() 
				return require ("which-key.extras").expand.buf() 
			end},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
