-- Plugins for working with git

return {
	{
		'tpope/vim-fugitive',
		lazy = true,
		keys = {
			{ "<leader>gG", vim.cmd.Git, desc = "futitive" },
			{
				'<leader>gB',
				function()
					if vim.bo.filetype == 'fugitiveblame' then
						vim.api.nvim_win_close(0, true)
					else
						vim.cmd.Git('blame')
					end
				end,
				desc = 'toggle sideline blame'
			},
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
		lazy = true,
		config = true,
		keys = {
			{ '<leader>gg', function() require('neogit').open() end, desc = 'Git status' },
		}
	},
	{
		"f-person/git-blame.nvim",
		lazy = true,
		opts = {
			enabled = false, -- if you want to enable the plugin
			message_template = "  <date> • <summary> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
			date_format = "%Y-%m-%d %H:%M:%S", -- template for the date, check Date format section for more options
			virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
		},
		keys = {
			{ '<leader>gb', function() require('gitblame').toggle() end, desc = 'Toggle inline blame' },
		},
	},
	{
		'rhysd/git-messenger.vim',
		lazy = true,
		config = function()
			vim.g.git_messenger_always_into_popup = true
			vim.g.git_messenger_floating_win_opts = { border = 'double' }
			vim.g.git_messenger_popup_content_margins = false
		end,
		keys = {
			{ '<leader>gm', vim.cmd.GitMessenger, desc = 'View git commit message' },
		},
	}
}
