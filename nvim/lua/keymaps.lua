-- Nvim
vim.keymap.set('n', '<c-w>', ':w<CR>')

-- Tree
vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
vim.keymap.set('n', '<c-m>', ':NvimTreeFocus<CR>')

-- Telescope
local telescope = require('telescope.builtin')
local telescope_leader = '<c-l>'
vim.keymap.set('n', telescope_leader .. 'f', telescope.find_files)
vim.keymap.set('n', telescope_leader .. 'c', telescope.command_history)
vim.keymap.set('n', telescope_leader .. 'h', telescope.search_history)
vim.keymap.set('n', telescope_leader .. 'k', telescope.keymaps)
vim.keymap.set('n', telescope_leader .. 'o', telescope.oldfiles)
