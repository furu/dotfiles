set nocompatible

let s:is_windows = has('win32') || has('win64')
let s:is_mac = has('macunix') || (executable('uname') && system('uname') =~? '^darwin')

if s:is_windows
  let $DOTVIM = expand('~/vimfiles')
  let $TMPDIR = expand('~/vimfiles/tmp')
else
  let $DOTVIM = expand('~/.vim')
  let $TMPDIR = expand('~/.vim/tmp')
endif
if !isdirectory($TMPDIR)
  call mkdir($TMPDIR)
endif

if !exists($MYGVIMRC)
  let $MYGVIMRC = expand('~/.gvimrc')
endif

" Use English interface.
if s:is_windows
  language message en
else
  language message C
endif

if s:is_windows
  set shellslash
endif


"-------------------------------------------
" neobundle.vim
"-------------------------------------------
if has('vim_starting')
  set runtimepath+=$DOTVIM/bundle/neobundle.vim
endif
call neobundle#begin(expand('$DOTVIM/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'sgur/unite-git_grep'
NeoBundle 'rhysd/unite-codic.vim', {
      \ 'depends' : 'koron/codic-vim'
      \ }
NeoBundle 'ujihisa/unite-colorscheme'

NeoBundle 'Shougo/junkfile.vim'
NeoBundle 'Shougo/echodoc'

NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'thinca/vim-singleton'
NeoBundle 'thinca/vim-scouter'
NeoBundle 'thinca/vim-fontzoom'

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'

NeoBundle 'kana/vim-smartchr'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'kana/vim-submode'

NeoBundle 'tyru/eskk.vim'
NeoBundle 'tyru/restart.vim'

NeoBundle 'heavenshell/vim-quickrun-hook-unittest'

NeoBundle 'osyo-manga/vim-anzu'

NeoBundle 'editorconfig/editorconfig-vim'

" Color Scheme
NeoBundle 'tomasr/molokai'

" Syntax Hightlighting
NeoBundle 'zaiste/tmux.vim'
NeoBundle 'cespare/vim-toml'
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'Keithbsmiley/rspec.vim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'evidens/vim-twig'

" Build vimproc.
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
      \     'mac' : 'make -f make_mac.mak clean && make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak clean && make -f make_unix.mak',
      \    },
      \ }

call neobundle#end()

filetype plugin indent on

NeoBundleCheck


"-------------------------------------------
" macros
"-------------------------------------------
if has('vim_starting')
  runtime macros/matchit.vim
  if !has('kaoriya')
    runtime macros/encode.vim
  endif
endif


"-------------------------------------------
" singleton
"-------------------------------------------
if has('clientserver')
  call singleton#enable()
endif


"-------------------------------------------
" autocmd
"-------------------------------------------
augroup MyAutoCmd
  autocmd!
augroup END

function! s:set_indent(n)
  let &l:shiftwidth  = a:n
  let &l:softtabstop = a:n
  setlocal expandtab
endfunction
augroup MyTab
  autocmd!
  autocmd FileType ruby       call s:set_indent(2)
  autocmd FileType vim        call s:set_indent(2)
  autocmd FileType html       call s:set_indent(2)
  autocmd FileType xhtml      call s:set_indent(2)
  autocmd FileType haml       call s:set_indent(2)
  autocmd FileType css        call s:set_indent(2)
  autocmd FileType scss       call s:set_indent(2)
  autocmd FileType eruby      call s:set_indent(2)
  autocmd FileType jsp        call s:set_indent(2)
  autocmd FileType cucumber   call s:set_indent(2)
  autocmd FileType javascript call s:set_indent(4)
  autocmd FileType php        call s:set_indent(4)
augroup END

" Move cursor to last edit position.
autocmd MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd MyAutoCmd BufRead,BufNewFile *.md setlocal filetype=markdown
autocmd MyAutoCmd BufRead,BufNewFile Guardfile setlocal filetype=ruby


