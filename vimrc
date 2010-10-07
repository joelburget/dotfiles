" vimrc
" Copyright  : (c) Joel Burget 2010
"

" Enable 256 colors on laptop
" This should not be necessary...
set t_Co=256

set nocompatible
" lang en_US.UTF-8
" 
" Windows:
if has("win32")
  "set guifont=Consolas:h10
  set guifont=ProggyCleanTT:h11
  "set guifont=
  colorscheme molokai
  "colorscheme kib_darktango
  "colorscheme fruidle
  
  "for some reason backspace works weird on the laptop
  "this fixes it
  set backspace=2
else
  "colorscheme fruidle
  colorscheme mustang
endif

" Set up pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

setglobal fileencoding=utf-8
" Hide buffers instead of closing them.
set hidden

" History is 500 items long
set history=500
set wildmenu
set wildmode=list:longest

" don't show these filetypes, we won't edit them
set wildignore="*.swp,*.class,*.log,*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png"
set ignorecase
set smartcase

" Make it so we can use a forward slash for path names on windows
set shellslash

" Wait less time for commands that have the same first characters
" eg ,s and ,sv
set timeoutlen=400

" Change the terminal's title
set title

" Show line numbers
set number

" set it so we always have a few lines below the cursor
set scrolloff=5
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" show the current line position
set ruler

" Awesome status line
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]

" Make it visible at all times
set laststatus=2

" Give 80 column warnings
:au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
:au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

if has("macunix")
  set transparency=7
endif

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Set this so we don't get messed up formatting when pasting
set pastetoggle=<F2>

" Enable better mouse support
set mouse=a

" don't use tabs, instead insert 2 spaces
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab

set autoindent

" Show matching parens, braces
set showmatch

if has('autocmd')
autocmd FileType make set noexpandtab
endif

set hlsearch
set incsearch
syntax on
filetype on
filetype plugin on
filetype indent on

" Commands
" In the commands,
" <silent> prevents a message from being printed
" <CR> prevents us having to type enter

let mapleader = ","

" Show whitespace
set listchars=tab:>-,trail:�,eol:$
nmap <silent> <leader>s :set nolist!<CR>

nmap <silent> <leader>d :NERDTreeToggle<CR>

nmap <silent> <leader>t :TlistToggle<CR>

" Edit .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
" Reload .vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Automatically reload vimrc if it has been saved
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Clear highlighted searches with ,/ instead of /sdfjlafl
nmap <silent> <leader>/ :let @/=""<CR>

" For those times you forgot to sudo
cmap w!! w !sudo tee % >/dev/null

" Lusty reminders
" <leader>lf lusty file explorer
" <leader>lr lusty file explorer in current dir
" <leader>lb lusty buffer explorer
" <leader>lg lusty buffer grep

" Here are a bunch of awesome commands from Derek Wyatt
" (www.derekwyatt.org) for window navigation

" Move the cursor to the window left of the current one
noremap <silent> <leader>h :wincmd h<cr>

" Move the cursor to the window below the current one
noremap <silent> <leader>j :wincmd j<cr>

" Move the cursor to the window above the current one
noremap <silent> <leader>k :wincmd k<cr>

" Move the cursor to the window right of the current one
noremap <silent> <leader>l :wincmd l<cr>

" Close the window below this one
noremap <silent> <leader>cj :wincmd j<cr>:close<cr>

" Close the window above this one
noremap <silent> <leader>ck :wincmd k<cr>:close<cr>

" Close the window to the left of this one
noremap <silent> <leader>ch :wincmd h<cr>:close<cr>

" Close the window to the right of this one
noremap <silent> <leader>cl :wincmd l<cr>:close<cr>

" Close the current window
noremap <silent> <leader>cc :close<cr>

" Move the current window to the right of the main Vim window
noremap <silent> <leader>ml <C-W>L

" Move the current window to the top of the main Vim window
noremap <silent> <leader>mk <C-W>K

" Move the current window to the left of the main Vim window
" (unmap because showmarks defines the same keymap)
" unmap! <leader>mh             
" noremap <silent> <leader>mh <C-W>H

" Move the current window to the bottom of the main Vim window
noremap <silent> <leader>mj <C-W>J

" Endcommands

set visualbell

" The backup file contains the file as it was before you edited it
" set nobackup
"
" nowritebackup prevents vim from creating a new file, writing to it,
" then deleting the old file and changing the name of the new one. It just
" writes the new file
" set nowritebackup
" 
" Swap files contain undo/redo history and anything else in case of a crash
" set noswapfile

set grepprg=ack
set grepformat=%f:%l:%m

if has("macunix")
  let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
else
  let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif

" Code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" haskell mode
let g:haddoc_browser = "chromium"
let g:haddoc_browser_callformat = "%s %s"
au Bufenter *.hs compiler ghc
if has("macunix")
  let g:haddock_browser = "open"
  let g:haddoc_browser_callformat = "%s %s"
else 
  let g:haddoc_browser = "chromium"
  let g:haddoc_browser_callformat = "%s %s"
endif
