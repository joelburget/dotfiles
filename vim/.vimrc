"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/joel/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/joel/.cache/dein')
  call dein#begin('/Users/joel/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/joel/.cache/dein/repos/github.com/Shougo/dein.vim')

  " snippets
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " colors
  call dein#add('lifepillar/vim-solarized8')
  call dein#add('rakr/vim-one')

  " text manipulation
  call dein#add('junegunn/vim-easy-align')
  call dein#add('tpope/vim-unimpaired') " *
  call dein#add('tpope/vim-surround') " *
  call dein#add('tpope/vim-commentary') " *
  call dein#add('tpope/vim-repeat')

  " git
  call dein#add('airblade/vim-gitgutter')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('lambdalisue/gina.vim')

  " support
  call dein#add('nathanaelkane/vim-indent-guides')
  " call dein#add('sjl/gundo.vim')
  call dein#add('simnalamburt/vim-mundo')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('w0rp/ale')
  call dein#add('ervandew/supertab')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('scrooloose/nerdtree')
  call dein#add('majutsushi/tagbar')
  call dein#add('zerowidth/vim-copy-as-rtf')
  call dein#add('ConradIrwin/vim-bracketed-paste')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('mhinz/vim-startify')
  call dein#add('luochen1990/rainbow')
  call dein#add('tpope/vim-sensible')

  " experimental:
  " find and replace
  call dein#add('junegunn/vim-pseudocl')
  call dein#add('junegunn/vim-fnr')
  call dein#add('junegunn/vim-slash')
  call dein#add('junegunn/vim-peekaboo')

  " writing mode
  call dein#add('junegunn/goyo.vim')
  call dein#add('junegunn/limelight.vim')

  " call dein#add('valloric/YouCompleteMe')
  call dein#add('Shougo/deoplete.nvim')

  " haskell
  call dein#add('neovimhaskell/haskell-vim')
  call dein#add('enomsg/vim-haskellConcealPlus')
  " call dein#add('eagletmt/ghcmod-vim')
  " call dein#add('eagletmt/neco-ghc')
  call dein#add('Twinside/vim-hoogle')

  " rust
  call dein#add('rust-lang/rust.vim')

  " misc languages
  call dein#add('idris-hackers/idris-vim')
  call dein#add('ElmCast/elm-vim')
  call dein#add('raichoo/purescript-vim')
  call dein#add('derekelkins/agda-vim')
  " call dein#add('reasonml/vim-reason')
  call dein#add('derekelkins/agda-vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

"End dein Scripts-------------------------

noremap <plug>(slash-after) zz
nmap <Leader>r <Plug>(FNR)
xmap <Leader>r <Plug>(FNR)
nmap <Leader>R <Plug>(FNR%)
xmap <Leader>R <Plug>(FNR%)

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_refresh_always = 1
let g:necoghc_use_stack = 1

" set shell=/usr/local/bin/fish
set shell=/bin/bash

" session settings
set sessionoptions=resize,winpos,winsize,buffers,tabpages,folds,curdir,help

let g:airline_powerline_fonts = 1
set backspace=indent,eol,start

if (has("termguicolors"))
  set termguicolors
endif

" http://stackoverflow.com/a/7278548/2121468
let g:solarized_termtrans = 1
let g:solarized_termcolors = 16
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:one_allow_italics = 1
colorscheme solarized8_light
set background=light

let mapleader      = ","
let maplocalleader = ","

" Map jk / fd to escape
imap jk <Esc>
imap fd <Esc>

" :W saves
cnoreabbrev W w

setglobal fileencoding=utf-8

" Hide buffers instead of closing them.
set hidden

" History is 500 items long
set history=500
set wildmenu
set wildmode=list:longest

" don't show these filetypes, we won't edit them
set wildignore=*.swp,*.class,*.log,*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png,*.hi,*.jsmod,*.hers,*.p_hi,*.p_o,*.dyn_o,*.dyn_hi
set ignorecase smartcase

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

nnoremap ' `
nnoremap ` '

" Yank from cursor to end of line
nnoremap Y y$

" Search and replace word under cursor (,*)
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" Rainbow Parenthesis
"nnoremap <leader>rp :RainbowParenthesesToggle<CR>

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

" Enable better mouse support
set mouse=a

" don't use tabs, instead insert 2 spaces
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set autoindent

" Don't enable showmarks by default
let g:showmarks_enable=0

" Count the number of occurrences of the currently highlighted word
nnoremap <leader>ct :%s///gn<CR>

nnoremap <F6> :GundoToggle<CR>
nnoremap <F7> :TagbarToggle<CR>

" overwrite default yank commands so they default to the system keyboard,
" unless another register is explicitly given.
"
" http://stackoverflow.com/a/13381286
nnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
nnoremap <expr> yy (v:register ==# '"' ? '"+' : '') . 'yy'
nnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y'
xnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
xnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y'

let g:tagbar_ctags_bin='/usr/local/bin/ctags'

" Show matching parens, braces
set showmatch

" highlight results, act like 'modern browser' search
set hlsearch
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

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

" Commands
" In the commands,
" <silent> prevents a message from being printed
" <CR> prevents us having to type enter

" Show whitespace
set listchars=tab:>-,trail:�,eol:$
nmap <silent> <leader>s :set nolist!<CR>

nmap <silent> <leader>d :NERDTreeToggle<CR>

" nmap <silent> <leader>t :TlistToggle<CR>

" Edit .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
" Reload .vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>

augroup configgroup
  " clear all autocmds for the current group
  autocmd!

  "Automatically change current directory to that of the file in the buffer
  " autocmd BufEnter * cd %:p:h

  " Strip trailing whitespace on write
  autocmd BufWritePre * :%s/\s\+$//e

  " Automatically reload vimrc if it has been saved
  autocmd bufwritepost .vimrc source $MYVIMRC

  " automatically use leaders in literate haskell
  " http://stackoverflow.com/a/18572190
  autocmd FileType lhaskell setlocal formatoptions+=ro

  au BufRead,BufNewFile *.less set filetype=less
  au BufRead,BufNewFile *.hsc set filetype=haskell
  au BufRead,BufNewFile *.md set filetype=markdown

  autocmd Syntax * call matchadd('Error', '\(STOPSHIP\|XXX\)')
  autocmd Syntax * call matchadd('Todo', '\(TODO\|FIXME\|HACK\)')
  autocmd Syntax * call matchadd('Underlined', 'joel', 9)
augroup END

" Clear highlighted searches with ,/ instead of /sdfjlafl
nmap <silent> <leader>/ :let @/=""<CR>:call clearmatches()<CR>

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

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

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

" fzf
nmap ;b :Buffers<CR>
nmap ;f :FZF<CR>
nmap ;g :GFiles<CR>
nmap ;t :Tags<CR>
nmap ;r :Colors<CR>
nmap ;c :Commands<CR>
nmap ;h :Helptags<CR>
nmap ;m :Commands<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" purescript
let g:purescript_indent_if = 0
let g:purescript_indent_case = 2

" ----------------------------------------------------------------------------
" goyo.vim + limelight.vim
" ----------------------------------------------------------------------------
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

function! s:goyo_enter()
  if has('gui_running')
    set fullscreen
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  Limelight
  let &l:statusline = '%M'
  hi StatusLine ctermfg=red guifg=red cterm=NONE gui=NONE
endfunction

function! s:goyo_leave()
  if has('gui_running')
    set nofullscreen
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <Leader>G :Goyo<CR>

" Highlight Word {{{
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction " }}}

" Mappings {{{

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

" }}}
" Default Highlights {{{

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}

autocmd BufRead,BufNewFile *.md setlocal spell

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