"-------------------------------------------
" Basic
"-------------------------------------------
syntax enable
set nobackup
set swapfile
set directory=$TMPDIR
" Remove indent, eol and start by <BS>.
set backspace=indent,eol,start
set number
" Show file name on title bar.
set title
" Use clipboard.
" set clipboard& clipboard+=unnamed
" Show cursor position.
set ruler
set wrap
set showmatch
" 閉じ括弧のマッチを表示する時間(1/10秒単位)
set matchtime=2
" コマンド補完を強化
set wildmenu
set wildignorecase
set wildmode=longest:full,full
" カーソルが行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
set autoread
set cmdheight=2
set laststatus=2
set statusline=%<%f\ %r%h%w%m[%{&fenc!=''?&fenc:&enc}][%{&ff=='unix'?'LF':&ff=='dos'?'CRLF':'CR'}]\ %y\ %=[0x%B]\ %c,%l/%L
set list
set listchars=tab:>-,eol:$
set display=lastline
set ambiwidth=double
" new windows is put right
set splitright
set textwidth=0

" Mouse {{{
" Enable mouse support.
" set mouse=a

" For screen.
if &term =~ "^screen"
  augroup MyAutoCmd
    autocmd VimLeave * :set mouse=
  augroup END
  " screenでマウスを使用するとフリーズするのでその対策
  set ttymouse=xterm2
endif

if has('gui_running')
  " Show popup menu if right click.
  set mousemodel=popup
  " Don't focus the window when the mouse pointer is moved.
  set nomousefocus
  " Hide mouse pointer on insert mode.
  set mousehide
endif
" }}}

" default tab & indent settings {{{
set softtabstop=4
set shiftwidth=4
set expandtab
" }}}

" Line feed code
set fileformat=unix
if s:is_windows
  set fileformats=dos,unix,mac
else
  set fileformats=unix,dos,mac
endif

if !exists('g:colors_name') && !has('gui_running')
  " Use 256 colors in terminal.
  set t_Co=256
  colorscheme molokai
endif

set helplang=en,ja
set formatoptions+=mM


"-------------------------------------------
" Searching
"-------------------------------------------
set wrapscan
set ignorecase
set smartcase
set incsearch
set hlsearch


"-------------------------------------------
" commands
"-------------------------------------------
" Reload with specified encoding.
command! -bang -bar -complete=file -nargs=? Cp932 edit ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? EucJp edit ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp edit ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Utf8 edit ++enc=utf-8 <args>
" Aliases
command! -bang -bar -complete=file -nargs=? Jis Iso2022jp <args>
command! -bang -bar -complete=file -nargs=? Sjis Cp932 <args>


"-------------------------------------------
" key mappings
"-------------------------------------------
" Move cursor by display lines.
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk

" For US Keybord.
noremap ; :
noremap : ;

" ノーマルモードで挿入モードにならず現在の行の下に空行を挿入する
" その際、インデントやコメントの自動挿入は行われない
" Oを使うので、現在の行の上に空行を挿入することができなくなるけど、あんまり使わないのでOK
nnoremap <silent> O :<C-u>call append(expand('.'), '')<CR>j

" :help quickly. TODO: Occur waiting for key-in.
nnoremap <C-h> :<C-u>help<Space>
" :help under cursor keyword.
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

" Select last modified text.
nnoremap gc '[v']
vnoremap gc :<C-u>normal gc<CR>
onoremap gc :<C-u>normal gc<CR>

" key-mapping for nohlsearch
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

" key-mapping for edit .vimrc/.gvimrc
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg :<C-u>edit $MYGVIMRC<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'

nnoremap <C-]> g<C-]>


"-------------------------------------------
" NERDCommenter
"-------------------------------------------
" Off default key-mappings.
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {
     \ 'haskell': {'left': '--', 'leftAlt': '{-', 'rightAlt': '-}'}
     \ }
" Define my key-mappings.
nmap <Leader>cc <Plug>NERDCommenterToggle
vmap <Leader>cc <Plug>NERDCommenterToggle
nmap <Leader>cm <Plug>NERDCommenterMinimal
vmap <Leader>cm <Plug>NERDCommenterMinimal
nmap <Leader>ca <Plug>NERDCommenterAppend
nmap <Leader>c$ <Plug>NERDCommenterToEOL
vmap <Leader>cs <Plug>NERDCommenterSexy


"-------------------------------------------
" ref
"-------------------------------------------
autocmd MyAutoCmd FileType ref call s:initialize_ref_viewer()
function! s:initialize_ref_viewer()
  nnoremap <buffer> q <C-w>c
  setlocal nonumber
