if &compatible
  set nocompatible               " Be iMproved
endif

let base16colorspace=256

set encoding=utf-8
scriptencoding utf-8

call plug#begin('~/.local/share/nvim/site/plugged')

" colors
Plug 'lifepillar/vim-solarized8'
Plug 'rakr/vim-one'
Plug 'cocopon/iceberg.vim'
Plug 'chriskempson/base16-vim'
Plug 'soft-aesthetic/soft-era-vim'

" text manipulation
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" git
" Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'lambdalisue/gina.vim'
" Plug 'tpope/vim-fugitive'

" support
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'sjl/gundo.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'Shougo/vimproc.vim', {'build' : 'make'}
Plug 'w0rp/ale'
Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'majutsushi/tagbar'
" Plug 'zerowidth/vim-copy-as-rtf'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-sensible'
Plug 'mileszs/ack.vim'
" Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-eunuch'
Plug 'rhysd/conflict-marker.vim'
Plug 'sbdchd/neoformat'
Plug 'mbbill/undotree'
Plug 'kana/vim-altr'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" haskell
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'Twinside/vim-hoogle'

" rust
Plug 'rust-lang/rust.vim'

" misc languages
Plug 'idris-hackers/idris-vim'
Plug 'ElmCast/elm-vim'
Plug 'derekelkins/agda-vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'j16180339887/Global.vim'
Plug 'fatih/vim-go'
Plug 'ocaml/vim-ocaml'
Plug 'rescript-lang/vim-rescript'

" Telescope
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

" fzf
Plug 'junegunn/fzf', { 'build': './install --all', 'merged': 0 }
Plug 'junegunn/fzf.vim', { 'depends': 'fzf' }

Plug 'lfv89/vim-interestingwords'
call plug#end()

call altr#define("%.res", "%.resi")

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

let g:neoformat_ocaml_ocamlformat = {
  \ 'exe': 'ocamlformat',
  \ 'no_append': 1,
  \ 'stdin': 1,
  \ 'args': ['--disable-outside-detected-project', '--name', '"%:p"', '-']
  \ }

let g:neoformat_enabled_ocaml = ['ocamlformat']

nnoremap <silent> f :Neoformat<CR>

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
colorscheme solarized8

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

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

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
set listchars=tab:>-,trail:_,eol:$,nbsp:+

augroup configgroup
  " clear all autocmds for the current group
  autocmd!

  "Automatically change current directory to that of the file in the buffer
  " autocmd BufEnter * cd %:p:h

  " Strip trailing whitespace on write
  autocmd BufWritePre * :let _s=@/ | :%s/\s\+$//e | :let @/=_s

  " Automatically reload init.vim if it has been saved
  autocmd bufwritepost init.vim source $MYVIMRC

  " automatically use leaders in literate haskell
  " http://stackoverflow.com/a/18572190
  autocmd FileType lhaskell setlocal formatoptions+=ro

  au BufRead,BufNewFile *.less set filetype=less
  au BufRead,BufNewFile *.hsc set filetype=haskell
  au BufRead,BufNewFile *.md set filetype=markdown
  au BufRead,BufNewFile *.md setlocal spell
  au BufRead,BufNewFile *?Script.sml let maplocalleader = "h" | source /Users/joel/code/HOL/tools/vim/hol.vim

  au BufRead,BufNewFile *.ml set colorcolumn=90
  au BufRead,BufNewFile *.mli set colorcolumn=90

  autocmd Syntax * call matchadd('Error', '\(STOPSHIP\|XXX\)')
  autocmd Syntax * call matchadd('Todo', '\(TODO\|FIXME\|HACK\|\<Q\>\)')
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

augroup fmt
  autocmd!
  autocmd BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | endtry
augroup END

augroup mappings
  autocmd!

  " insert mode

  " Map jk / fd to escape
  imap jk <Esc>
  imap fd <Esc>

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

  " Edit init.vim
  nmap <silent> <leader>ev :e $MYVIMRC<CR>
  " Reload init.vim
  nmap <silent> <leader>sv :so $MYVIMRC<CR>

  " fzf
  nmap ;b :Buffers<CR>
  nmap ;r :History<CR>
  nmap ;f :FZF<CR>
  nmap ;g :GFiles<CR>
  nmap ;t :Tags<CR>
  nmap ;c :Colors<CR>
  nmap ;h :Helptags<CR>
  " nmap ;m :Commands<CR>
  nmap ;m :marks<CR>

  " nmap ;b <cmd>Telescope buffers<cr>
  " nmap ;r <cmd>Telescope command_history<cr>
  " nmap ;f <cmd>Telescope find_files<cr>
  " nmap ;g <cmd>Telescope git_files<cr>
  " nmap ;t <cmd>Telescope tags<cr>
  " nmap ;c <cmd>Telescope colorscheme<cr>
  " nmap ;h <cmd>Telescope help_tags<cr>
  " nmap ;m <cmd>Telescope marks<cr>

  nnoremap <leader>a :call altr#forward()<CR>

  let g:interestingWordsDefaultMappings = 0
  nnoremap <silent> <leader>m :call InterestingWords('n')<cr>
  vnoremap <silent> <leader>m :call InterestingWords('v')<cr>
  nnoremap <silent> <leader>M :call UncolorAllWords()<cr>
  nnoremap <silent> n :call WordNavigation(1)<cr>
  nnoremap <silent> N :call WordNavigation(0)<cr>
augroup END

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["merlin", "ocp-indent", "ocp-index"]
let s:opam_available_tools = []
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if isdirectory(s:opam_share_dir . "/" . tool)
    call add(s:opam_available_tools, tool)
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

" ## added by OPAM user-setup for vim / ocp-indent ## 5cf60c18ec36bc9b35dfdecde7072213 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/Users/joel/.opam/4.13.1/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
