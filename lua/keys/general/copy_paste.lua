vim.keymap.set('v', '<leader>p', '"_dP', { desc = 'Paste perserve registers' })
vim.keymap.set('n', '<leader>p', '"+P', { desc = 'Paste from clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<C-c>', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Copy line to clipboard' })
