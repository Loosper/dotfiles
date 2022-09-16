" install Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" install them with :PluginInstall or +PluginInstall +qall on the cmd line
call vundle#begin()
    Plugin 'preservim/nerdtree'
    " this needs a manual installation:
    " cd ~/.vim/bundle/YouCompleteMe
    " python3 install.py --all
    Plugin 'ycm-core/YouCompleteMe'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'tpope/vim-commentary'       " TODO: vim help 30.6 has some of this?
    Plugin 'airblade/vim-rooter'
    Plugin 'matze/vim-move'             " allows to move horizontally
    Plugin 'azabiong/vim-highlighter'
    Plugin 'Raimondi/delimitMate'       " auto adds/removes closing brackets
call vundle#end()
" TODO: https://github.com/vim-airline/vim-airline " a better (?) statusline
" Plugin 'nathanaelkane/vim-indent-guides' " highlights indentation. I don't
" think I need it

" Lots of configs stolen from: https://www.youtube.com/watch?v=0aEv1Nj0IPg&list=PLwJS-G75vM7kFO-yUkyNphxSIdbi_1NKX
" jump to line with vim launch:
" vim <file> +<line>
" gqip to wrap a comment
" :set var?     queries the variable value
" show invisible characters
" set list
" highlight typos
" set spell
" in insert:
" C-W delete prev word
" C-U delete until start of line
" :retab to change whitespace settings to whatever is currently set
" TODO: learn to use marks (can mark and eg. delete up to it)
" gg=G   reindent the whole file
    " C-D in insert mode deletes one indent level


" --- menu settings ---
syntax on
set shell=/bin/bash         " other shells behave quirky, set in case in use
set wildmenu                " autocomplete in menu
set noswapfile
set number                  " show line numbers
set showcmd                 " show size of visual select
set incsearch               " incremental (live) search
set hlsearch                " highlight searches
set shortmess-=S            " this shows search match counter
set ignorecase smartcase    " case insensitive when all lowercase
set wildignorecase          " case insensitive file completion
" --- status line ---
set laststatus=2            " show a status line
set statusline=%F%m%r%h%w[%{&ff}]%y%=%L\ lines\ (%p%%)\ [%l,%v]
"              | | | | |  |      | | |             |     |  |
"              | | | | |  |      | | |             |     |  + current column
"              | | | | |  |      | | |             |     +-- current line
"              | | | | |  |      | | |             +-- current % into file
"              | | | | |  |      | | +-- number of lines
"              | | | | |  |      | +-- justify left
"              | | | | |  |      +-- current syntax in square brackets
"              | | | | |  +-- current fileformat
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- modified flag in square brackets
"              +-- full path to file in the buffer

" --- editor ---
set showmatch               " show matching brackets
set foldmethod=syntax       " enable folding by syntax rules
set iskeyword+=_            " which characters are considered a word (and won't split it)
set whichwrap=b,s,h,l,<,>,~,[,]	" make all direction keys wrap between lines
set colorcolumn=80          " vertical ruler for max line width
set spelllang=en_gb         " dictionary ":set spell" will use
highlight ColorColumn ctermbg=238 " make it grey

" TODO: help format-comments, fo-table, gq, formatting
" for textwidth stuff
" TODO: re-wrap comments correctly.
" TODO: https://stackoverflow.com/questions/33291130/how-can-i-configure-vim-for-2-different-languages
" TODO: maybe this as well https://vim.fandom.com/wiki/Filetype.vim
" TODO: comments, autocomplete
" NOTE: use ctags-universal --c-kinds=+px (consider lzL too)
" the normal ctags is crippled for assembly
" search for tags until you hit the directory
" doesn't work the way you think it does
" set tags=tags,./tags
" C-] is bound to :tag by gC-] is :tjump
" :tag jumps to the first tag even if multiple share names
" :tjump always lists multple options. Use that to avoid confusion
" nnoremap <c-]> g<c-]>
" vnoremap <c-]> g<c-]>

" TODO: reads project vimrcs (if started in project root which the plugin
" should do?)
"
" TODO: "set path=+=**" ?
" gf can jump to filename and this would be the search path for it. Useful for
" includes?
" set exrc
" TODO: have grep commands whenever tags dont work

set smartindent  " fallback in case no filetype specific indentation
filetype plugin indent on  " enable filetype specific indentation
" with this cindent/smartindent should be unnecessary

