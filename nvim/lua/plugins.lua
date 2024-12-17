local vim_plug_install_path = vim.fn.stdpath("data") .. "/site/autoload/plug.vim"
if vim.fn.empty(vim.fn.glob(vim_plug_install_path)) > 0 then
    VIM_PLUG_BOOTSTRAP = vim.fn.system({
        "curl",
        "-fLo",
        vim_plug_install_path,
        "--create-dirs",
        "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
    })
    print("Installing vim-plug close and reopen Neovim...")
end

local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- basic plugins
Plug('nvim-lua/plenary.nvim') -- lua util functions
Plug('tpope/vim-fugitive') -- git preimer plugin
Plug('lewis6991/gitsigns.nvim') -- git hunks
Plug('stevearc/oil.nvim') -- buffer like file explorer
Plug('nvim-tree/nvim-web-devicons') -- file icons powered by nerd-fonts
Plug('crispgm/nvim-tabline') -- minimal tabline
Plug('windwp/nvim-autopairs')
Plug('numToStr/Comment.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('christoomey/vim-tmux-navigator')

-- lsp
Plug('williamboman/mason.nvim') -- lsp related package manager
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason-lspconfig.nvim')

-- completion, linting, formatting
Plug('hrsh7th/nvim-cmp') -- completion core package
Plug('hrsh7th/cmp-nvim-lsp') -- lsp completion
Plug('nvimtools/none-ls.nvim') -- linting and formatting lsp wrapper
Plug('jay-babu/mason-null-ls.nvim')

-- snippets
Plug('L3MON4D3/LuaSnip') -- snippet engine 
Plug('saadparwaiz1/cmp_luasnip')

-- treesitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
--
-- colorschemes
Plug('ellisonleao/gruvbox.nvim')

vim.call('plug#end')
