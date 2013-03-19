" vimrc
" Copyright: (c) Joel Burget 2010 - 2012
"

" Enable 256 colors on laptop
" This should not be necessary...
set t_Co=256

set nocompatible
set shell=/bin/bash

" session settings
set sessionoptions=resize,winpos,winsize,buffers,tabpages,folds,curdir,help

"Automatically change current directory to that of the file in the buffer
autocmd BufEnter * cd %:p:h

" Set up pathogen
call pathogen#infect()
call pathogen#helptags()

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
  let g:Powerline_symbols = 'fancy'
  colorscheme badwolf
endif

if has("macunix")
  set transparency=7
  "set guifont=Monaco:h10
  set guifont=Menlo\ Regular:h11
endif

" Map escape to jk
imap jk <Esc>

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

nnoremap j gj
nnoremap k gk

" Yank from cursor to end of line
nnoremap Y y$

" Search and replace word under cursor (,*)
:nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" I prefer to stay on the selection over jumping to the next match
:nnoremap * *``

" Rainbow Parenthesis
"nnoremap <leader>rp :RainbowParenthesesToggle<CR>

"let g:sparkupExecuteMapping = '<c-i>'

" show the current line position
set ruler

" Awesome status line
"set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]

" Make it visible at all times
set laststatus=2

" Give 80 column warnings
set colorcolumn=80

set winwidth=84
set winminwidth=10

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Set this so we don't get messed up formatting when pasting
set pastetoggle=<F2>

" Enable better mouse support
set mouse=a

" don't use tabs, instead insert 2 spaces
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent

" Don't enable showmarks by default
let g:showmarks_enable=0

function! ToggleVimTips()
  if getwinvar(bufwinnr('~/vimtips'), '&previewwindow')
    let g:MyVimTips="off"
    pclose
  else
    let g:MyVimTips="on"
    pedit ~/vimtips
  endif
endfunction

function! ToggleNotepad()
  if getwinvar(bufwinnr('~/notes.org'), '&previewwindow')
    let g:NotePad="off"
    pclose
  else
    let g:NotePad="on"
    pedit ~/notes.org
  endif
endfunction

nnoremap <F4> :call ToggleVimTips()<CR>
nnoremap <F5> :call ToggleNotepad()<CR>
nnoremap <F6> :GundoToggle<CR>
nnoremap <F7> :TagbarToggle<CR>

let g:tagbar_ctags_bin='/usr/local/bin/ctags'

" Show matching parens, braces
set showmatch

if has('autocmd')
  autocmd FileType make set noexpandtab
endif

set hlsearch
set incsearch
syntax on
filetype plugin indent on

" Next two things thanks to John Resig: https://gist.github.com/955547
" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
augroup END

autocmd FileType c,cpp,h,hpp,java,hs,hsc,lhs,cabal,py,js autocmd BufWritePre <buffer> :%s/\s\+$//e

" Commands
" In the commands,
" <silent> prevents a message from being printed
" <CR> prevents us having to type enter

let mapleader = ","

" Show whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Strip trailing whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

nmap <silent> <leader>d :NERDTreeToggle<CR>

nmap <silent> <leader>t :TlistToggle<CR>

" Edit .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
" Reload .vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Automatically reload vimrc if it has been saved
if has('autocmd')
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Clear highlighted searches with ,/ instead of /sdfjlafl
nmap <silent> <leader>/ :let @/=""<CR>

" For those times you forgot to sudo
cmap w!! w !sudo tee % >/dev/null

" Tabs!
" set showtabline=2               " File tabs always visible
" :nmap <C-S-tab> :tabprevious<cr>
" :nmap <C-tab> :tabnext<cr>
" :nmap <C-t> :tabnew<cr>
" :map <C-t> :tabnew<cr>
" :map <C-S-tab> :tabprevious<cr>
" :map <C-tab> :tabnext<cr>
" :map <C-w> :tabclose<cr>
" :imap <C-S-tab> <ESC>:tabprevious<cr>i
" :imap <C-tab> <ESC>:tabnext<cr>i
" :imap <C-t> <ESC>:tabnew<cr>

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

" So hsc files are interpreted as haskell source
au BufRead,BufNewFile *.hsc set filetype=haskell
au BufRead,BufNewFile *.md set filetype=markdown

" haskell mode
" au Bufenter *.hs compiler ghc
" autocmd BufWritePost *.hs GhcModCheckAndLintAsync

" ctrlp
nmap ; :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'

" syntastic
let g:syntastic_check_on_open=0
let g:syntastic_echo_current_error=1
let g:syntastic_enable_signs=1
let g:syntastic_enable_highlighting=1
let g:syntastic_auto_jump=0
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=10

" VimOrganizer

" vars below are used to define default Todo list and
" default Tag list.  Will be changed in near future so
" that these are defined by config lines in each .org
" file itself, but now these are where you can change things:
let g:org_todo_setup='TODO | DONE'
" while g:org_tag_setup is itself a string
let g:org_tag_setup='{@home(h) @work(w) @tennisclub(t)} \n {easy(e) hard(d)} \n {computer(c) phone(p)}'

" leave these as is:
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au BufRead,BufNewFile *.org            call org#SetOrgFileType()
au BufRead *.org :PreLoadTags
au BufWrite *.org :PreWriteTags
au BufWritePost *.org :PostWriteTags

" below are two examples of Org-mode "hook" functions
" These present opportunities for end-user customization
" of how VimOrganizer works.  For more info see the
" documentation for hooks in Emacs' Org-mode documentation:
" http://orgmode.org/worg/org-configs/org-hooks.php#sec-1_40

" These two hooks are currently the only ones enabled in
" the VimOrganizer codebase, but they are easy to add so if
" there's a particular hook you want go ahead and request it
" or look for where these hooks are implemented in
" /ftplugin/org.vim and use them as example for placing your
" own hooks in VimOrganizer:
function! Org_property_changed_functions(line,key, val)
        "call confirm("prop changed: ".a:line."--key:".a:key." val:".a:val)
endfunction
function! Org_after_todo_state_change_hook(line,state1, state2)
        "call ConfirmDrawer("LOGBOOK")
        "let str = ": - State: " . Pad(a:state2,10) . "   from: " . Pad(a:state1,10) .
        "            \ '    [' . Timestamp() . ']'
        "call append(line("."), repeat(' ',len(matchstr(getline(line(".")),'^\s*'))) . str)
endfunction
