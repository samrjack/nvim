return {
	{
		'lambdalisue/vim-suda',
		lazy = true,
		event = 'BufWritePre',
		config = function()
			vim.g.suda_smart_edit = 1
		end,
	},
}
