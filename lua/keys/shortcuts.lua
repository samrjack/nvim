-- These maps are for shortcuts that I use often enough to define as their own key cord.

-- Take the line above the curent line and append it to the end
-- of the current line.
--
-- ex:
-- hello
-- world|
-- |
-- v
-- world| hello
vim.keymap.set('n', '<C-j>', 'kddpkJ', { desc = 'append previous line'})


