if &compatible
  set nocompatible               " Be iMproved
endif

let base16colorspace=256

call plug#begin('~/.vim/plugged')

" colors
Plug 'lifepillar/vim-solarized8'
Plug 'rakr/vim-one'
Plug 'cocopon/iceberg.vim'
Plug 'chriskempson/base16-vim'

" text manipulation
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" git
" Plug 'airblade/vim-gitgutter'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'lambdalisue/gina.vim'
Plug 'tpope/vim-fugitive'

" support
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'sjl/gundo.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'Shougo/vimproc.vim', {'build' : 'make'}
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'build': './install --all', 'merged': 0 }
Plug 'junegunn/fzf.vim', { 'depends': 'fzf' }
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
" Plug 'zerowidth/vim-copy-as-rtf'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-sensible'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-eunuch'
Plug 'rhysd/conflict-marker.vim'
Plug 'urbainvaes/vim-remembrall'

" ,m -- mark word
" ,r -- regex mark
" ,n -- clear mark under cursor or all highlighted marks
" ,* -- jump to next occurrence of current mark
" ,/ -- jump to next occurrence of any mark
Plug 'vim-scripts/Mark'

" highlight colors (eg #123456) that appear in buffer
Plug 'lilydjwg/colorizer'

" basics
" ,,f{char} -- jump to char
" ,,w{char} -- jump to word
" also has line motions (need to be mapped?)
Plug 'easymotion/vim-easymotion'

" experimental:
Plug 'junegunn/vim-peekaboo'

" flash yanked text
" Plug 'kana/vim-operator-user'
" Plug 'haya14busa/vim-operator-flashy'

" writing mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Plug 'valloric/YouCompleteMe'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" haskell
Plug 'neovimhaskell/haskell-vim'
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'Twinside/vim-hoogle'

" rust
Plug 'rust-lang/rust.vim'

" misc languages
Plug 'idris-hackers/idris-vim'
Plug 'ElmCast/elm-vim'
Plug 'raichoo/purescript-vim'
Plug 'derekelkins/agda-vim'
" Plug 'reasonml/vim-reason'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'j16180339887/Global.vim'
Plug 'fatih/vim-go'
Plug 'rgrinberg/vim-ocaml'

" language server
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/echodoc.vim'

call plug#end()

" Required:
filetype plugin indent on
syntax enable

" always use the system clipboard
set clipboard=unnamed,unnamedplus

" let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_refresh_always = 1
" let g:necoghc_use_stack = 1

let g:haskell_indent_disable = 1

let g:ale_linters = {
\   'haskell': ['stack-ghc']
\}

let g:LanguageClient_serverCommands = {
  \ 'reason': ['ocaml-language-server', '--stdio'],
  \ 'ocaml': ['ocaml-language-server', '--stdio'],
  \ }

let NERDTreeIgnore = ['\~$', '\.png$','\.jpg$','\.gif$','\.mp3$','\.flac$', '\.ogg$', '\.mp4$','\.avi$','.webm$','.mkv$','\.pdf$', '\.zip$', '\.tar.gz$', '\.rar$', '\.mli.d$', '\.ml.d$', '\.o$', '\.cm[ix]a?$']

" easy align haskell. what i'd like to align:
" * '::' / '->' in type signatures
" * '<-' / '=' in let / do
" * maybe lens operators
let g:easy_align_delimiters = {
\ 's': { 'pattern': '::\|->', 'left_margin': 1, 'right_margin': 1 },
\ 'h': { 'pattern': '<-\|=',  'left_margin': 1, 'right_margin': 1 },
\ 'l': { 'pattern': '[-!#$%&*+./<=>?@\\~\^|]+', 'left_margin': 1, 'right_margin': 1 }
\ }

" set shell=/usr/local/bin/fish
set shell=bash

" session settings
set sessionoptions=resize,winpos,winsize,buffers,tabpages,folds,curdir,help

set backspace=indent,eol,start

" if (has("termguicolors"))
"   set termguicolors
" endif

" http://stackoverflow.com/a/7278548/2121468
let g:solarized_termtrans = 1
let g:one_allow_italics = 1
" colorscheme iceberg
colorscheme solarized8_light

let mapleader      = ","
let maplocalleader = ","

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

set autochdir

" Change the terminal's title
set title

" Show line numbers
set number

" set it so we always have a few lines below the cursor
set scrolloff=5

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

