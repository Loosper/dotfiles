" install Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" install them with :PluginInstall or +PluginInstall +qall on the cmd line
call vundle#begin()
    Plugin 'preservim/tagbar'           " tagbar: list of tags
    Plugin 'preservim/nerdtree'         " tagbar: directory tree
    Plugin 'Xuyuanp/nerdtree-git-plugin' " improv: show a little star if dirty
    Plugin 'tiagofumo/vim-nerdtree-syntax-highlight' " improv: colour match filetypes
    Plugin 'ctrlpvim/ctrlp.vim'         " cmd: fuzzy file search
    " this needs a manual installation:
    " cd ~/.vim/bundle/YouCompleteMe
    " python3 install.py --all
    Plugin 'ycm-core/YouCompleteMe'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'tpope/vim-commentary'       " op: toggle comments
    Plugin 'tpope/vim-surround'         " motion: surround
    Plugin 'tpope/vim-repeat'           " improv: makes . better with plugins
    Plugin 'matze/vim-move'             " action: move selection up/down/sideways
    Plugin 'azabiong/vim-highlighter'
    Plugin 'Raimondi/delimitMate'       " auto adds/removes closing brackets
    Plugin 'compnerd/arm64asm-vim'      " syntax: arm64 assembly
call vundle#end()
" TODO: https://github.com/vim-airline/vim-airline " a better (?) statusline
" Plugin 'nathanaelkane/vim-indent-guides' " highlights indentation. I don't
" think I need it

" Lots of configs stolen from: https://www.youtube.com/watch?v=0aEv1Nj0IPg&list=PLwJS-G75vM7kFO-yUkyNphxSIdbi_1NKX
" jump to line with vim launch:
" vim <file> +<line>
" gq<motion> - format. gq]/ will do until end of comment (ip - in paragraph)
" (TODO: doesn't work for bash like comments?)
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
"consider if you encounter lots of DOS files (\r\n fileendings)
" set ff=dos
" TODO: look at motions
" -- vim--commentary ---
"  gc<motion> to comment motion stuff.
"  if motion=c does current line

" TODO: no clue what's up with this. Shows jibberish icons
" probably requires a nerd font
" Plugin 'ryanoasis/vim-devicons'
" set encoding=UTF-8

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
set statusline=%f\ %m%r[%{&ff}]%y%=%L\ lines\ (%p%%)\ [%l,%v]
"              |   | |   |      | | |             |     |  |
"              |   | |   |      | | |             |     |  + current column
"              |   | |   |      | | |             |     +-- current line
"              |   | |   |      | | |             +-- current % into file
"              |   | |   |      | | +-- number of lines
"              |   | |   |      | +-- justify left
"              |   | |   |      +-- current syntax in square brackets
"              |   | |   +-- current fileformat
"              |   | +-- readonly flag in square brackets
"              |   +-- modified flag in square brackets
"              +-- relative path to file in the buffer
set showtabline=2           " keep the tab menu open at all times
" --- editor settings ---
set showmatch               " show matching brackets
set foldmethod=syntax       " enable folding by syntax rules
set iskeyword+=_            " which characters are considered a word (and won't split it)
set iskeyword-=#            " # isn't in most cases
set whichwrap=b,s,h,l,<,>,~,[,]	" make all direction keys wrap between lines
set textwidth=80            " the max width for text (but not code)
set formatoptions-=t        " don't wrap text (i.e code)
" sadly will probably not wrap .txt files but ah well
set colorcolumn=81          " vertical ruler for max line width (the char after line 80)
highlight ColorColumn ctermbg=238 " make it grey
set spelllang=en_gb         " dictionary ":set spell" will use

" NOTE: use ctags-universal --c-kinds=+px (consider lzL too)
" full command for tf-a: ctags-universal --c-kinds=+pxlzL --fields=+Krls --regex-asm="/^func ([a-z_0-9]*)$/\1/" -R .
" the normal ctags is crippled for assembly
" search for tags until you hit the directory
" doesn't work the way you think it does
" set tags=tags,./tags
" C-] is bound to :tag by gC-] is :tjump
" :tag jumps to the first tag even if multiple share names
" :tjump always lists multple options. Use that to avoid confusion
" nnoremap <c-]> g<c-]>
" vnoremap <c-]> g<c-]>

" TODO: "set path=+=**" ?
" gf can jump to filename and this would be the search path for it. Useful for
" includes?
" set exrc

" unfold everything on file read
autocmd BufRead * normal zR

" --- syntax ----
" anything C related uses the kernel style
function Clike_indent()
    setlocal noexpandtab
    setlocal shiftwidth=8
    setlocal softtabstop=8
endfunction

filetype plugin indent on  " enable filetype specific indentation
set smartindent  " fallback in case no filetype specific indentation
set expandtab " most languages like it this way
" but don't touch the tabstop, as this will mess with the tab character and we
" want it consistent between languages
" set all 3 to the same, as it doesn't make sense to me otherwise
" can be different but confuses me why one would do that
set shiftwidth=4
set softtabstop=4
autocmd FileType c,cpp,asm,gitsendemail,make,gitcommit call Clike_indent()
" these I'm not sure about but seem to use the same
autocmd FileType sh call Clike_indent()
" Linux says 72 to 75, TF-A wants no more than 72.
autocmd FileType gitsendemail,gitcommit setlocal textwidth=72
autocmd FileType gitsendemail,gitcommit setlocal spell

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" add "NOTE" as a keyword to (most) syntaxes
autocmd Syntax * syntax keyword Todo NOTE containedin=.*Comment

