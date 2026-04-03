vim.g.mapleader = ','

vim.keymap.set('n', '<leader>t', ':tabnew<CR>', { silent = true, desc = 'Quick new tab' })

vim.keymap.set('i', '<C-l>', '<C-^>', { desc = 'Switch language' })

-- disabling arrows in almost all modes
vim.keymap.set({'i', 'n', 'v'}, '<Down>', '<Nop>')
vim.keymap.set({'i', 'n', 'v'}, '<Up>', '<Nop>')
vim.keymap.set({'i', 'n', 'v'}, '<Left>', '<Nop>')
vim.keymap.set({'i', 'n', 'v'}, '<Right>', '<Nop>')
