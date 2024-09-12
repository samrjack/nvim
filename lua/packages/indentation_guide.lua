return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			enabled = true,
		},
		lazy = true,
		keys = {
			{
				'<leader>ti',
				function()
					require("ibl").setup_buffer(0, {
						enabled = not require("ibl.config").get_config(0).enabled,
					})
				end,
				desc = 'Toggle indentation'
			},
		}
	},
}
