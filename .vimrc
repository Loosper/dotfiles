" install Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
    Plugin 'preservim/nerdtree'
    Plugin 'ycm-core/YouCompleteMe'
call vundle#end()

filetype plugin indent on

" cos I use zsh and it likes to break stuff
set shell=/bin/bash

" jump to line with vim launch:
" vim <file> +<line>
" gqip to wrap a comment

" --- menu settings ---
syntax on
set wildmenu      " autocomplete in menu
set noswapfile
set number        " show line numbers
set ruler         " show cursor position
set showcmd       " show size of visual select
set incsearch     " incremental (live) search
set hlsearch      " highlight searches
set ignorecase smartcase    " case insensitive when all lowercase
set laststatus=2  " show a status line
set foldmethod=syntax " enable folding by syntax rules
" unfold everything on file read
autocmd BufRead * normal zR

set showmatch     " show matching brackets
set iskeyword+=_,$,@,%,#,;	" none of these are word dividers so make them be
set whichwrap=b,s,h,l,<,>,~,[,]	" make all direction keys wrap between lines

" --- whitespace settings ---
" keep shiftwidth and tabstop equal. Otherwise >> command may produce unexpected results
" softtabstop also doesn't make sense to me to be different
" if you want insert mode, command mode and >> command to behave differently you can mix and match these 3
set tabstop=4
set shiftwidth=4
set softtabstop=4

" set autoindent
set smartindent
set expandtab
" :retab to change whitespace settings to whatever is currently set

" show invisible characters
" set list

" TODO: re-wrap comments correctly.
" TODO: https://stackoverflow.com/questions/33291130/how-can-i-configure-vim-for-2-different-languages
" TODO: maybe this as well https://vim.fandom.com/wiki/Filetype.vim
" keep language specific settings in separate files
" dont expnadtab in makefiles
" ok this needs doing properly. I.E. do only for linux
" autocmd FileType c,asm,gitsendemail,make,gitcommit setlocal noexpandtab
" autocmd FileType c,asm,gitsendemail,make,gitcommit setlocal tabstop=8
" autocmd FileType c,asm,gitsendemail,make,gitcommit setlocal shiftwidth=8
" autocmd FileType c,asm,gitsendemail,make,gitcommit setlocal softtabstop=8
" autocmd FileType c,asm,gitsendemail,make,gitcommit setlocal colorcolumn=80
" autocmd FileType gitsendemail,gitcommit setlocal textwidth=75
" remove trailing whitespace
let blacklist = ['markdown', 'diff']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :%s/\s\+$//e
" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

colorscheme badwolf


" make pane switching easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" set the <Leader> key
let mapleader = " "

" augment o/O so they have an option to not enter edit mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" TODO: comments, autocomplete


" https://www.youtube.com/watch?v=0aEv1Nj0IPg&list=PLwJS-G75vM7kFO-yUkyNphxSIdbi_1NKX&index=12&t=0s
" Cycle through relativenumber + number/ norelativenumber + number.
function Cycle_numbering() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set   number   | set norelativenumber',
          \ '01': 'set   number   | set   relativenumber',
          \ '10': 'set   number   | set   relativenumber',
          \ '11': 'set nonumber   | set norelativenumber' }[&number . &relativenumber]
  else
    " No relative numbering, just toggle numbers on and off.
    set number!<CR>
  endif
endfunction
nnoremap <silent> <Leader>r :call Cycle_numbering()<CR>
" TODO: have this with <Leader>R

" this is so that the <A-j> keys work in gnome terminal which is not configurable in this regard
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
" NOTE: increase this if you're not getting the alt keys
set ttimeout ttimeoutlen=25

" move tabs
nnoremap <Leader>t :tabmove +1<CR>
nnoremap <Leader>T :tabmove -1<CR>
nnoremap <Leader>e :tabe

" move a line up/down
" NOTE: these are not ^]j (3 cahrs) but rather the single char you get from C-v A-j
" they are also broken. Esc + j does the same (unintended)
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" Done so that escape sequences above aren't triggered with an actual escape key

" map <C-PageUp> :tabnext<CR>
" map <C-PageDown> gT

" TODO: these are causing enter to swtich tabs?????????????
" make switching tabs faster
" C-PageUp doesn't quite work (might be an <A-j> type of situation)
nnoremap <C-m> gt
nnoremap <C-n> gT

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%l,%v]
"              | | | | |  |   |      |  |     |  |
"              | | | | |  |   |      |  |     |  + current column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- modified flag in square brackets
"              +-- full path to file in the buffer

" if exists("&undodir")
" 	set undodir=~/.vim/undo
" endif

" :set spell spelllang=en_us

" if NERDtree is open, mirror it in every new tab
autocmd BufWinEnter * NERDTreeMirror

" youCompleteMeSettings
let g:ycm_show_diagnostics_ui = 0
"consider if you encounter lots of DOS files (\r\n fileendings)
" set ff=dos