set expandtab " most languages like it this way
" but don't touch the tabstop, as this will mess with the tab character and we
" want it consistent between languages
" set all 3 to the same, as it doesn't make sense to me otherwise
" can be different but confuses me why one would do that
set shiftwidth=4
set softtabstop=4
" anything C related uses the kernel style
function Clike_indent()
    setlocal noexpandtab
    setlocal shiftwidth=8
    setlocal softtabstop=8
endfunction
autocmd FileType c,cpp,asm,gitsendemail,make,gitcommit call Clike_indent()

autocmd FileType gitsendemail,gitcommit setlocal textwidth=75 " TODO: linux
" prescribes the first line to be no more than 75 chars. How to handle?

" remove trailing whitespace
let blacklist = ['markdown', 'diff', 'gitcommit']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :%s/\s\+$//e
" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

colorscheme badwolf

" unfold everything on file read
autocmd BufRead * normal zR

" --- key bindings ---
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
" Cycle through relativenumber + number/ norelativenumber + number.
function Cycle_numbering(direction) abort
    if !exists('+relativenumber') " just toggle
        set number!<CR>
        return
    endif
    " 01 is there in case I manually set the editor to an inconsistenst state
    let fwd = {
            \ '00': 'set   number   | set norelativenumber',
            \ '01': 'set   number   | set   relativenumber',
            \ '10': 'set   number   | set   relativenumber',
            \ '11': 'set nonumber   | set norelativenumber' }
    let bwd = {
            \ '00': 'set   number   | set   relativenumber',
            \ '01': 'set nonumber   | set norelativenumber',
            \ '10': 'set nonumber   | set norelativenumber',
            \ '11': 'set   number   | set norelativenumber' }
    if a:direction == 'fwd'
        execute l:fwd[&number . &relativenumber]
    else
        execute l:bwd[&number . &relativenumber]
    endif
endfunction
nnoremap <silent> <Leader>r :call Cycle_numbering('fwd')<CR>
nnoremap <silent> <Leader>R :call Cycle_numbering('bwd')<CR>

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

" move a line up/down
" TODO: remove indent after?
" nnoremap <A-j> :m .+1<CR>==
" nnoremap <A-k> :m .-2<CR>==
" inoremap <A-j> <Esc>:m .+1<CR>==gi
" inoremap <A-k> <Esc>:m .-2<CR>==gi
" vnoremap <A-j> :m '>+1<CR>gv=gv
" vnoremap <A-k> :m '<-2<CR>gv=gv
" cmd: move, address: here +1
" nnoremap <A-j> :m .+1<CR>
" nnoremap <A-k> :m .-2<CR>
" inoremap <A-j> <Esc>:m .+1<CR>i
" inoremap <A-k> <Esc>:m .-2<CR>i
" vnoremap <A-j> :m '>+1<CR>gv
" vnoremap <A-k> :m '<-2<CR>gv

" make switching tabs faster
" C-PageUp doesn't quite work (might be an <A-j> type of situation)
" and C-M is the same as Enter
" TODO:
nnoremap <A-m> gt
nnoremap <A-n> gT
" move tabs
nnoremap <Leader>t :tabmove +1<CR>
nnoremap <Leader>T :tabmove -1<CR>
nnoremap <Leader>e :tabe


" if exists("&undodir")
" 	set undodir=~/.vim/undo
" endif


" TODO: errors out
" if NERDtree is open, mirror it in every new tab
" autocmd BufWinEnter * NERDTreeMirror

" TODO: semantic code completion for c (it seems to be project specific, check
" the github readme)
" youCompleteMeSettings
let g:ycm_show_diagnostics_ui = 0
"consider if you encounter lots of DOS files (\r\n fileendings)
" set ff=dos

let g:rooter_patterns = ['.git', 'Makefile']

" vim-commentary has a
" setlocal commentstring=//\ %s
" in .vim/bundle/Vundle.vim/ftplugin/c.vim
" to change comments to single line by default.
" TODO: fix this ^

" gitgutter settings
set updatetime=100
highlight! link SignColumn LineNr

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" vim-highligher settings
" TODO: more advances features when I'm used to these
" basic keys
let HiSet    = '<Leader>/'     " select for highlight
let HiErase  = '<Leader>d'     " deselect
let HiClear  = '<Leader><C-L>' " clear all highlights
" jump keys
nnoremap <Leader>n :Hi><CR>    " jump to next occurence
nnoremap <Leader>N :Hi<<CR>    "         prev
nnoremap <Leader>> :Hi}<CR>    " jump to next highlight
nnoremap <Leader>< :Hi{<CR>    "         prev

" delimitMate settings
" TODO
