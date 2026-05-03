" PACKAGES {{{

set nocompatible    " no compatibility with vi

call plug#begin('~/.vim/bundle')
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/Colour-Sampler-Pack'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

filetype plugin indent on

" }}}

" EDITING {{{

set backspace=indent,eol,start " backspacing
set notimeout ttimeout timeoutlen=50 " less wait in term
set history=200     " keep 200 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set showmatch       " show matching brackets while typing
set noerrorbells    " don't ring the bell
set lazyredraw      " don't redraw during macros
set scrolloff=5     " 5 lines will always appear below the cursor
set hlsearch        " highlight searches
set ignorecase      " case insensitive searching
set smartcase       " case sensitive for uppercase
set incsearch       " incremental searching
set expandtab       " turns a tab into a space
set autoindent      " always set indent on
set tabstop=4       " number of spaces a tab counts for
set smarttab        " intelligent tabbing
set shiftwidth=4    " all for 4
set sts=4           " about indenting
set diffopt=iwhite  " ignore white space in diffs
set undofile        " persistent undo even after exiting a file
set undodir=~/.vim/undo

autocmd FileType * setlocal formatoptions-=cro " Disable automatic comments.

" https://superuser.com/questions/359580/error-adding-cronjobs-in-mac-os-x-lion
autocmd filetype crontab setlocal nobackup nowritebackup

" Mouse
if has('mouse')
    set mouse=a
    if !has('nvim')
        set ttymouse=xterm2
    endif
endif

" }}}

" FILES {{{

set hidden          " hides buffers instead of removing them
set nobackup        " don't keep a backup file
set nowritebackup
set updatetime=300
set autoread        " refreshes file constantly
set noswapfile      " sets no swap file

" Ignore these files.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.nzb,*.chf,*.part 
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.style,*.png
set wildignore+=*.o,*.obj,*.bak,*.m3u,*.avi,*.ssa,*.pdf
set wildignore+=*.sub,*.mp3,*.jpg,*.srt,*.idx,*.smi,*.chm
set wildignore+=*.nfo,*.mp4,*.sfv,*.mkv,*.rar,*.zip,*.class

" emulates autoread in the terminal
augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
    endif
augroup END


" }}}

" THEME {{{

syntax on           " Color files automatically.
set cursorline      " Highlight the current line.

set number
set termguicolors
set signcolumn=yes

set guioptions-=r  " Remove right-hand scrollbar.
set guioptions-=L  " Remove left-hand scrollbar.
set showbreak=↪    " Prettier linewraps.

if has('mac')
    if !has("gui_running")
        " OSX terminal is slow, so disable a couple things.
        set noshowmatch         " Don't match parentheses/brackets
        set nocursorline        " Don't paint cursor line
        set nocursorcolumn      " Don't paint cursor column
        let loaded_matchparen=1 " Don't load matchit.vim (paren/bracket matching)
        let html_no_rendering=1 " Don't render italic, bold, links in HTML
    endif
    set guifont=Consolas:h12,Menlo:h12
    set shell=/bin/bash
    set clipboard^=unnamed  " Tmux copy paste integration.
elseif has('win32')
    set guifont=Consolas:h10
elseif has('unix')
    set t_Co=256       " Sets 256 colors in the terminal.
    set guioptions-=T  " Remove Toolbar.
    set guioptions-=m  " Remove Menubar.
    set gfn=Inconsolata\ for\ Powerline\ 12,Terminus\ 10
    set shell=/bin/bash
endif

set background=dark

colorscheme fruity

hi SignColumn guibg=black

" https://sunaku.github.io/vim-256color-bce.html
" Make vim background work with Tmux.
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Status line
set laststatus=2

" }}}

" KEYMAPS {{{

" Modifier
inoremap <C-U> <C-G>u<C-U>
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.

" Regular
cmap w!! w !sudo dd of=%<cr>
" root authority writing
nnoremap Y y$
" y$ yanks to the end of the line.
nnoremap D d$
" d$ deletes to the end of the line.
nnoremap C c$
" c$ changes to the end of the line.
vnoremap < <gv
vnoremap > >gv
" Reselect text after identing

" Leader
nnoremap <space> <nop>
let mapleader=" "
let maplocalleader=" "
" change the mapLeader from \ to ,
nnoremap <Leader>t :TagbarToggle<CR>
" toggles the tagbar with tt
nnoremap <Leader>v :e ~/.vimrc<cr>
" open vimrc in another split
nnoremap <Leader>n :NERDTreeToggle<cr>
" Toggles NerdTree
nnoremap <Leader>gs :Git<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>f :Files<cr>
nnoremap <Leader>= m`gg=G``
" Indent the whole file and return to original position

nnoremap <Leader>k <C-W>k
nnoremap <Leader>j <C-W>j
nnoremap <Leader>l <C-W>l
nnoremap <Leader>h <C-W>h
nnoremap <Leader><backspace> <C-W>c
nnoremap <Leader>- :split<CR>
nnoremap <Leader><bar> :vsplit<CR>
nnoremap <Leader>\ :vsplit<CR>

" }}}

" FOLDING {{{

set foldenable      " Turn on folding
au FileType vim set foldmethod=marker
au FileType txt set foldmethod=marker

au FileType python set foldmethod=indent
au FileType c,cpp,java,ruby,php,css,html,eruby,javascript set foldmethod=syntax
au FileType python,c,cpp,java,ruby,php,css,html,eruby,javascript set foldlevel=4

"}}}

" WEB {{{

"Indentation
autocmd FileType javascript,eruby,ruby,html,css,php set shiftwidth=2
autocmd FileType javascript,eruby,ruby,html,css,php set tabstop=2
autocmd FileType javascript,eruby,ruby,html,css,php set sts=2
autocmd FileType javascript,eruby,ruby,css,php,python set textwidth=79

" Set the filetype for use with Sparkup
autocmd BufNewFile,BufRead *.xml,*.tpl set ft=html

" HTML in php files.
au BufRead,BufNewFile *.php set ft=php.html

" }}}

" PLUGIN {{{

" DelimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" NerdTree
" Close Vim if only NerdTree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDChristmasTree=1
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=0
let g:NERDTreeShowBookmarks=1
let g:NERDTreeDirArrows=0
let g:NERDTreeCasadeOpenSingleChildDir=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowLineNumbers=1

" LSP {{{

set completeopt=menu,menuone,noselect

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> K  <plug>(lsp-hover)
    nmap <buffer> <Leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_document_highlight_enabled = 0

inoremap <expr> <TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"

" }}}

" }}}
