call plug#begin('~/.local/share/nvim/plugged')

" formating
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'

" autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
if has("python3")
    silent exe "!pip3 list | grep pynvim || pip3 install --user pynvim"
endif
Plug 'Shougo/deoplete-clangx' " C/C++
Plug 'deoplete-plugins/deoplete-jedi' " Python
if has("python3")
    silent exe "!pip3 list | grep jedi || pip3 install --user jedi"
endif
Plug 'mattn/emmet-vim'

" syntax highlighting and checking
Plug 'sheerun/vim-polyglot'
Plug 'vim-syntastic/syntastic'

" ui
Plug 'luochen1990/rainbow'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'itchyny/lightline.vim'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'

" misc
Plug 'christoomey/vim-tmux-navigator'

" colorschemes
Plug 'morhetz/gruvbox'

call plug#end()

"===========================================
" settings
"
" basic preferences
syntax on
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
filetype plugin on
set number
set cursorline
set noshowmode
set incsearch
colorscheme gruvbox
set path+=** " search recursively in working dir

" spellchecking
set spell spelllang=en_us,ru_ru

" russian keyboard layout
" https://www.linux.org.ru/forum/development/14418127
set keymap=russian-jcukenmac
set iminsert=0
set imsearch=0

" tabs
set tabstop=4 shiftwidth=4 expandtab smarttab
set wrap! linebreak nolist
autocmd FileType javascript,html,htmldjango,arduino setlocal shiftwidth=2 softtabstop=2 expandtab

" enable vim-rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
\ 'separately': {
\   'htmldjango': 0,
\ }
\}

" NERDCommenter setting
" add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Lightline.vim settings
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \  'right': [ [ 'lineinfo' ],
      \             [ 'percent' ],
      \             [ 'fileformat', 'fileencoding', 'filetype', 'kb_layout' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'kb_layout': 'LightLineKeymap'
      \ },
      \ }

" https://www.linux.org.ru/forum/general/13365977?cid=13366548
function! LightLineKeymap()
    return &iminsert == 0 ? 'en' : 'ru'
endfunction

" switch between rel (normal mode) and abs (insert mode) line numbering
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber 

" preventing continuation of comments ro the next line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" support python virtual environments
let g:python3_host_prog = system("which python3 | tr -d '\n'")

" show invisible chars
set list
set listchars=tab:\|\ ,trail:~

" folding
set foldmethod=indent
set nofoldenable " no folds when open file
set foldnestmax=10

" deoplete preferences
let g:deoplete#enable_at_startup = 1
" https://github.com/Shougo/deoplete.nvim/issues/115#issuecomment-170237485
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" linters setup
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = ['eslint', 'w3']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_html_eslint_exec = 'eslint_d'

"===========================================
" key mappping
"
let mapleader=","
set timeout timeoutlen=1500

nmap <silent> <C-n> :NERDTreeToggle<CR>

vmap // <plug>NERDCommenterToggle
nmap // <plug>NERDCommenterToggle

" Snippets trigger configuration
let g:UltiSnipsExpandTrigger="<tab>"

" quick new tab
nmap <silent> ,t :tabnew<CR>

" switch language using Ctrl-l
inoremap <C-l> <C-^>

" disabling arrows in almost all modes
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>

nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>
