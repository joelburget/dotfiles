set nocompatible
" set shell=/usr/local/bin/fish
set shell=/bin/bash

" set the runtime path to include Vundle and initialize
filetype off                  " required
set rtp+=~/.vim/bundle/neobundle.vim
call neobundle#begin('~/.vim/bundle')

" let neobundle manage neobundle, required
NeoBundleFetch 'Shougo/neobundle.vim'

" colors
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'sjl/badwolf'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'robertmeta/nofrils'
NeoBundle 'rakr/vim-one'

" text manipulation
NeoBundle 'godlygeek/tabular' " *
NeoBundle 'tpope/vim-unimpaired' " *
NeoBundle 'tpope/vim-surround' " *
NeoBundle 'tpope/vim-commentary' " *
NeoBundle 'tpope/vim-repeat'

" git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'int3/vim-extradite'

" support
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache'
" NeoBundle 'scrooloose/syntastic'
NeoBundle 'ervandew/supertab'
NeoBundle 'valloric/YouCompleteMe'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'majutsushi/tagbar'

" react stuff
NeoBundle 'mxw/vim-jsx'
NeoBundle 'justinj/vim-react-snippets'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'ternjs/tern_for_vim'

" haskell
" NeoBundle 'raichoo/haskell-vim'
" NeoBundle 'enomsg/vim-haskellConcealPlus'
" NeoBundle 'eagletmt/ghcmod-vim'
" NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'Twinside/vim-hoogle'

" fast html authoring
NeoBundle 'rstacruz/sparkup'

" rust
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'valloric/YouCompleteMe'

" misc
NeoBundle 'idris-hackers/idris-vim'
NeoBundle 'ElmCast/elm-vim'
NeoBundle 'zerowidth/vim-copy-as-rtf'
NeoBundle 'raichoo/purescript-vim'
NeoBundle 'tomlion/vim-solidity'
NeoBundle 'derekelkins/agda-vim'

" snipmate and dependencies
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'reasonml/vim-reason-loader'
NeoBundle 'derekelkins/agda-vim'

" All of your Plugins must be added before the following line
call neobundle#end()         " required
filetype plugin indent on    " required
NeoBundleCheck

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
colorscheme one " solarized
set background=dark

let mapleader = ","

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

nnoremap ' `
nnoremap ` '

" Yank from cursor to end of line
nnoremap Y y$

" Search and replace word under cursor (,*)
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

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

" Commands
" In the commands,
" <silent> prevents a message from being printed
" <CR> prevents us having to type enter

" Show whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

nmap <silent> <leader>d :NERDTreeToggle<CR>

nmap <silent> <leader>t :TlistToggle<CR>

" Edit .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
" Reload .vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>

augroup configgroup
  " clear all autocmds for the current group
  autocmd!

  "Automatically change current directory to that of the file in the buffer
  autocmd BufEnter * cd %:p:h

  " strip trailing whitespace on save
  autocmd BufWritePre <buffer> :%s/\s\+$//e

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
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
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

" haskell mode
" au Bufenter *.hs compiler ghc
" autocmd BufWritePost *.hs GhcModCheckAndLintAsync
" autocmd BufWritePost *.lhs GhcModCheckAndLintAsync

" ctrlp
nmap ; :CtrlPBuffer<CR>
" Enable cross-session caching
let g:ctrlp_clear_cache_on_exit = 0

" syntastic
let g:syntastic_check_on_open=0
let g:syntastic_echo_current_error=1
let g:syntastic_enable_signs=1
let g:syntastic_enable_highlighting=1
let g:syntastic_auto_jump=0
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=10
" let g:syntastic_javascript_checkers = ['eslint', 'flow']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_gjslint_conf=" --nojsdoc"

" purescript
let g:purescript_indent_if = 0
let g:purescript_indent_case = 2

" react
let g:jsx_ext_required = 0

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

" TODO - figure out how this was broken by solarized
hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}

" `:R` jumps to the definition of the class you're currently in
" `:R <code>` jumps to the method for that code (ex. `:R gdp`)
" `:R! <code>` jumps to the method, and creates it if it doesn't already exist

function! s:CodeToFunctionName(code)
  if a:code == "cdm"
    return "componentDidMount"
  elseif a:code == "cdup"
    return "componentDidUpdate"
  elseif a:code == "cwm"
    return "componentWillMount"
  elseif a:code == "cwr"
    return "componentWillReceiveProps"
  elseif a:code == "cwun"
    return "componentWillUnmount"
  elseif a:code == "cwu"
    return "componentWillUpdate"
  elseif a:code == "gdp"
    return "getDefaultProps"
  elseif a:code == "gis"
    return "getInitialState"
  elseif a:code == "pt"
    return "propTypes"
  elseif a:code == "r"
    return "render"
  elseif a:code == "scu"
    return "shouldComponentUpdate"
  endif
endfunction

" so sophisticated
function! s:IsFunction(name)
  return !(a:name == "propTypes")
endfunction

function! s:CreateMethod(name)
  if s:IsFunction(a:name)
    exec "normal! o" . a:name . ": function() {"
  else
    exec "normal! o" . a:name . ": {"
  endif
  normal! o},
  normal! o
  normal! k
  call feedkeys("O", 'n')
endfunction

function! s:React(...)
  " assume happy path for now...
  let argCount = a:0
  let l:winview = winsaveview()
  normal! m'
  normal! +
  keepjumps call search("React.createClass", "b")
  if argCount == 1
    " no args means go to the definition
    return
  endif
  let startingLine = line(".")
  keepjumps normal! $%
  let endingLine = line(".")
  keepjumps normal! %

  let isBang = a:1
  let requestedCode = a:2

  let functionName = s:CodeToFunctionName(requestedCode)
  let found = search(functionName . ":", "c", endingLine)
  if found == 0
    if isBang
      call s:CreateMethod(functionName)
    else
      keepjumps normal! ''
      call winrestview(l:winview)
      echo "This class does not have " . functionName . ", call with ! to create"
    endif
  else
    normal! zz
  endif
endfunction


command! -nargs=* -bang R call s:React("<bang>"=="!", <f-args>)

" not very smart yet...
function! s:ReactExtract(start, end)
  call inputsave()
  let name = input('Extract to component named: ')
  call inputrestore()
  echo a:start
  echo a:end
endfunction


command! -range Rex call s:ReactExtract(<line1>, <line2>)

" enable % to jump to matching JSX tags (if you have matchit enabled)
runtime macros/matchit.vim

function! s:SetupJsxMatching()
  let b:match_ignorecase = 0
  let b:match_words = '(:),\[:\],{:},<:>,' .
        \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endfunction

autocmd FileType javascript call s:SetupJsxMatching()
autocmd BufRead,BufNewFile *.md setlocal spell

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
