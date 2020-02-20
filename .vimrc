set tabstop=4
set softtabstop=4
set autoindent
set expandtab
set wildmenu
syntax on
set number
" dont expnadtab in makefiles
autocmd FileType make setlocal noexpandtab
colorscheme badwolf
set noswapfile

" remove trailing whitespace
let blacklist = ['markdown']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :%s/\s\+$//e

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

