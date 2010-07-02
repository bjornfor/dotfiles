"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My .vimrc file v0.1
"
" How to install my standard set of vim plugins:
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

"colorscheme desert
set bg=light

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

set path+=/usr/include/**
"set path+=./**
set dictionary+=/usr/share/dict/words
" Get mthesaur.txt:
"   wget http://www.gutenberg.org/dirs/etext02/mthes10.zip
"   unzip mthes10.zip
"   mv mthesaur.txt ~/.mthesaur.txt
set thesaurus+=~/.mthesaur.txt

"hi SpecialKey guifg=bg " hide all special characters, e.g. dos newlines ^M

"autocmd BufWinLeave *.[ch] mkview
"autocmd BufWinEnter *.[ch] silent loadview

" eases Python work: :make invokes python and errors are directed to offending
" line
"autocmd BufNewFile,BufRead *.py compiler python

" let vim recognize Sup (MUA) temp files
autocmd BufRead *sup.*-mode set ft=mail

" These options seem to be needed for extracting C structure member info
" when used with local variables:
"   --c-kinds=+l
"   --fields=+a
"   --extra=+q
nmap <F12> :!ctags -R --c++-kinds=+pl --c-kinds=+pl --fields=+iaS --extra=+q .<CR>\|:!cscope -R -b<cr>\|:cs r<cr><cr>

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

"nnoremap ' ` " swap single-quote and back-tick
"nnoremap ` '

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

" edit binary files (xxd is normally included in base installs)
nmap <Leader>hon :%!xxd<cr>
nmap <Leader>hof :%!xxd -r<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OS Specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("mac")
	" settings for mac goes here
endif

if has ("gui_win32")
	" settings for windows goes here
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
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

" Create a Python tags file:
"   ctags -R -f ~/.vim/tags/python.ctags /usr/lib/python2.6
" and then use it in Vim:
set tags+=~/.vim/tags/python.ctags
