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
set timeoutlen=1000 ttimeoutlen=0     " Remove timeout when hitting escape
set laststatus=2  " show a status line
set foldmethod=syntax " enable folding by syntax rules
" unfold everything on file read
autocmd BufRead * normal zR

" --- whitespace settings ---
set tabstop=4
set softtabstop=4
set autoindent
set expandtab
" dont expnadtab in makefiles
autocmd FileType make setlocal noexpandtab
" remove trailing whitespace
let blacklist = ['markdown']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :%s/\s\+$//e
" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

colorscheme badwolf

" install packages:
" https://github.com/preservim/nerdtree

" set the <Leader> key
let mapleader = " "

" make pane switching easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" augment o/O so they have an option to not enter edit mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" TODO: comments, autocomplete


" https://www.youtube.com/watch?v=0aEv1Nj0IPg&list=PLwJS-G75vM7kFO-yUkyNphxSIdbi_1NKX&index=12&t=0s
" Cycle through relativenumber + number/ norelativenumber + number.
function Cycle_numbering() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set norelativenumber | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set relativenumber   | set number',
          \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
  else
    " No relative numbering, just toggle numbers on and off.
    set number!<CR>
  endif
endfunction

nnoremap <silent> <Leader>r :call Cycle_numbering()<CR>
" set paste binding


" move a line up/down
" NOTE: these are not ^]j (3 cahrs) but rather the single char you get from C-v A-j
nnoremap j :m .+1<CR>==
nnoremap k :m .-2<CR>==
inoremap j <Esc>:m .+1<CR>==gi
inoremap k <Esc>:m .-2<CR>==gi
vnoremap j :m '>+1<CR>gv=gv
vnoremap k :m '<-2<CR>gv=gv

