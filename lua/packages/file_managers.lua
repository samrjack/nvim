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
		opts = {
			add_blank_line_at_top = true,
			close_if_last_window = true,
			source_selector = {
				winbar = true, -- Have clickable tabs for showing which mode neotree is in
			},
			window = {
				mappings = {
					['^'] = { 'navigate_up' },
					['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
					['<Tab>'] = { 'toggle_node' },
				},
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		},
		keys = {
			{ '<C-n>', ':Neotree left reveal toggle<cr>',  desc = 'File tree' },
			{ 'g.',    ':Neotree float reveal toggle<cr>', desc = 'File tree' },
		}
	},
	{
		'stevearc/oil.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		},
		lazy = true,
		opts = {
			default_file_explorer = false,
		},
		cmd = { 'Oil' },
		keys = {
			{ 'go', vim.cmd.Oil, desc = 'Oil' }
		},
	}
}
