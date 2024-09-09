local function toggle_manual()
	local options = require('neocodeium.options').options
	options.manual = not options.manual
	print("Manual AI mode: " .. tostring(options.manual))
end

return {
	'monkoose/neocodeium',
	lazy = true,
	opts = {
		enabled = false,
	},
	keys = {
		{
			'<Leader>aa',
			function()
				require('neocodeium.commands').auth()
				require('neocodeium.commands').enable()
			end,
			desc = 'Ai login'
		},
		{ '<Leader>ac',  function() require('neocodeium.commands').chat() end,           desc = 'External Chat' },
		{ '<Leader>at',  function() require('neocodeium.commands').toggle() end,         desc = 'Toggle' },
		{ '<Leader>ta',  function() require('neocodeium.commands').toggle() end,         desc = 'Toggle Ai' },
		{ '<Leader>tbe', function() require('neocodeium.commands').enable_buffer() end,  desc = 'enable buffer' },
		{ '<Leader>tbd', function() require('neocodeium.commands').disable_buffer() end, desc = 'disable buffer' },
		{ '<Leader>ar',  function() require('neocodeium.commands').restart() end,        desc = 'Restart' },
		{ '<Leader>ar',  function() require('neocodeium.commands').open_log() end,       desc = 'Log' },
		{ '<leader>am',  toggle_manual,                                                  desc = 'Toggle manual' },
		{ '<C-y><C-y>',  function() require('neocodeium').accept() end,                  desc = 'Accept',        mode = { 'i' } },
		{ '<C-y><C-c>',  function() require('neocodeium').cancel() end,                  desc = 'Cancel',        mode = { 'i' } },
		{ '<C-y><C-n>',  function() require('neocodeium').next() end,                    desc = 'Next',          mode = { 'i' } },
		{ '<C-y><C-p>',  function() require('neocodeium').prev() end,                    desc = 'Previous',      mode = { 'i' } },
		{ '<C-y><C-w>',  function() require('neocodeium').accept_word() end,             desc = 'Accept word',   mode = { 'i' } },
		{ '<C-y><C-l>',  function() require('neocodeium').accept_line() end,             desc = 'Accept line',   mode = { 'i' } },
		{ '<C-y><C-s>',  function() require('neocodeium').cycle_or_complete() end,       desc = 'Suggest',       mode = { 'i' } },
		{ '<C-y>s',      function() require('neocodeium').cycle_or_complete(-1) end,     desc = 'Suggest prev',  mode = { 'i' } },
	},
}
