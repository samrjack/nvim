return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	lazy = true,
	keys = {
		{'<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'find files'},
		{'<leader>fp', function() require('telescope.builtin').git_files() end, desc = 'project files'},
		{'<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'grep files'},
		{'<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'find buffer'},
		{'<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'find help tag'},
	},
}