set rtp+=/nix/store/m2nfbl6rxdv54gy64dr7nr8lcz9kh96s-merlin-3.0.5/share/ocamlmerlin/vim
set rtp^="/nix/store/l22c51kqrhicnfs3ja40bdykxlgx98if-ocp-indent-1.6.1/share/ocp-indent/vim"

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
set listchars=tab:>-,trail:·,eol:$

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
  au BufRead,BufNewFile *.md setlocal spell
  au BufRead,BufNewFile *?Script.sml let maplocalleader = "h" | source /Users/joel/code/HOL/tools/vim/hol.vim

  autocmd Syntax * call matchadd('Error', '\(STOPSHIP\|XXX\)')
  autocmd Syntax * call matchadd('Todo', '\(TODO\|FIXME\|HACK\)')
  autocmd Syntax * call matchadd('Underlined', 'joel', 9)
augroup END

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
  let g:ackprg = 'ag --vimgrep'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0
endif

" Code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" purescript
let g:purescript_indent_if = 0
let g:purescript_indent_case = 2

" ----------------------------------------------------------------------------
" goyo.vim + limelight.vim
" ----------------------------------------------------------------------------
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

function! s:goyo_enter()
  " get rid of weird source-code like indenting:
  set spell noci nosi noai nolist noshowmode noshowcmd
  Limelight
  let &l:statusline = '%M'
  hi StatusLine ctermfg=red guifg=red cterm=NONE gui=NONE
endfunction

function! s:goyo_leave()
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

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

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

augroup mappings
  autocmd!

  " insert mode

  " Map jk / fd to escape
  imap jk <Esc>
  imap fd <Esc>

  " Insert mode completion
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)

  " command mode

  " For those times you forgot to sudo
  cmap w!! w !sudo tee % >/dev/null

  " normal mode

  nnoremap <C-e> 3<C-e>
  nnoremap <C-y> 3<C-y>

  nnoremap j gj
  nnoremap k gk

  nnoremap ' `
  nnoremap ` '

  " Yank from cursor to end of line
  nnoremap Y y$

  " map y <Plug>(operator-flashy)
  " nmap Y <Plug>(operator-flashy)$

  " let g:lmap = {}
  " " call leaderGuide#register_prefix_descriptions(",", "g:lmap")
  " nnoremap <localleader> :<c-u>LeaderGuide  ','<CR>
  " vnoremap <localleader> :<c-u>LeaderGuideVisual  ','<CR>

  " Show ',' normal mode mappings when key ',' is pressed
  nnoremap <silent> , :call remembrall#remind('n', ',')<cr>

  " Show ',' normal mode mappings when the key combination ',?' is pressed,
  " so we don't have to wait for the timeout.
  nnoremap <silent> ,? :call remembrall#remind('n', ',')<cr>
  vnoremap <silent> ? :call remembrall#remind('n', '')<cr>

  " t / toggle ->
  noremap <silent> <leader>tu :MundoToggle<cr>
  noremap <silent> <leader>tt :TagbarToggle<cr>
  noremap <silent> <leader>td :NERDTreeToggle<cr>
  noremap <silent> <leader>tq :ccl<cr>
  noremap <silent> <leader>tw :set nolist!<cr>

  " s / search ->

      " Count the number of occurrences of the currently highlighted word
      nnoremap <leader>sn :%s///gn<CR>

      " Clear highlighted searches
      nmap <silent> <leader>sc :let @/=""<CR>:call clearmatches()<CR>

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

  " bind K to grep word under cursor
  nnoremap K :Rg "\b<C-R><C-W>\b"<CR>:cw<CR>

  " bind \ (backward slash) to grep shortcut
  nnoremap \ :Rg<SPACE>

  nnoremap <Leader>G :Goyo<CR>

  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)

  " Edit .vimrc
  nmap <silent> <leader>ev :e $MYVIMRC<CR>
  " Reload .vimrc
  nmap <silent> <leader>sv :so $MYVIMRC<CR>

  " fzf
  nmap ;b :Buffers<CR>
  nmap ;f :FZF<CR>
  nmap ;g :GFiles<CR>
  nmap ;t :Tags<CR>
  nmap ;c :Colors<CR>
  nmap ;h :Helptags<CR>
  nmap ;m :Commands<CR>

  " Mapping selecting mappings
  nmap <leader><tab> <plug>(fzf-maps-n)
  xmap <leader><tab> <plug>(fzf-maps-x)
  omap <leader><tab> <plug>(fzf-maps-o)

  nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
  nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
  nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
  nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
  nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
  nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
augroup END
