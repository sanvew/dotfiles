local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
    return
end

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i' }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i' }),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i' }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i' }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<C-c>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
})

local autopairs_status_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
if not autopairs_status_ok then
    return
end

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
