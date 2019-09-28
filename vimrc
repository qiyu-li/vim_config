set nocompatible              " be iMproved, required
filetype off                  " required

 set rtp+=~/.vim/bundle/Vundle.vim

 call vundle#begin()

 Plugin 'VundleVim/Vundle.vim'
 Plugin 'scrooloose/nerdtree'
 Plugin 'itchyny/lightline.vim'
 Plugin 'itchyny/vim-gitbranch'
 Plugin 'airblade/vim-gitgutter'
 Plugin 'lifepillar/vim-solarized8'
 Plugin 'bfrg/vim-cpp-modern'
 Plugin 'ctrlpvim/ctrlp.vim'

 call vundle#end()            " required
 filetype plugin indent on    " required

autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

syntax enable
set background=dark
colorscheme solarized8_high
set backspace=indent,eol,start
:set incsearch
:set hlsearch
:set cursorline
:set visualbell
:set mouse=a
:set scrolljump=5
:set history=1000
:highlight Search     ctermfg=white      ctermbg=blue     cterm=NONE
:set autoindent
:set number
:set noshowmode
:set textwidth=130
set tags=./tags,tags;$HOME

nnoremap * *``
nnoremap * :keepjumps normal *``<cr>
:nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

if has("autocmd")
 au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
   \| exe "normal! g'\"" | endif
endif

set laststatus=2

fun! ShowFuncName()
 let lnum = line(".")
 let col = col(".")
 echohl ModeMsg
 echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
 echohl None
 call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun

map ? :call ShowFuncName() <CR>

function! Tab_Or_Complete()
 if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
   return "\<C-N>"
 else
   return "\<Tab>"
 endif
endfunction

:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

filetype plugin indent on
