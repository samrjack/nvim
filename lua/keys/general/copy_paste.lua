
vim.keymap.set('v', '<leader>p', '"_dP', {desc = 'paste and perserve register'})

vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', {desc = 'Copy to system clipboard'})
vim.keymap.set('n', '<leader>Y', '"+Y', {desc = 'Copy line to system clipboard'})