endfunction
" gem install myrurema
" rurema --init
if executable('rurema')
  let g:ref_refe_cmd = ['rurema', '--no-ask']
  let g:ref_refe_version = 2
endif


"-------------------------------------------
" echodoc
"-------------------------------------------
let g:echodoc_enable_at_startup = 1


"-------------------------------------------
" unite
"-------------------------------------------
let g:unite_source_history_yank_enable = 1
let g:unite_source_git_grep_required_pattern_length = 2
nnoremap <silent> ,b :<C-u>Unite -buffer-name=files buffer_tab<CR>
nnoremap <silent> ,f :<C-u>Unite -buffer-name=files file<CR>
nnoremap <silent> ,r :<C-u>Unite -buffer-name=files file_rec/async<CR>
nnoremap <silent> ,t :<C-u>Unite tab:no-current<CR>
nnoremap <silent> ,y :<C-u>Unite history/yank<CR>
nnoremap <silent> ,g :<C-u>Unite -buffer-name=search grep<CR>
nnoremap <silent> ,o :<C-u>Unite outline<CR>
nnoremap <silent> ,a :<C-u>Unite file_rec/git:--cached:--others:--exclude-standard<CR>


"-------------------------------------------
" quickrun
"-------------------------------------------
" For RSpec
" reference: https://gist.github.com/2631964
function! BundleExecOrNot()
  if findfile('Gemfile', '.;') ==# ''
    return ''
  else
    return 'bundle exec'
  endif
endfunction

let g:quickrun_config = {}
let g:quickrun_config._ = {
      \ 'runner': 'vimproc',
      \ }
" TODO
" http://lingr.com/room/vim/archives/2014/04/26#message-18895890
" http://lingr.com/room/vim/archives/2014/04/26#message-18895905
let g:quickrun_config['ruby.rspec'] = {
      \ 'command': 'rspec',
      \ 'cmdopt': '--no-color --format documentation',
      \ 'exec': BundleExecOrNot() . ' %c %o %s',
      \ }

augroup QuickRunUnitTest
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb setlocal filetype=ruby.rspec syntax=rspec
augroup END

nnoremap <silent> <Leader>t :QuickRun -mode n -runner vimproc:updatetime=10 -hook/unittest/enable 1<CR>


"-------------------------------------------
" smartchr
"-------------------------------------------
autocmd MyAutoCmd FileType ruby inoremap <buffer> <expr> { smartchr#loop('{', '#{')


"-------------------------------------------
" eskk
"-------------------------------------------
if s:is_windows
  set imdisable
  let g:eskk#large_dictionary = {
        \'path': "C:\\skkdic\\SKK-JISYO.L",
        \'sorted': 1,
        \'encoding': 'euc-jp',
        \}
elseif s:is_mac
  let g:eskk#dictionary = {
        \'path': '/Users/furu/Library/Application\ Support/AquaSKK/skk-jisyo.utf8',
        \'sorted': 0,
        \'encoding': 'utf-8',
        \}
  let g:eskk#large_dictionary = {
        \'path': "/Users/furu/Library/Application\ Support/AquaSKK/SKK-JISYO.L",
        \'sorted': 1,
        \'encoding': 'euc-jp',
        \}
else
  set imdisable
  let g:eskk#large_dictionary = {
        \'path': "/usr/share/skk/SKK-JISYO.L",
        \'sorted': 1,
        \'encoding': 'euc-jp',
        \}
endif


"-------------------------------------------
" submode
"-------------------------------------------
" resize window mode {{{
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '-', '<C-w>-')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
"}}}

" switch tab mode {{{
call submode#enter_with('switchtab', 'n', '', 'gt', 'gt')
call submode#enter_with('switchtab', 'n', '', 'gT', 'gT')
call submode#map('switchtab', 'n', '', 't', 'gt')
call submode#map('switchtab', 'n', '', 'T', 'gT')
"}}}

let g:submode_keep_leaving_key = 1


"-------------------------------------------
" anzu
"-------------------------------------------
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)


"-------------------------------------------
" visualstar
"-------------------------------------------
noremap <Plug>N N
map * <Plug>(visualstar-*)<Plug>N
map # <Plug>(visualstar-#)<Plug>N
