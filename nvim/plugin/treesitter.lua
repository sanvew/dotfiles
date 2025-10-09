local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

treesitter.setup({
    ensure_installed = { 'lua', 'vim', 'markdown' },
    auto_install = true,
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    }
})
