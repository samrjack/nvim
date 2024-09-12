return {
	{
		-- Gives nice download progress info in the bottom right
		'j-hui/fidget.nvim',
		opts = {},
		lazy = true,
	},
	{
		'L3MON4D3/LuaSnip',
		-- follow latest release.
		version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = 'make install_jsregexp',
		lazy = true
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		},
		lazy = true,
		opts = function() -- When opts is a function, it needs to return the table to be used for setup
			local cmp = require('cmp')

			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			return {
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end
				},
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<C-y><C-s>'] = cmp.mapping.confirm({ select = true }),
					['<C-y>'] = cmp.mapping.confirm({ select = true }),
					['<C-Space>'] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
						{ name = 'nvim_lsp' },
						{ name = 'luasnip' },
					},
					{
						{ name = 'buffer' },
					}),
			}
		end,
	},
	{
		'hrsh7th/cmp-nvim-lsp',
		lazy = true,
		opts = {
			sources = {
				{
					name = 'nvim_lsp'
				},
			},
		},
	},
	{
		'williamboman/mason.nvim',
		build = ':MasonUpdate',
		lazy = true,
		opts = {},
		cmd = "Mason",
		keys = {
			{ '<leader>cLM', ':Mason<cr>', desc = 'LSP server manager' },
		},
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {
			'j-hui/fidget.nvim',
			'williamboman/mason.nvim',
		},
		lazy = true,
		opts = {
			-- See here for full list: https://github.com/williamboman/mason-lspconfig.nvim
			ensure_installed = {
				'bashls',
				'gitlab_ci_ls', -- yaml
				'gopls',
				'html',
				'jqls',
				'jsonls',
				'kotlin_language_server',
				'lua_ls',
				'matlab_ls',
				'ocamllsp',
				'openscad_lsp',
				'pyright',
				'vacuum', -- openAPI
				'yamlls',
			},
		},
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/nvim-cmp',
		},
		lazy = true,
		event = { 'FileReadPre', 'FileType' },
		config = function()
			local lspconfig = require('lspconfig')

			local cmp_lsp = require('cmp_nvim_lsp')
			local capabilities = vim.tbl_deep_extend(
				'force',
				{},
				lspconfig.util.default_config.capabilities,
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			require('mason-lspconfig').setup_handlers({
				-- default handler; override handlers can be setup below
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				['lua_ls'] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_init = function(client)
							local path = client.workspace_folders[1].name
							if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
								return
							end

							client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
								runtime = {
									version = 'LuaJIT',
								},
								-- Make the server aware of Neovim runtime files
								workspace = {
									checkThirdParty = false,
									-- library = {
									-- 	vim.env.VIMRUNTIME
									-- }
									-- Or pull in all of 'runtimepath'. This is a LOT slower
									library = vim.api.nvim_get_runtime_file('', true)
								}
							})
						end,
						settings = {
							Lua = {
								diagnostics = {
									globals = { 'vim', }
								}
							}
						}
					})
				end,

			})
		end,
	},
}
