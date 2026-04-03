local status_ok, tabline = pcall(require, 'tabline')
if not status_ok then
    return
end

tabline.setup({
    show_index = true,
    show_modify = true,
    modify_indicator = '+',
})
