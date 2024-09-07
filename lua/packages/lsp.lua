return {
	{
		-- Gives nice download progress info in the bottom right
		'j-hui/fidget.nvim',
		opts = {},
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		-- version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp"
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function()
			local cmp = require('cmp')

			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local opts = {
				snippet = {
					expand = function(args)
						require('lunasnip').lsp_expand(args.body)
					end
				},
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<C-y>'] = cmp.mapping.confirm({ select = true }),
					['<C-Space>'] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'lunasnip' },
				},
				{
					{ name = 'buffer' },
				}),
			}

			cmp.setup(opts)
		end
	},
	{
		'hrsh7th/cmp-nvim-lsp',
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
			-- See here for full list: https://github.com/williamboman/mason-lspconfig.nvim
	 		ensure_installed = {
				"bashls",
				"gitlab_ci_ls", -- yaml
				"gopls",
				"html",
				"jqls",
				"jsonls",
				"kotlin_language_server",
				"lua_ls",
				"matlab_ls",
				"ocamllsp",
				"openscad_lsp",
				"pyright",
				"vacuum", -- openAPI
				"yamlls",
			},
		},
		keys = {
			{ '<leader>cLM', ':Mason<cr>', desc = 'LSP server manager'},
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
							if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
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
									library = vim.api.nvim_get_runtime_file("", true)
								}
							})

						end,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim", }
								}
							}
						}
					})
				end,

			})
		end,
	},
}
