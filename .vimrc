"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My .vimrc file v0.4
"
" Plugins are managed with vim-addon-manager:
"   https://github.com/MarcWeber/vim-addon-manager
"
" Similar tools: vimana, pathogen, vundle, :h GLVS (built-in)
"
" Great source of Vim tips: http://www.rayninfo.co.uk/vimtips.html
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !filereadable(expand("~/vim-addons/vim-addon-manager/vim-addon-manager-addon-info.txt"))
	echo "vim-addon-manager not found. Installing it..."
	if !isdirectory(expand("~/vim-addons/vim-addon-manager/"))
		call mkdir(expand("~/vim-addons/vim-addon-manager"), "p")
	endif
	cd ~/vim-addons/vim-addon-manager
	" Get VAM with wget and tar
	"call system("wget -O- https://github.com/MarcWeber/vim-addon-manager/tarball/master | tar --strip-components=1 -xzvf -")
	" or with git
	cd ~/vim-addons
	call system("git clone git://github.com/MarcWeber/vim-addon-manager.git")
endif

set runtimepath+=$HOME/vim-addons/vim-addon-manager
call vam#ActivateAddons(["AutoTag",
			\ "CSApprox",
			\ "DetectIndent",
			\ "EasyGrep",
			\ "EvalSelection",
			\ "FuzzyFinder",
			\ "Gundo",
			\ "Mustang2",
			\ "SuperTab_continued.",
			\ "The_NERD_Commenter",
			\ "The_NERD_tree",
			\ "asciidoc",
			\ "clang_complete",
			\ "cscope_macros",
			\ "fugitive",
			\ "indentpython3461",
			\ "indenthaskell",
			\ "javacomplete",
			\ "matchit.zip",
			\ "pep8",
			\ "pydoc910",
			\ "rails",
			\ "repeat",
			\ "SingleCompile",
			\ "snipmate-snippets",
			\ "speeddating",
			\ "surround",
			\ "taglist-plus",
			\ "vim-ruby",
			\ "wmgraphviz"])
" Plugin notes:
" * OmniCppComplete conflicts with clang_complete
" * DetectIndent must be hooked up: autocmd BufReadPost * :DetectIndent
" * snipMate messes somewhat with autocomplete (<c-o> and <c-u>) so
"   that multiple TAB keys do not cycle through the list. One can still use
"   <c-n>/<c-p> though...
"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Generic stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

syntax on

" look for 'tags' in current directory and work up the tree towards root until
" one is found
set tags+=tags;/

" leader is default '\', but it's difficult to reach
let mapleader = ","

"set bg=light
" Set colorscheme so CSApprox can fix up colors (*after* "set bg=...")
colorscheme default

set hidden	" hide abandoned buffers. This option removes the demand for buffers to be 'unmodified' when left. This is very handy when working with lots of buffers!
"set ts=4	" tabstop, number of spaces for tab character, defaults to 8
"set sw=4	" shiftwidth, number of spaces for autoindent, defaults to 8
set showmode	" status line displays 'insert' or 'visual' when not in normal mode
set showcmd
set undofile
set wildmenu	" when tab'ing on the vim command line, a menu appear just above the command line
set clipboard=unnamedplus
"To have the completion behave similarly to a shell, i.e. complete only up to
"the point of ambiguity (while still showing you what your options are), also
"add the following:
"set wildmode=list:longest
" Or use a combination:
"set wildmode=list:longest,full
set ruler	" show the cursor position all the time
"set autoindent " uses the indent from prev line
"set cindent	" smarter indent
"set showmatch	" briefly jump to matching bracket when the cursor is on a bracket
" ask what to do instead of just failing (e.g. when :q notices there are
" unsaved changes and refuses to quit):
"set confirm
set mouse=a " allow using the mouse to change marker position and enter visual mode
set laststatus=2 "always show status bar/line
"set fdm=indent " fold method: fold sections based on indent level
"set foldlevel=3
"set history=100 " how many command lines to store?
"set lines=51
"set columns=80
" joinspaces: use two spaces after '.' when joining a line (or not: nojs)
set nojs
set modeline " read modelines
"set cursorline	" highlight the line the cursor is on
set hlsearch    " highlight search. Turn off with :noh{lsearch}
set incsearch   " incremental search, i.e. search while typing
set ic          " ignore case in searches
set smartcase   " only care about case if search word uses upper case (use with ignorecase)
set scrolloff=1
set visualbell

