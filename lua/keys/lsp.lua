-- All lsp bindings for working in most code bases

local function setup_lsp_keymaps(buf)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = buf, desc = 'LSP Code Action' })
	vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { buffer = buf, desc = 'Format code' })
	vim.keymap.set('n', '=', vim.lsp.buf.format, { buffer = buf, desc = 'Format code' })
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = buf, desc = 'Goto definition' })
	vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, { buffer = buf, desc = 'Goto definition' })
	vim.keymap.set('n', '<leader>cD', vim.lsp.buf.references, { buffer = buf, desc = 'Goto references' })
	vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation, { buffer = buf, desc = 'Goto implementation' })
	vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = buf, desc = 'Rename' })
	vim.keymap.set('n', '<leader>ct', vim.lsp.buf.type_definition, { buffer = buf, desc = 'Goto type definition' })
	vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, { buffer = buf, desc = 'Hover' })
	vim.keymap.set('n', '<leader>cs', vim.lsp.buf.signature_help, { buffer = buf, desc = 'Signature help' })

	-- formatting on save
	vim.keymap.set('n', '<leader>cLf',
		function() vim.b[buf].lsp_format_on_save = (not vim.b[buf].lsp_format_on_save) end,
		{ buffer = buf, desc = 'Toggle format on save' })
	vim.keymap.set('n', '<leader>cF',
		function() vim.b[buf].lsp_format_on_save = (not vim.b[buf].lsp_format_on_save) end,
		{ buffer = buf, desc = 'Toggle format on save' })
end

local function inlay_hints(buf, lsp_client)
	if lsp_client ~= {} and lsp_client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = buf })
		vim.keymap.set('n', '<leader>cLi', function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
		end, { buffer = buf, desc = 'Toggle inlay hints' })
	end
end


local lsp_augroup = vim.api.nvim_create_augroup('lsp_commands', {})

vim.api.nvim_create_autocmd('LspAttach', {
	group = lsp_augroup,
	desc = 'on lsp attach',
	callback = function(event)
		local buf = event.buf
		vim.b[buf].is_in_lsp = true
		vim.b[buf].lsp_format_on_save = true

		local id = vim.tbl_get(event, 'data', 'client_id')
		local lsp_client = {}
		if id then
			lsp_client = vim.lsp.get_client_by_id(id) or {}
		end

		setup_lsp_keymaps(buf)
		inlay_hints(buf, lsp_client)
	end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
	group = lsp_augroup,
	desc = 'Format files with LSP (when enabled)',
	callback = function(event)
		print("on save")
		local buf = event.buf
		if vim.b[buf].is_in_lsp and vim.b[buf].lsp_format_on_save then
			vim.lsp.buf.format({ bufnr = buf })
		end
	end,
})
