local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
    return
end

local function keyboard_layout()
    return vim.o.iminsert == 0 and 'en' or 'ru'
end

lualine.setup({
    options = {
        icons_enabled = true,
        theme = 'gruvbox'
    },
    sections = {
        lualine_x = { 'encoding', 'fileformat', 'filetype', keyboard_layout }
    }
})