" 'sudo apt-get install wnorwegian' for /usr/share/dict/bokmaal
set dictionary+=/usr/share/dict/words
" Get mthesaur.txt:
"   wget http://www.gutenberg.org/dirs/etext02/mthes10.zip
"   unzip mthes10.zip
"   mv mthesaur.txt ~/.mthesaur.txt
set thesaurus+=~/.mthesaur.txt

" see ':help directory' and ':help swap-file'
"set directory-=.

"hi SpecialKey guifg=bg " hide all special characters, e.g. dos newlines ^M

"autocmd BufWinLeave *.[ch] mkview
"autocmd BufWinEnter *.[ch] silent loadview

" let vim recognize Sup (MUA) temp files
autocmd BufRead *sup.*-mode set ft=mail

" These options seem to be needed for extracting C structure member info
" when used with local variables:
"   --c-kinds=+l
"   --fields=+a
"   --extra=+q
nmap <F12> :!ctags -R --c++-kinds=+pl --c-kinds=+pl --fields=+iaS --extra=+q .<CR>\|:!cscope -R -b<cr>\|:cs r<cr><cr>

" SingleCompile plugin
nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr>

" Code completion tips (from http://vim.wikia.com/wiki/VimTip1608):
"
" mkdir ~/.vim/tags
" cd ~/.vim/tags
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f cpp /path/to/cpp_src  # or /usr/include/c++/VERSION/ ?
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f gl /usr/include/GL/   # for OpenGL
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f sdl /usr/include/SDL/ # for SDL
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f qt /usr/include/Qt* # for Qt
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f directfb /usr/include/directfb* # for directfb
"
" load the needed tag files
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt
"set tags+=~/.vim/tags/directfb

" toggle invisible chars
noremap <Leader>i :set list!<cr>

nnoremap <leader><space> :noh<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" vimperator-like keyboard shortcuts for jumping to next/previous buffers
nmap <C-n> :bn<cr>
nmap <C-p> :bp<cr>

" search will center on the line it's found in
map N Nzz
map n nzz

" <space> by default behaves like 'l', make it more useful
"nmap <space> <C-f>		" scroll one screenful down
"nmap <space> za		" toggle folds

" :%s for search and replace is hard to type
" lets map them to gs...
nmap gs :%s/

map <Leader>m :w<cr>:make<cr>
"nmap <C-a> ggVG	" ctrl+a is normally used for incrementing the number under the cursor

" Insert new line without going into insert mode
"nmap <S-Enter> O<ESC>		" insert above
"nmap <Enter> o<ESC>		" insert below

" Easier omnicomplete mapping
" <Nul> is Ctrl-Space
inoremap <Nul> <C-x><C-o>

" Easier navigation with C compilation errors, grep searches and tags.
" Note: After finding the :cw command, I think there is not much use in
" these mappings anymore...
"nmap <F5> :cp<cr>
"nmap <F6> :cn<cr>
"nmap <F7> :tp<cr>
"nmap <F8> :tn<cr>

" make single-quote act as back-tick
map ' `

" scroll faster
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" easier working with split windows
"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_
"set wmh=0

"" from a forum
ino jj <esc>
cno jj <c-c>
""For visual mode, just use "v" to toggle it on and off:
"vno v <esc>

" n is for normal mode
nnoremap Q gqap
" v is for visual mode.
vnoremap Q gq

" edit binary files (xxd is normally included in base installs)
nmap <Leader>hon :%!xxd<cr>
nmap <Leader>hof :%!xxd -r<cr>

map <Leader>d :NERDTreeToggle<CR>

" This is for working across multiple xterms and/or gvims
map ;w :w! ~/.vimxfer<CR>
map ;r :r ~/.vimxfer<CR>
" Append
map ;a :w! >>~/.vimxfer<CR>

autocmd FileType haskell map <buffer> <f5> :update<cr>:!runghc %<cr>
autocmd FileType haskell setlocal sw=4 sts=4 expandtab

