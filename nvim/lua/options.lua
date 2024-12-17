-- basic
vim.opt.encoding = 'utf-8'
vim.opt.number = true
vim.opt.colorcolumn = '120'
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.linebreak = true

-- tabs
local tab_size = 4
vim.opt.tabstop = tab_size
vim.opt.shiftwidth = tab_size
vim.opt.expandtab = true -- inserting space whenever tab pressed

-- search
vim.opt.incsearch = true -- starts searching as soon as typing, without enter needed
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true -- case insensitive unless capitals used in search
vim.opt.path:append({'**'}) -- search recursively in working dir

-- show invisible chars
vim.opt.list = true
vim.opt.listchars:append({ tab = '|-', trail = '·', lead = '·'})

-- clipboard
vim.opt.clipboard:append({'unnamedplus'}) -- copy to system clipboard using xclip

-- spellchecking
vim.opt.spell = true
vim.opt.spelllang:append({'en_us' ,'ru_ru'})

-- im (input map)
vim.opt.keymap = 'russian-jcukenmac'
vim.opt.iminsert = 0 -- set en as a default language
vim.opt.imsearch = 0 -- set en as a default language

-- switch between relative (in normal mode) and absolute (insert mode) line numbering
vim.api.nvim_create_autocmd('InsertEnter', { command = 'set norelativenumber' })
vim.api.nvim_create_autocmd('InsertLeave', { command = 'set relativenumber' })
