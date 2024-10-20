return {
	{
		'rafamadriz/friendly-snippets',
		lazy = true,
		config = function()
			require('luasnip.loaders.from_vscode').lazy_load()
		end,
	},
	{
		-- This one doesn't quite work yet
		'molleweide/LuaSnip-snippets.nvim',
		lazy = true,
		config = function()
			require('luasnip.loaders.from_lua').lazy_load()
		end,
	},
	{
		'L3MON4D3/LuaSnip',
		dependencies = {
			'rafamadriz/friendly-snippets',
			'molleweide/LuaSnip-snippets.nvim',
		},
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
			'hrsh7th/cmp-nvim-lsp', -- Complete from lsp suggestions
			'hrsh7th/cmp-nvim-lua', -- Complete nvim lua api
			'hrsh7th/cmp-buffer', -- Complete words and items from the buffer
			'hrsh7th/cmp-path', -- Complete file name
			'hrsh7th/cmp-cmdline', -- Completion for Vim's commandline
			'onsails/lspkind.nvim', -- Clean up recommendation box and show source
			'f3fora/cmp-spell', -- Spelling recommendations
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
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<C-y>'] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
						c = cmp.mapping.confirm({ select = true })
					}),
					['<CR>'] = cmp.mapping({
						-- i = function(fallback)
						-- 	if cmp.visible() and cmp.get_active_entry() then
						-- 		cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						-- 	else
						-- 		fallback()
						-- 	end
						-- end,
						i = cmp.mapping.confirm({ select = true }),
						s = cmp.mapping.confirm({ select = true }),
						c = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
					}),
					['<C-Space>'] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lua' },
					{ name = 'luasnip' },
					{ name = 'buffer' },
				}, {
					{ name = 'path' },
				}, {
					{ name = 'spell' },
				}),
				formatting = {
					format = require('lspkind').cmp_format({
						with_text = true,
						show_labelDetails = true,
						menu = {
							buffer = '[buf]',
							nvim_lsp = '[LSP]',
							nvim_lua = '[api]',
							path = '[path]',
							luasnip = '[snip]',
							spell = '[spell]',
						}
					})
				},
				experimental = {
					ghost_text = true, -- show recommendation as typing takes place
				},
			}
		end,
		config = function(_, opts)
			local cmp = require('cmp')

			cmp.setup(opts)

			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline()
			})
			cmp.setup.cmdline({ ':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' },
					{ name = 'cmdline' },
				})
			} })
		end,
	},
	{
		'williamboman/mason.nvim',
		build = ':MasonUpdate',
		lazy = true,
		opts = {},
		cmd = 'Mason',
		keys = {
			{ '<leader>cLM', ':Mason<cr>', desc = 'LSP server manager' },
		},
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {
			{ 'j-hui/fidget.nvim', opts = {}, lazy = true },
			'williamboman/mason.nvim',
		},
		lazy = true,
		opts_extend = { 'ensure_installed' },
		opts = {
			-- See here for full list: https://github.com/williamboman/mason-lspconfig.nvim
			ensure_installed = {
				'bashls',
				'gitlab_ci_ls', -- yaml
				'html',
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
			'hrsh7th/nvim-cmp',
			'williamboman/mason-lspconfig.nvim',
			'williamboman/mason.nvim',
			{ 'b0o/SchemaStore.nvim', lazy = true, version = false }, -- For JSON and YAML
		},
		lazy = true,
		event = { 'BufReadPre', 'FileType' },
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
				['jsonls'] = function()
					lspconfig.jsonls.setup({
						capabilities = capabilities,
						settings = {
							json = {
								format = {
									enable = true,
								},
								validate = { enable = true },
							},
						},
						on_new_config = function(new_config)
							new_config.settings.json.schemas = new_config.settings.json.schemas or {}
							vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
						end,
					})
				end,
				['yamlls'] = function()
					lspconfig.yamlls.setup({
						capabilities = capabilities,
						settings = {
							yaml = {
								format = {
									enable = true,
								},
								validate = { enable = true },
								schemas = require('schemastore').yaml.schemas()
							},
						},
						on_new_config = function(new_config)
							new_config.settings.json.schemas = new_config.settings.json.schemas or {}
							vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
						end,
					})
				end,
			})
		end,
	},
}
