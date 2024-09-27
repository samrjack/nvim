return {
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-refactor',
			'RRethy/nvim-treesitter-textsubjects',
			'RRethy/nvim-treesitter-endwise',
			'windwp/nvim-ts-autotag',
		},
		lazy = true,
		event = { 'VeryLazy' },
		build = ':TSUpdate',
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				'bash',
				'bibtex',
				'c',
				'c',
				'clojure',
				'cmake',
				'commonlisp',
				'cpp',
				'css',
				'dockerfile',
				'erlang',
				'git_config',
				'gitignore',
				'gnuplot',
				'go',
				'gomod',
				'gosum',
				'gowork',
				'html',
				'java',
				'javascript',
				'jq',
				'json',
				'kotlin',
				'latex',
				'lua',
				'markdown',
				'markdown_inline',
				'python',
				'sql',
				'verilog',
				'vim',
				'vimdoc',
				'xml',
				'yaml',
			}
		},
		config = function(_, opts)
			require('nvim-treesitter.install').prefer_git = true
			require('nvim-treesitter.configs').setup(opts)
			require('configurations.treesitter')
		end,
	},
	{
		'nvim-treesitter/playground',
		dependencies = {
			'nvim-treesitter/nvim-treesitter'
		},
		lazy = true,
		opts = {},
		keys = {
			{ '<leader>cTd', ':TSPlaygroundToggle<CR>', desc = 'TS Visualization' },
		}
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		lazy = true,
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
		event = { 'BufReadPre', 'BufNewFile' },
		-- For future text objects, check https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		opts = {
			textobjects = {
				select = {
					enable = true,
					keymaps = {
						['if'] = { query = '@function.inner', desc = 'Function' },
						['af'] = { query = '@function.outer', desc = 'Function' }
					}
				},
				swap = {
					enable = true,
					swap_next = {
						['<leader>c>'] = '@parameter.inner',
					},
					swap_previous = {
						['<leader>c<'] = '@parameter.inner',
					},
				},
			},
		},
		main = 'nvim-treesitter.configs',
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		lazy = true,
		event = { 'VeryLazy' },
		opts = {
			enable = true,
			max_lines = 0, -- unlimited lines
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = 'outer',
			mode = 'topline', -- Options of 'cursor' for current line or 'topline'
			separator = nil,
			zindex = 20,
			on_atach = nil,
		},
		keys = {
			{ '<leader>cTce', vim.cmd.TSContextEnable,                                                  desc = 'Enable context' },
			{ '<leader>cTcd', vim.cmd.TSContextDisable,                                                 desc = 'Disable context' },
			{ '<leader>cTct', function() require('treesitter-context').setup({ mode = 'topline' }) end, desc = 'Topline context' },
			{ '<leader>cTcc', function() require('treesitter-context').setup({ mode = 'cursor' }) end,  desc = 'Cursor context' },
		}
	}
}
