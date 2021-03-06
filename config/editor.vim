" This file contain basics configurations for the editor:
"  - Option for files and buffers / history ...
"  - What to display (including search)
"  - Vim completions settings
"
" NO PLUGINS HERE

" Files & Buffers
"""""""""""""""""""""""""""""""""""""""
set nocompatible                " Use all new vim functionalities
set hidden                      " Do not close the buffers, hide them
set history=1000                " Remember more commands and search history
set undolevels=1000             " Remember more levels of undo
set noerrorbells                " No buzz on error
set novisualbell                " No 'visual buzz' on error
set t_vb=                       " Same as above
set autoread                    " Reload the file if changed from the outside
"set timeout                    " Enable timeout on mapping and key codes
"set timeoutlen=400             " Maximum wait time for command sequence
"set ttimeoutlen=400            " Same as above
set switchbuf=useopen           " if opening a file from :ls, :buffers, :files, etc. jump to open version
                                " of the file, if one exists
set confirm                     " dialog foor unsaved changes
set splitright                  " got to right pane by default (Needed for quickmenu)

" Terminal/GUI setup
set encoding=utf-8                " Fix encoding shit...
set guifont=inconsolata           " For people prefering the GVim...
set fillchars+=vert:•             " Prefere a dot over a pipe
set mouse=a                       " Use mouse when using vim (tip: maj during
                                  " selection to use ctrl-maj-c to copy text)

"autocmd BufEnter * silent! lcd %:p:h " change working directory at file opening

" smooth redraw
set lazyredraw

" Show keys in status
set showcmd

" Option to make clean session with mksession (usefull when changing vimrc)
set ssop=buffers,curdir,tabpages,winpos,winsize

" empty tex still are tex files
let g:tex_flavor = 'latex'

" Turn backup off ; be careful with this !
"set nobackup
"set nowb
"set noswapfile

" Persistent undo
if has("persistent_undo")
    set undofile
    execute 'set undodir='.g:Vimmic_BASE.".undodir"
    set undolevels=1000         " How many undos
    set undoreload=10000        " number of lines to save for undo
endif

" Indentation
"""""""""""""""""""""""""""""""""""""""
" Global configuration
set expandtab                     " Transform kitten killer tabs to spaces
set tabstop=4                     " Number of visual spaces per tab
set shiftwidth=4                  " Number of spaces to use for autoindent
set backspace=indent,eol,start    " Allow backspacing over everything in
                                  " insert mode
set autoindent                    " Always set autoindent on
set copyindent                    " Copy the previous indentation on autoindent
set shiftround                    " Use n shiftwidth when indenting with <>
set smarttab                      " Use smart removal when using tabs
autocmd FileType c,cpp  set smartindent " For c file, automatically inserts
                                        " one extra level of indentation in some cases
set nojoinspaces                  " When joining lines that end with '.', '?' or '!', ' '
                                  " only insert one space, not two


" Trailing / tabs
set list
set listchars=tab:▸\ ,extends:❰,nbsp:⇏,trail:•


" Display and search configuration
"""""""""""""""""""""""""""""""""""""""
set shortmess=a                 " Deal with messages
set nowrap                        " No new line when the line is too long
set showmatch                     " Show matching parenthesis
set ignorecase                    " Basically, ignore case when searching...
set smartcase                     " ...but be smart on the case when searching
set hlsearch                      " Highlight search matches as you type
set incsearch                     " Show search matches as you type
set ruler                         " Display the current cursor position


" Readability
"""""""""""""""""""""""""""""""""""""""
syntax on
set number                        " Always show line number
set cursorline                    " Change the current line background
set scrolloff=8                   " Keep 8 line above and under the current one
au BufNewFile,BufRead CMakeLists.txt set filetype=cmake    " for cmake

" Autocompletion
"""""""""""""""""""""""""""""""""""""""
" Wildmenu completion : exclude some files
set wildmenu
set wildmode=list:longest,full
set wildignore+=.hg,.git,.svn " Version Controls
set wildignore+=*.aux,*.out,*.toc " Latex Indermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " Binary Imgs
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " Compiled Object files
set wildignore+=*.spl " Compiled speolling world list
set wildignore+=*.sw? " Vim swap files
set wildignore+=*.DS_Store " OSX SHIT
set wildignore+=*.luac " Lua byte code
set wildignore+=migrations " Django migrations
set wildignore+=*.pyc " Python Object codes
set wildignore+=*.orig " Merge resolution files
set wildignore+=*.class " java/scala class files
set wildignore+=*/target/* " sbt target dires `,`. You can use space
                           " in your local
set completeopt=menu,longest
au FileType xml,html set matchpairs+=<:> " For tags and template
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Cursor
"""""""""""""""""""""""""""""""""""""""
" Show cursorline only for active window
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Make Sure that Vim returns to the same line when we reopen a file"
augroup line_return
    au!
    au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \ execute 'normal! g`"zvzz' |
                \ endif
augroup END


