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
}
