return {
	{
		'otavioschwanck/arrow.nvim',
		lazy = true,
		config = function()
			local opts = {
				show_icons = true,
				leader_key = '<leader><Enter><Enter>', -- This plugin assigns a key by default which is dumb. This should turn it off.
				buffer_leader_key = '<leader><Enter>b',
			}
			require('arrow').setup(opts)
			require('arrow.persist').load_cache_file()
		end,
		keys = {
			{'<leader><Enter><Enter>', desc = 'Bookmark Arrows'},
			{'<leader><Enter>b', desc = 'Buffer Bookmarks'},
		}
	},
	{
		'ThePrimeagen/harpoon',
		branch = 'harpoon2',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
		},
		lazy = true,
		config = function()
			local opts = {
				settings = {
					save_on_toggle = false,
					sync_on_ui_close = true,
				},
			}
			local harpoon = require('harpoon')
			harpoon:setup(opts)

		end,
		keys = {
			{'<leader><Enter>h', function()
				local harpoon = require('harpoon')
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, desc = 'Harpoon menu'},
			{'<leader><Enter>a', function() require('harpoon'):list():add() end, desc = 'Harpoon add'},
		}
	}
}