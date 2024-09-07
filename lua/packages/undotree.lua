return {
	'mbbill/undotree',
	lazy = true,
	config = function()
		vim.g.undotree_UndoDir = vim.opt.undodir:get()
	end,
	keys = {
		{'<leader>u', vim.cmd.UndotreeToggle, desc = 'undo tree'},
	},
}
