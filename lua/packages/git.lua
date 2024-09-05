-- Plugins for working with git

return {
	{
		'tpope/vim-fugitive',
		lazy = true,
		keys = {
			{"<leader>gg", vim.cmd.Git, desc = "git gui"}
		},
	},
	{
		'airblade/vim-gitgutter',
	},
	{
		'NeogitOrg/neogit',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'sindrets/diffview.nvim',
			'nvim-telescope/telescope.nvim',
		},
		config = true,
	},
	{
		"f-person/git-blame.nvim",
		lazy = true,
		opts = {
			enabled = false,  -- if you want to enable the plugin
			message_template = "  <date> • <summary> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
			date_format = "%Y-%m-%d %H:%M:%S", -- template for the date, check Date format section for more options
			virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
		},
		keys = {
			{'<leader>gb', function() require('gitblame').toggle() end, desc = 'Toggle inline blame'},
		},
	},
}