autocmd FileType ruby setlocal sw=2 sts=2 expandtab

autocmd Filetype java setlocal omnifunc=javacomplete#Complete

autocmd FileType python map <buffer> <f5> :update<cr>:!python %<cr>

autocmd FileType html setlocal ts=4 sw=4
autocmd FileType xhtml setlocal ts=4 sw=4


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GVim stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OS Specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("unix")
	" easy .vimrc access
	nmap <Leader>s :source $HOME/.vimrc<cr>
	nmap <Leader>e :edit $HOME/.vimrc<cr>
	" source .vimrc when written - FIXME: messes up colorscheme!
	"autocmd BufWritePost .vimrc source %
endif

if has("gui_win32")
	" settings for windows goes here
	set backspace=indent,eol,start

	" easy _vimrc access
	nmap <Leader>s :source $HOME/_vimrc<cr>
	nmap <Leader>e :edit $HOME/_vimrc<cr>
endif

if has("mac")
	" settings for mac goes here
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings related to plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Get gvim colorschemes in vim (the CSApprox plugin is required).
" When the CSApprox plugin is installed we just need to tell vim that
" we have a terminal with lots of colors.
if &term =~ '^\(xterm\|screen\|screen-bce\)$'
  set t_Co=256
endif

" easy mappings for the taglist plugin (vim-addons install taglist)
nnoremap <silent> <Leader>t :TlistToggle<CR>

" FuzzyFinder http://www.vim.org/scripts/script.php?script_id=1984
map <Leader>f :FufFile<cr>
map <Leader>b :FufBuffer<cr>

" (snipmate) see :h g:snips_author
let g:snips_author = 'Bjørn Forsman'

" Enable Asciidoc syntax highlighting on *.txt files (need the asciidoc plugin)
"autocmd BufRead *.txt set ft=asciidoc

" TODO: revisit rope/ropevim
"let ropevim_vim_completion=1
"function! TabWrapperRope()
"	if strpart(getline('.'), 0, col('.')-1) =~ '^\s*$'
"		return "\<Tab>"
"	else
"		return "\<C-R>=RopeCodeAssistInsertMode()\<CR>"
"	endif
"endfunction
"
"imap <Tab> <C-R>=TabWrapperRope()<CR>

"" OmniCppComplete http://www.vim.org/scripts/script.php?script_id=1520
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
set completeopt=menuone

" AutoTag
"let g:autotagCtagsCmd="ctags --c++-kinds=+p --c-kinds=+l --fields=+iaS --extra=+q"

" clang_complete
let g:clang_complete_copen=1
let g:clang_complete_auto=0
let g:clang_snippets=1

" SuperTab
let g:SuperTabDefaultCompletionType = "context"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Host specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"if hostname() == "foo"
"  " do something
"endif

if hostname() == "timmons"
  " for the vim wiki:
  set tags+=/media/raid/bjornfor/projects/vim-wiki/tags
  autocmd BufWritePost /media/raid/bjornfor/projects/vim-wiki/* :helptags /media/raid/bjornfor/projects/vim-wiki
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("python")
python << EOF
def setPythonPath():
    import os
    import sys
    import vim
    vim.command(r"setlocal path-=/usr/include")  # remove C/C++ header path
    for p in sys.path:
        if os.path.isdir(p):
            vim.command(r"setlocal path+=%s" % (p.replace(" ", r"\ ")))
EOF
autocmd FileType python python setPythonPath()
autocmd FileType python nmap <Leader>pdb oimport pdb; pdb.set_trace()<esc>^
endif " has("python")

autocmd FileType python setlocal sw=4 sts=4

" :make invokes pylint and errors are directed to offending line.
" TODO: try pylint/pyunit/python compilers
"au FileType python compiler pylint

" Change pylint behaviour (see pylint.vim for doc):
"let g:pylint_onwrite = 0
"let g:pylint_show_rate = 0
let g:pylint_cwindow = 0

" Create a Python tags file:
"   ctags -R -f ~/.vim/tags/python.ctags /usr/lib/python2.6
" and then use it in Vim:
"set tags+=~/.vim/tags/python.ctags
