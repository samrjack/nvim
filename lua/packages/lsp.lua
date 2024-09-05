return {
	{
		-- Gives nice download progress info in the bottom right
		'j-hui/fidget.nvim',
		opts = {},
	},
	{
		'williamboman/mason.nvim',
		lazy = false,
		opts = {},
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {
			'j-hui/fidget.nvim',
			'williamboman/mason.nvim',
		},
		lazy = false,
		opts = {
			ensure_installed = { 
				"lua_ls",
				"bashls",
				"gopls",
				"pyright",
			},
			handlers = {
				-- default handler; override handlers can be setup below
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
				['lua_ls'] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim", }
								}
							}
						}
					})
				end,
				
			}
		},
		keys = {
			{ '<leader>cLM', ':Mason<cr>', desc = "LSP server manager"},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		},
	},
}
