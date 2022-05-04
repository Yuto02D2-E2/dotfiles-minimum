call plug#begin("~/vimfiles/plugged")
" ref: https://github.com/junegunn/vim-plug#unix
Plug 'itchyny/lightline.vim'
" ref: https://github.com/itchyny/lightline.vim#vim-plug
call plug#end()

set fileformats=unix,dos,mac

set history=9999
set backspace=indent,eol,start " enable backspace "

" view "
set title
set number
set ruler
set nolist " hide tab/newlines "
set wildmenu
set wildmode=list:longest " command completion "
set showcmd " show cmd(not yet exec) "
set showmode
set showmatch
set laststatus=2 " always show status line "
set display=lastline " display line without omit"
set visualbell t_vb=

" color "
set background=light
syntax enable
hi Comment ctermfg=gray
if !has("gui_running")
    set t_Co=256
endif

" other "
set autoread " auto reload file "
set hidden
set fenc=utf-8
set encoding=utf-8
set ambiwidth=double " for wide-char setting? "
set clipboard=unnamed,autoselect
set mouse=a
set autowrite
set virtualedit=onemore
set whichwrap=h,l,b,s,<,>,[,],~
set splitbelow
set splitright

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set smarttab

" search "
set hlsearch
set ignorecase
set smartcase
set incsearch
set wrapscan

" key mapping "
" noremap := allmode/NOrecursion/REMAP
" inoremap := Insertmode/NOrecursion/REMAP
" nnoremap := Normalmode/NOrecursion/REMAP
" silent: not display command
inoremap <silent> jj <Esc>
nnoremap <Esc><Esc> :nohlsearch<Enter><Esc>
nnoremap n nzz
nnoremap N Nzz
" using leader key
let mapleader = "\<Space>"
nnoremap <Leader>h 0
nnoremap <Leader>l $
nnoremap <Leader>a ggVG
nnoremap <Leader>i ggVG=<Esc>
nnoremap <Leader>s :%s/
nnoremap <Leader>w :w<Enter><Esc>
nnoremap <Leader>q :q<Enter><Esc>
nnoremap <Leader>r :source ~/.vimrc
nnoremap <Leader><Enter> o<Esc>
