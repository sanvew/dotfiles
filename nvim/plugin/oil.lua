local status_ok, oil = pcall(require, 'oil')
if not status_ok then
    return
end

oil.setup({
    default_file_explorer = true,
    columns = {
        'icon'
    }
})

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
