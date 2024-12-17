local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
    return
end

treesitter.setup({
    ensure_installed = { 'lua', 'markdown', 'vim' },
    auto_install = true,
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    }
})
