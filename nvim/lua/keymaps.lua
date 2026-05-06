-- Nvim
-- Save file with Ctrl + w
vim.keymap.set('n', '<c-w>', ':w<CR>')

-- Splits
vim.keymap.set('n', '<c-v>', ':vsplit<CR>') -- Vertical split
vim.keymap.set('n', '<c-h>', ':split<CR>')  -- Horizontal split
vim.keymap.set('n', '<c-t>', ':botright 10split term://bash<CR>i') -- Small terminal

-- Navigate between splits with Ctrl + Arrows
vim.keymap.set('n', '<C-Left>', '<C-w>h')
vim.keymap.set('n', '<C-Down>', '<C-w>j')
vim.keymap.set('n', '<C-Up>', '<C-w>k')
vim.keymap.set('n', '<C-Right>', '<C-w>l')

-- Terminal navigation
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<C-Left>', [[<C-\><C-n><C-w>h]])
vim.keymap.set('t', '<C-Down>', [[<C-\><C-n><C-w>j]])
vim.keymap.set('t', '<C-Up>', [[<C-\><C-n><C-w>k]])
vim.keymap.set('t', '<C-Right>', [[<C-\><C-n><C-w>l]])

-- Tree
vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
vim.keymap.set('n', '<c-m>', ':NvimTreeFocus<CR>')

-- Telescope
local status_ok, telescope = pcall(require, 'telescope.builtin')
if status_ok then
  -- Open file finder directly with Ctrl + l
  vim.keymap.set('n', '<c-l>', telescope.find_files)
end
