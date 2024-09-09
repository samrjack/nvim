local function setup_csvview_keys(buf)
	vim.keymap.set('n', '<leader>ct', require('csvview').toggle,
		{ buffer = buf, desc = 'Enable table view' })
end

local id = vim.api.nvim_create_augroup('csvview_loading', {})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
	group = id,
	desc = 'Add key shortcuts for csv files',
	pattern = { '*.csv' },
	callback = function(ev)
		setup_csvview_keys(ev.buf)
		require('csvview').enable()
	end,
})
