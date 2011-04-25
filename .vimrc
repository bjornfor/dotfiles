"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My .vimrc file v0.2
"
" Plugins:
" * AutoTag: http://www.vim.org/scripts/script.php?script_id=1343
" * clang_complete: http://www.vim.org/scripts/script.php?script_id=3302
"                   https://github.com/Rip-Rip/clang_complete
" * omnicppcomplete: http://www.vim.org/scripts/script.php?script_id=1520
" * taglist: http://www.vim.org/scripts/script.php?script_id=273
" * bufexplorer: http://www.vim.org/scripts/script.php?script_id=42
" * NERDTree: http://www.vim.org/scripts/script.php?script_id=1658
" * surround: http://www.vim.org/scripts/script.php?script_id=1697
" * snipMate: http://www.vim.org/scripts/script.php?script_id=2540
" * EasyGrep: http://www.vim.org/scripts/script.php?script_id=2438
" * matchit: http://www.vim.org/scripts/script.php?script_id=39
"
" * project: http://www.vim.org/scripts/script.php?script_id=69 (TODO: try out)
" * indexer: http://www.vim.org/scripts/script.php?script_id=3221 (TODO: try out)
"
" How to install vim plugins (Debian/Ubuntu):
"  $ sudo apt-get install vim-scripts vim-addon-manager
"  $ vim-addons install asciidoc bufexplorer detectindent git-commit matchit \
"    omnicppcomplete project python-indent surround taglist utl vcscommand \
"    vimoutliner
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Generic stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

syntax on

" look for 'tags' in current directory and work up the tree towards root until
" one is found
set tags+=tags;/

"set bg=light
" Set colorscheme so CSApprox can fix up colors (*after* "set bg=...")
colorscheme default

set hidden	" hide abandoned buffers. This option removes the demand for buffers to be 'unmodified' when left. This is very handy when working with lots of buffers!
"set ts=4	" tabstop, number of spaces for tab character, defaults to 8
"set sw=4	" shiftwidth, number of spaces for autoindent, defaults to 8
set showmode	" status line displays 'insert' or 'visual' when not in normal mode
set wildmenu	" when tab'ing on the vim command line, a menu appear just above the command line
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
set cursorline	" highlight the line the cursor is on
set hlsearch    " highlight search. Turn off with :noh{lsearch}
set incsearch   " incremental search, i.e. search while typing
set ic          " ignore case in searches
set smartcase   " only care about case if search word uses upper case (use with ignorecase)
set scrolloff=1
set visualbell

set dictionary+=/usr/share/dict/words
" Get mthesaur.txt:
"   wget http://www.gutenberg.org/dirs/etext02/mthes10.zip
"   unzip mthes10.zip
"   mv mthesaur.txt ~/.mthesaur.txt
set thesaurus+=~/.mthesaur.txt

" see ':help directory' and ':help swap-file'
set directory-=.

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
noremap ,i :set list!<cr>

" vimperator-like keyboard shortcuts for jumping to next/previous buffers
nmap <C-n> :bn<cr>
nmap <C-p> :bp<cr>

" <space> by default behaves like 'l', make it more useful
"nmap <space> <C-f>		" scroll one screenful down
"nmap <space> za		" toggle folds

" :%s for search and replace is hard to type
" lets map them to gs...
nmap gs :%s/

map ,m :make<cr>
"nmap <C-a> ggVG	" ctrl+a is normally used for incrementing the number under the cursor

" easy .vimrc access
nmap ,s :source $HOME/.vimrc<cr>
nmap ,e :edit $HOME/.vimrc<cr>
"autocmd BufWritePost .vimrc source % " automatically source .vimrc when written - DOES NOT WORK!

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

" leader is default '\', but it's difficult to reach
"let mapleader = ","


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OS Specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("mac")
	" settings for mac goes here
endif

if has ("gui_win32")
	" settings for windows goes here
	set backspace=indent,eol,start
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
nnoremap <silent> T :TlistToggle<CR>

" FuzzyFinder http://www.vim.org/scripts/script.php?script_id=1984
map ,f :FufFile<cr>
map ,b :FufBuffer<cr>

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

" AutoTag
"let g:autotagCtagsCmd="ctags --c++-kinds=+p --c-kinds=+l --fields=+iaS --extra=+q"


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

" :make invokes pylint and errors are directed to offending line.
" TODO: try pylint/pyunit/python compilers
au FileType python compiler pylint

" Change pylint behaviour (see pylint.vim for doc):
"let g:pylint_onwrite = 0
"let g:pylint_show_rate = 0
let g:pylint_cwindow = 0

" Create a Python tags file:
"   ctags -R -f ~/.vim/tags/python.ctags /usr/lib/python2.6
" and then use it in Vim:
"set tags+=~/.vim/tags/python.ctags


" 'Find' command from http://vim.wikia.com/wiki/Find_files_in_subdirectories
python << EOL
import vim

def Finder(*args):
    ''' Operation is as follows:
        - request the starting dir
        - find command finds the requested file
        - the printf param formats it to accomodate the errorformat '%f:%l:%m'
        - line is always 1, message is empty (-)
        - the 'cgete' vim command puts it into the quickfix errorlist
        - 'botright copen' opens the quickfix list
    '''
    start_dir = vim.eval('input("Start from dir: ", getcwd(), "dir")')
    find_cmd = (r'find %s -name %s -printf %%p:1:-\\n' % (start_dir, args[0]))
    vim.command("cgete system('%s')" % find_cmd)
    vim.command('botright copen')
EOL
command! -nargs=1 Find :py Finder("<args>")
