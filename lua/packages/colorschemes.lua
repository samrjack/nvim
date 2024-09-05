return {
	{
		'sainnhe/everforest',
		lazy = false,
		priority = 1000,
		
		-- Since this is a nice theme, set it right away to make sure
		-- the system has a theme ASAP. We can then set further theme settings
		-- in the colors config.
		config = function()
			vim.cmd([[colorscheme everforest]])
		end,
	},
	{
		'Mofiqul/dracula.nvim',
		config = true,
	},
	{
		'ellisonleao/gruvbox.nvim',
		config = true,
	},
}
