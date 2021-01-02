set ignorecase smartcase incsearch
set hlsearch
set number
set relativenumber
set autoindent cindent shiftwidth=4
set expandtab tabstop=4
set scrolloff=2
set syntax=cpp
set nobackup
set nowritebackup
set noswapfile
set nocompatible
set hidden
set showmode
set autochdir
set mouse=a
set cursorline
set clipboard=unnamedplus

call plug#begin()
    Plug 'ervandew/supertab'
    Plug 'morhetz/gruvbox'
    Plug 'kien/rainbow_parentheses.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'airblade/vim-gitgutter'
call plug#end()

set background=dark
let g:gruvbox_contrast_light="hard"
let g:gruvbox_italic=1
let g:gruvbox_invert_signs=0
let g:gruvbox_improved_strings=0
let g:gruvbox_improved_warnings=1
let g:gruvbox_undercurl=1
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

map <F5> :noh<CR>

nnoremap <C-j> 10j
nnoremap <C-k> 10k
