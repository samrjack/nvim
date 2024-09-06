return {
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'munifTanjim/nui.nvim',
			'3rd/image.nvim',
		},
		lazy = true,
		keys = {
			{ '<C-n>', function() vim.cmd.Neotree('toggle') end, desc = 'File tree' },
		}
	}
}
