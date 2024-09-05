
local wk = require("which-key")
wk.add({
	{'<leader>f', group = 'file'},
	{'<leader>t', group = 'toggle'},
	{'<leader>c', group = 'code'},
	{'<leader>g', group = 'git'},
	{'<leader>w', group = 'windows', proxy = "<C-w>"},
	{'<leader>b', group = 'buffers', expand = function() return require ("which-key.extras").expand.buf() end},
})
