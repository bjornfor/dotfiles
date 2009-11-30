" My .vimrc file

filetype on
filetype plugin on
filetype plugin indent on

syntax on

"colorscheme desert
set bg=light

set hidden	" hide abandoned buffers. This option removes the demand for buffers to be 'unmodified' when left. This is very handy when working with lots of buffers!
set ts=4	" tabstop, number of spaces for tab character, defaults to 8
set sw=4	" shiftwidth, number of spaces for autoindent, defaults to 8
set hlsearch	" highlight search. Turn off with :noh{lsearch}
set incsearch	" incremental search, i.e. search while typing
set ic		" ignore case in searches
set smartcase	" only care about case if search word uses upper case (use with ignorecase)
set showmode	" status line displays 'insert' or 'visual' when not in normal mode
set wildmenu	" when tab'ing on the vim command line, a menu appear just above the command line
set ruler	" show the cursor position all the time
"set autoindent " uses the indent from prev line
"set cindent	" smarter indent
set smartindent	" is smarter than autoindent. Knows to go back a tab, if you
" have closed a block using '}' or goes front a tab if you have opened one with '{'.
"set showmatch	" briefly jump to matching bracket when the cursor is on a bracket
"set path=.,/usr/include/**,,** " generally one should use var+= or var-=
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

" Get gvim colorschemes in vim (the CSApprox plugin is required).
" When the CSApprox plugin is installed we just need to tell vim that
" we have a terminal with lots of colors.
if &term =~ '^\(xterm\|screen\)$'
  set t_Co=256
endif

"hi SpecialKey guifg=bg " hide all special characters, e.g. dos newlines ^M

"autocmd BufWinLeave *.[ch] mkview
"autocmd BufWinEnter *.[ch] silent loadview

" eases Python work: :make invokes python and errors are directed to offending
" line
"autocmd BufNewFile,BufRead *.py compiler python

" let vim recognize Sup (MUA) temp files
autocmd BufRead *sup.reply-mode set ft=mail

" Enable Asciidoc syntax highlighting on *.txt files (need the asciidoc plugin)
autocmd BufRead *.txt set ft=asciidoc


" easy mappings for the taglist plugin (vim-addons install taglist)
nnoremap <silent> <F8> :TlistToggle<CR>

" vimperator-like keyboard shortcuts for jumping to next/previous buffers
nmap <C-n> :bn<cr>
nmap <C-p> :bp<cr>

" <space> by default behaves like 'l', make it more useful
nmap <space> <C-f>		" scroll one screenful down
"nmap <space> za		" toggle folds

" :%s for search and replace is hard to type
" lets map them to gs...
nmap gs :%s/

"nmap M :make<cr>	" default binding for 'M' is to place the cursor on the line in the middle
"nmap <C-a> ggVG	" ctrl+a is normally used for incrementing the number under the cursor

" easy .vimrc access
nmap ,s :source $HOME/.vimrc<cr>
nmap ,e :edit $HOME/.vimrc<cr>
"autocmd BufWritePost .vimrc source % " automatically source .vimrc when written - DOES NOT WORK!

" Insert new line without going into insert mode
"nmap <S-Enter> O<ESC>		" insert above
"nmap <Enter> o<ESC>		" insert below

" Easier navigation with C compilation errors, grep searches and tags.
" Note: After finding the :cw command, I think there is not much use in
" these mappings anymore...
"nmap <F5> :cp<cr>
"nmap <F6> :cn<cr>
"nmap <F7> :tp<cr>
"nmap <F8> :tn<cr>

"nnoremap ' ` " swap single-quote and back-tick
"nnoremap ` '

" easier working with split windows
"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_
"set wmh=0

imap jj <esc>

" Host specific
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
