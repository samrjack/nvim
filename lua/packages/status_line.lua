return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
		}
	},
	{
		'kdheepak/tabline.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			'nvim-lualine/lualine.nvim',
		},
		opts = {
			enable = true,
		},
	},
}