colorscheme badwolf
" --- key bindings ---
" set the <Leader> key
let mapleader = " "
" clear whitespace
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" make pane switching easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" augment o/O so they have an option to not enter edit mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>
" copy to (vim) clipboard. TODO: should go in global clipboard
noremap <Leader>Y "+y
noremap <Leader>P "+p

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

" make switching tabs faster
" C-PageUp doesn't quite work (might be an <A-j> type of situation)
nnoremap <A-m> gt
nnoremap <A-n> gT
" move tabs
nnoremap <Leader>t :tabmove +1<CR>
nnoremap <Leader>T :tabmove -1<CR>
nnoremap <Leader>e :tabe


" if exists("&undodir")
" 	set undodir=~/.vim/undo
" endif

" --- tab-rooter settings ---

" idea is that things like the tags and the Nerdtree shouldn't appear when I'm
" browsing /etc in a small window. So only enable them in these directories
let g:ide_whitelist = [
    \"tf-a",
    \"platform-ci",
    \"tftf",
    \"linux",
\]
let g:root_markers = [".git"]
let g:ide_on = 0

" --- tab-rooter (I wrote this based on vim-rooter) ---
set noautochdir

function! s:has(dir, identifier)
    return !empty(globpath(escape(a:dir, '?*[]'), a:identifier, 1))
endfunction

function Get_root_dir(path)
    let l:path = a:path
    " root is the first parent directory that has a marker in it
    while l:path != '/'
        for marker in g:root_markers
            if s:has(l:path, marker)
                return path
            endif
        endfor
        let l:path = fnamemodify(l:path, ':h')
    endwhile

    " no 'project' found. Go to parent of the file
    return expand('%:h')
endfunction

function Is_ide_whitelisted(path)
    if match(a:path, join(g:ide_whitelist, "\\|"))
        return 1
    endif
    return 0
endfunction

let s:root_found = 0
function Find_root()
    if s:root_found
        return
    endif

    let l:path = expand('%:p', 1)

    if empty(l:path)
        let s:root_found = 1
        return
    elseif l:path =~ 'NERD_tree_\d\+$'
        return
    endif

    let l:path = Get_root_dir(l:path)
    execute 'cd' fnameescape(path)

    " don't trigger on git please and/or readonly files, and no diff
    if Is_ide_whitelisted(path) && &ft !~ "gitcommit" && !&readonly && !&diff
        let g:ide_on = 1
    endif
endfunction

" heuristic, executes whenever we change the current buffer. Not too frequent
autocmd BufEnter * call Find_root()

" --- NERDtree setttings ---
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * if g:ide_on == 1 | NERDTree | wincmd p | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if g:ide_on == 1 && getcmdwintype() == '' | silent NERDTreeMirror | wincmd p | endif

" hide the arrows. Not sure if I like but is certainly concise
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" git plugin
let g:NERDTreeGitStatusConcealBrackets = 1
" let g:NERDTreeLimitedSyntax = 1

" syntax highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" show path of current file
nnoremap <Leader>f :execute 'NERDTreeFind' \| wincmd p<CR>
" don't do this automatically as it pollutes the unfolding and isn't useful.
" Automatic on first one and then manual is a good compromise
" Tried these but were very broken in many circumstances
" autocmd BufWinEnter * NERDTreeFind | wincmd p
" and find current file on tab change
" autocmd BufEnter,BufWinEnter * if g:ide_on == 1 && expand("%:p") !~ 'NERD_tree_\d\+$' | NERDTreeFind | wincmd p | endif

" --- Tagbar settings ---
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_ctags_bin = "ctags-universal"
" TODO: nnoremap?
" nmap <Leader>tgb :TagbarToggle<CR>

" --- youCompleteMe Settings ---
" C-y - close autocomplete menu (to insert tab)
" C- Space - open it
" TODO: you can try setting up semantic code completion; this *could* replace
" ctags and could even have cool inline semantic highlighting with type and
" error checks, docstrings and loads of ide features. Will 100% take an
" afternoon to setup and sounds very project specific
let g:ycm_show_diagnostics_ui = 0 " disable the semantic error highlights
let g:ycm_auto_hover = 1 " disable the detail popup on symbol hover
let g:ycm_collect_identifiers_from_tags_files = 1 " I use tags so enable

let g:rooter_patterns = ['.git', 'Makefile']

" --- vim-commentary settings ---
"  for comment details: https://vimdoc.sourceforge.net/htmldoc/usr_30.html
"  the default "/*\ %s\ */" comment doesn't work well while developing
"  for documentation, I can type it in myself I guess
autocmd FileType c setlocal commentstring=//\ %s

" --- gitgutter settings ---
set updatetime=100
highlight! link SignColumn LineNr

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" --- vim-highligher settings ---
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

" --- delimitMate settings ---
" TODO

" TODO: arm64asm needs a :syntax sync fromstart in it
" --- arm64asm-vim settings ---
" I use arm. x86 is unlikely but I can still set manually
autocmd FileType asm setlocal filetype=arm64asm

" used for debugging highlighting
" nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
"             \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
"             \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" --- gutentags settings ---
" Doesn't work for my custom ctags cmdline. It is only used to find the root of
" the project :)
let g:gutentags_enabled = 0
let g:gutentags_ctags_executable = "ctags-universal"

" I don't want tags polluting every git directory, so only enable this for a
" select few of directories
function Gutentags_Whitelist() abort
    let gutentags_whitelist = [
        \"tf-a",
        \"platform-ci",
        \"tftf",
        \"linux",
    \]
    if match(expand('%:p'), join(gutentags_whitelist, "\\|"))
        let g:gutentags_enabled = 1
    endif

endfunction

autocmd BufAdd call Gutentags_Whitelist

