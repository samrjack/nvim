return {
	{
		'hat0uma/csvview.nvim',
		lazy = true,
		config = function()
			local opts = {
				view = {
					display_mode = "border",
				},
			}
			require('csvview').setup(opts)
			require('configurations.csvview')
		end,
		ft = {
			'csv',
		},
		-- keys set up in configurations file
	},
	{
		'cameron-wags/rainbow_csv.nvim',
		lazy = true,
		ft = {
			'csv',
			'tsv',
			'csv_semicolon',
			'csv_whitespace',
			'csv_pipe',
			'rfc_csv',
			'rfc_semicolon',
		},
	},
}
