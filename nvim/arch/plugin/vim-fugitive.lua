local function blame_toggle()
    return vim.bo.filetype == 'fugitiveblame' and vim.cmd('close<CR>') or vim.cmd('Git blame<CR>')
end

vim.keymap.set('n', '<leader>gb', blame_toggle)
