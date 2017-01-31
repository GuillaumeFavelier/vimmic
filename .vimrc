"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" @file vimrc
" @author Charles Gueunet, Axel Martin
" @brief Vim main configuration file
" @version 0.6
" @date 04-01-2016
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Usefull variables                                                         {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Windows ?
let g:isWin = has('win16') || has('win32') || has('win64')
" / or \ depending on OS
let g:file_sep = (g:isWin)?'\':'/'
" Exemples on Linux, usinig original vim
" ~/
let g:Vimmic_HOME = fnamemodify(expand('<sfile>'), ':p:h:gs').g:file_sep
" ~/.vim/
let g:Vimmic_BASE = fnamemodify(resolve(expand('<sfile>')), ':p:h:gs').g:file_sep
" ~/.vim/config/
let g:Vimmic_CONFIG = g:Vimmic_BASE."config".g:file_sep
" ~/.vim/config/plugins/
let g:Vimmic_CONFIG_PLUGINS = g:Vimmic_CONFIG."plugins".g:file_sep
" ~/.vimrc.preconf
let g:Vimmic_PRECONF  = g:Vimmic_HOME.".vimrc.preconf"
" ~/.vimrc.postconf
let g:Vimmic_POSTCONF = g:Vimmic_HOME.".vimrc.postconf"
" ~/.vim/dein/repos/github.com/Shougo/dein.vim/
let g:Vimmic_DEIN = g:Vimmic_BASE.join(['dein','repos','github.com','Shougo','dein.vim'], g:file_sep)
"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein first install
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !filereadable(expand(g:Vimmic_DEIN).g:file_sep.'README.md')
    if executable('git')
exec '!git clone https://github.com/Shougo/dein.vim '.g:Vimmic_DEIN
    else
        echohl WarningMsg
        echom "Git needed ! (how did you get this conf without it ?)"
        echohl None
    endif

endif

"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin import                                                             {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
execute 'set runtimepath^='.g:Vimmic_DEIN

" Required:
call dein#begin(g:Vimmic_BASE."dein")

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Load the ~/.vimrc.preconf if exist, after init dein
" to allow disabled plugins
if filereadable(g:Vimmic_PRECONF)
  execute 'source' g:Vimmic_PRECONF
  let g:deinNeedInstall=1
endif

" Modules

" GUI
call dein#add('vim-airline/vim-airline')
call dein#add('scrooloose/nerdtree')
call dein#add('majutsushi/tagbar')
call dein#add('MattesGroeger/vim-bookmarks')
call dein#add('kshenoy/vim-signature')
call dein#add('mbbill/undotree')
call dein#add('mhinz/vim-startify')
call dein#add('regedarek/ZoomWin')
call dein#add('myusuf3/numbers.vim')

" Versionning
call dein#add('airblade/vim-gitgutter')

" text Highlight / Motion
call dein#add('luochen1990/rainbow')
call dein#add('Lokaltog/vim-easymotion')
call dein#add('corntrace/bufexplorer')
call dein#add('kana/vim-textobj-user')
call dein#add('kana/vim-textobj-indent')
call dein#add('terryma/vim-expand-region')
call dein#add('tpope/vim-surround')
call dein#add('Raimondi/delimitMate')
call dein#add('godlygeek/tabular')
call dein#add('osyo-manga/vim-over')
call dein#add('AndrewRadev/switch.vim')

" Completion / snippets
call dein#add('scrooloose/syntastic')
call dein#add('scrooloose/nerdcommenter')
call dein#add('garbas/vim-snipmate')
" Might replace snipmate
"call dein#add('Shougo/neocomplete.vim')
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" lib needed by nerdtree & others
call dein#add('tomtom/tlib_vim')
call dein#add('MarcWeber/vim-addon-mw-utils')

" Filetype dependant
""""""""""""""""""""""""
" C / CPP
call dein#add('justmao945/vim-clang', {'on_ft':["c","cpp"]})
call dein#add('octol/vim-cpp-enhanced-highlight', {'on_ft':["c","cpp"]})
"call dein#add('mrtazz/DoxygenToolkit.vim', {'on_ft':["c","cpp"]})
" Python
call dein#add('davidhalter/jedi-vim', {'on_ft':["python"]})
call dein#add('andviro/flake8-vim', {'on_ft':["python"]})
" XML / HTML
"call dein#add('alvan/vim-closetag', {'on_ft':["xml","html"]})
call dein#add('sukima/xmledit', {'on_ft':["xml","html"]})
" Latex
call dein#add('lervag/vimtex', {'on_ft':"tex"})
" Markdown
call dein#add('plasticboy/vim-markdown', {'on_ft':["markdown"]})

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if g:deinNeedInstall
    if dein#check_install()
        call dein#install()
    endif
endif

"End dein Scripts-------------------------

"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global configuration                                                      {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Leader key
if !exists("mapleader")
    let mapleader=","                      " Leader key is `,`.
endif

" Basics configuration of the editor (file, search, completion, cursor, ...)
execute 'source '.g:Vimmic_CONFIG.'editor.vim'

" Basics colors and theme
execute 'source '.g:Vimmic_CONFIG.'theme.vim'

" Basics vim shortcuts (editor, completion, navigation, ...)
execute 'source '.g:Vimmic_CONFIG.'shortcuts.vim'

"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Module and environment configuration                                      {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load all plugins confs
" Each file have:
"  - settings
"  - shortcuts
"  - colors and theme
for pluginConf in split(glob(g:Vimmic_CONFIG_PLUGINS."*"), '\n')
    execute 'source' pluginConf
endfor

" Custom snippets folder
execute 'set runtimepath ^='.g:Vimmic_BASE."snippets/vim-snipmate-snippets/"
execute 'set runtimepath ^='.g:Vimmic_BASE."snippets/vim-snippets/"

" Note : Syntasic and airline imapct the statusline
"
""""""""""""""""""""""""""""""""""""""""""""""

" Module shortcuts
"""""""""""""""""""""""""""""""""""""""

" Tagbar (http://blog.stwrt.ca/2012/10/31/vim-ctags)
nnoremap <silent> <Leader>b :TagbarToggle<CR>


"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatic replace / correct
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Latex use ellipsis :
autocmd Filetype tex inoremap ... \ldots

" C / CPP fast -> and <<
au FileType c,cpp inoremap -. ->
au FileType cpp inoremap ,, <<
au FileType cpp inoremap <, <<


"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom function : used for daily actions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Update the vim configuration
function! Update()
    call dein#update()
endfunc
command! Update call Update()

" Ask vim-clang to compile the project to debug the autocompletion
function! DebugVimClang()
    let g:clang_diagsopt = 'rightbelow:6'
endfunction
command! DebugVimClang call DebugVimClang()

function! FoldAll()
    set foldmethod=syntax
    redraw
    sleep 100m
    set foldmethod=manual
endfunction
command! FoldAll call FoldAll()

"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Post-configuration : used for plugins configuration and colors / themes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load the ~/.vimrc.postconf if exist
if filereadable(g:Vimmic_POSTCONF)
  execute 'source' g:Vimmic_POSTCONF
endif


"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Todo section                                                              {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Switch to neocomplete / neosnippet but avoid the [B] completion
"
" xmledit is only for xml. Add xml, xhtml
"
"}}}

