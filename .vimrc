" Filename: .vimrc
" Last Change: 31-Dec-2011.
" Maintainer: furu


if has('win32') || has('win64')
  let $DOTVIM = expand('~/vimfiles')
else
  let $DOTVIM = expand('~/.vim')
endif

if !exists($MYGVIMRC)
  let $MYGVIMRC = expand('~/.gvimrc')
endif

" Use English interface.
if has('win32') || has('win64')
  " For Windows.
  language message en
else
  " For Linux.
  language message C
endif

" viとの互換性を取らない(vim独自拡張機能を使うため)
set nocompatible
filetype off

"-------------------------------------------
" Setting of the NeoBundle.
"-------------------------------------------
if has('vim_starting')
  set runtimepath+=$DOTVIM/bundle/neobundle.vim
  call neobundle#rc(expand('$DOTVIM/bundle'))
endif

NeoBundle 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/echodoc'
NeoBundle 'Shougo/vimfiler'
" NeoBundle 'motemen/hatena-vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tsaleh/vim-matchit'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
" NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-surround'
" NeoBundle 'tpope/vim-endwise'
NeoBundle 'kana/vim-smartchr'
" NeoBundle 'h1mesuke/unite-outline'
" NeoBundle 'vim-scripts/IndentAnything'
NeoBundle 'jmatraszek/vim-wombat'
NeoBundle 'vim-scripts/wombat256.vim'
" NeoBundle 'othree/html5.vim'
" NeoBundle 'ujihisa/neco-ruby'
" NeoBundle 'pocket7878/presen-vim'
" NeoBundle 'pocket7878/curses-vim'
NeoBundle 'vim-scripts/autodate.vim'
" NeoBundle 'tyru/eskk.vim'
" NeoBundle 'tyru/skk.vim'
" NeoBundle 'ujihisa/vital.vim'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'mattn/unite-advent_calendar'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'choplin/unite-vim_hacks'

filetype plugin indent on


"-------------------------------------------
" Set augroup.
"-------------------------------------------
augroup MyAutoCmd
  autocmd!
augroup END


if !exists('g:colors_name') && !has('gui_running')
  " use 256 colors in terminal.
  set t_Co=256
  "colorscheme wombat256
  colorscheme wombat256mod
endif


"-------------------------------------------
" Basic
"-------------------------------------------
" シンタックスカラー(オン)
syntax enable
" バックアップを作成しない
set nobackup
" スワップファイルを作成しない
set noswapfile
" 編集中でも他のファイルを開ける
set hidden
" <BS>でindent,eol,startを消せる
set backspace=indent,eol,start
" 行番号の表示
set number
" タイトルバーにファイル名を表示
set title
" クリップボード
set clipboard& clipboard+=unnamed
" ルーラーを表示
set ruler
" 折り返しを有効
set wrap
" 開いているファイルのディレクトリに移動
" あまり推奨されないっぽい
" -> 代わりにカレントディレクトリ移動のためのキーマッピングを定義した
" set autochdir
" 
set showmatch
" 閉じ括弧のマッチを表示する時間(1/10秒単位)
set matchtime=2
" コマンド補完を強化
set wildmenu
" カーソルが行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" スクロール時の余白確保
set scrolloff=5
" ビープを鳴らさない
"set visualbell t_vb=
" 他で書き換えられたら自動で読みなおす
set autoread
" コマンドラインの高さ
set cmdheight=2
" 常にステータスラインを表示
set laststatus=2
" ステータスラインに文字コード、改行コード、ファイルタイプなどを表示する
set statusline=%<%f\ %r%h%w%m[%{&fenc!=''?&fenc:&enc}][%{&ff=='unix'?'LF':&ff=='dos'?'CRLF':'CR'}]\ %y\ %=[0x%B]\ %c,%l/%L
" 
set list
" 
set listchars=tab:>-,eol:$
" 画面最後の行をできる限り表示する
set display=lastline
" □や◯の文字があってもカーソル位置がずれないようにする
set ambiwidth=double

" Mouse {{{
" Enable mouse support.
set mouse=a

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
" タブの表示幅
set tabstop=4
" 
set softtabstop=4
" 自動インデント時の空白の数
set shiftwidth=4
" タブをスペースにする
set expandtab
" default indent settings
set cindent
" }}}

" カレント行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く{{{
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" hi clear CursorLine
" hi CursorLine gui=underline
" highlight CursorLine ctermbg=black guibg=black
" }}}

" 改行コード
if has('win32') || has('win64')
  set fileformat=dos
  set fileformats=dos,unix,mac
else
  set fileformat=unix
  set fileformats=unix,dos,mac
endif

" 全角スペースを強調表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermbg=darkgrey gui=underline guifg=darkgrey
  silent! match ZenkakuSpace /　/
endfunction
" if has('syntax')
"   augroup ZenkakuSpace
"     autocmd!
"     autocmd VimEnter,BufEnter * call ZenkakuSpace()
"   augroup END
" endif


"-------------------------------------------
" Search
"-------------------------------------------
" 最後まで検索したら先頭へ戻る
set wrapscan
" 大文字小文字を無視
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索
set smartcase
" インクリメントサーチ
set incsearch
" 検索文字をハイライト
set hlsearch


" カーソルを表示行で移動
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" 1画面ずつページ送り
noremap <Space>j <C-f>
noremap <Space>k <C-b>

" ノーマルモードで挿入モードにならず現在の行の下に空行を挿入する
" その際、インデントやコメントの自動挿入は行われない
" Oを使うので、現在の行の上に空行を挿入することができなくなるけど、あんまり使わないのでOK
nnoremap <silent> O :<C-u>call append(expand('.'), '')<CR>j

" ヘルプを引く
nnoremap <C-h> :<C-u>help<Space>
" カーソル下のキーワードを:helpで引く
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

" 最後に選択したテキストの選択
nnoremap gc '[v']
vnoremap gc :<C-u>normal gc<CR>
onoremap gc :<C-u>normal gc<CR>

" バッファ一覧を表示し、番号を入力することでバッファを切り替える
" nnoremap <Space>b :ls<Enter>:buffer<Space>

" 自動で挿入されたインデントが、何も入力せずにインサートモードを抜けたり、さらに新しい行を作ったりした場合に削除されないようにする
nnoremap o oX<C-h>
inoremap <CR> <CR>X<C-h>

" key-mapping for nohlsearch
nnoremap <Esc><Esc> :nohlsearch<CR>

" key-mapping for edit .vimrc/.gvimrc
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg :<C-u>edit $MYGVIMRC<CR>

nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>

" auto reload .vimrc and .gvimrc when I edited .vimrc or .gvimrc. {{{
if !has('gui_running') && !(has('win32') || has('win64'))
 autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
 autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC |
\ if has('gui_running') | source $MYGVIMRC
 autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif
"}}}


" reload with encoding.
command! -bang -bar -complete=file -nargs=? Cp932 edit ++enc=cp932
command! -bang -bar -complete=file -nargs=? EucJp edit ++enc=euc-jp
command! -bang -bar -complete=file -nargs=? Iso2022jp edit ++enc=iso-2022-jp
command! -bang -bar -complete=file -nargs=? Utf8 edit ++enc=utf-8
" Aliases
command! -bang -bar -complete=file -nargs=? Jis Iso2022jp
command! -bang -bar -complete=file -nargs=? Sjis Cp932

" check defined mappings. {{{
command!
      \ -nargs=* -complete=mapping
      \ AllMaps
      \ map <args> | map! <args> | lmap <args>
"}}}

" Scouter {{{
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines, 'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
      \ echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
command! -bar -bang -nargs=? -complete=file GScouter
      \ echo Scouter(empty(<q-args>) ? $MYGVIMRC : expand(<q-args>), <bang>0)
"}}}

" Open junk file."{{{
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
  let l:junk_dir = $HOME . '/.vim_junk' . strftime('/%Y/%m')
  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif

  let l:filename = input('Junk Code: ', l:junk_dir . strftime('/%Y-%m-%d-%H%M%S.'))
  if l:filename != ''
    execute 'edit ' . l:filename
  endif
endfunction "}}}

" Change current directory. {{{
command! -nargs=? -complete=dir -bang CD call s:ChangeCurrentDir('<args>', '<bang>')
" change current directory. 
nnoremap <silent> <Space>cd :<C-u>CD<CR>
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction "}}}

" mv editing file (from sorah's vimrc) {{{
function! s:mv_editing_file(new_file_name)
  call system("mv".expand('%')." ".a:new_file_name)
  edit a:new_file_name
endfunction
command! -nargs=1 Rename call g:mv_editing_file(<f-args>)
" }}}


augroup MyTab
  autocmd!
  autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType scss setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END


"-------------------------------------------
" Setting of the necomplcache.
"-------------------------------------------
" 起動時に有効にする
let g:neocomplcache_enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視
let g:neocomplcache_enable_smart_case = 1
" _区切りの補完を有効化する
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
" キーdefaultのパターンのデフォルトが\k\+となっていて，日本語も収集してしまうのでしないように変更
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" タブで補完
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
" <C-h>、<BS>を押したときに確実にポップアップを削除する
inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<C-h>"
" <C-e> : 現在選択している候補をキャンセルし、ポップアップを閉じる
inoremap <expr><C-e> neocomplcache#cancel_popup()
" <C-y> : 補完を選択し、ポップアップを閉じる
inoremap <expr><C-y> neocomplcache#close_popup()
" <C-s> : スニペット展開
imap <C-s> <Plug>(neocomplcache_snippets_expand)
smap <C-s> <Plug>(neocomplcache_snippets_expand)

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:rsenseUseOmniFunc = 1
if filereadable(expand('~/opt/rsense-0.3/bin/rsense'))
  let g:rsenseHome = expand('~/opt/rsense-0.3')
  let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
endif
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'


"-------------------------------------------
" Setting of the surround.
"-------------------------------------------
"nmap s <Plug>Ysurround
"nmap ss <Plug>Yssurround


"-------------------------------------------
" Setting of the NERDCommenter.
"-------------------------------------------
" Default key-mappings off.
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
" My key-mappings define.
nmap <Leader>cc <Plug>NERDCommenterToggle
vmap <Leader>cc <Plug>NERDCommenterToggle
nmap <Leader>cm <Plug>NERDCommenterMinimal
vmap <Leader>cm <Plug>NERDCommenterMinimal
nmap <Leader>ca <Plug>NERDCommenterAppend
nmap <Leader>c$ <Plug>NERDCommenterToEOL
vmap <Leader>cs <Plug>NERDCommenterSexy


"-------------------------------------------
" Setting of the vimshell.
"-------------------------------------------


"-------------------------------------------
" Setting of the ref.vim.
"-------------------------------------------
" let g:ref_alc_start_linenumber = 50
autocmd FileType ref call s:initialize_ref_viewer()
function! s:initialize_ref_viewer()
  nmap <buffer> b <Plug>(ref-back)
  nmap <buffer> f <Plug>(ref-forward)
  nnoremap <buffer> q <C-w>c
  setlocal nonumber
endfunction


"-------------------------------------------
" Setting of the hatena-vim.
"-------------------------------------------
" let g:hatena_user='furu33'


"-------------------------------------------
" Setting of the echodoc.
"-------------------------------------------
let g:echodoc_enable_at_startup = 1


"-------------------------------------------
" Setting of the unite.vim.
"-------------------------------------------
nnoremap <silent> ,b :<C-u>Unite -buffer-name=files buffer_tab<CR>
nnoremap <silent> ,f :<C-u>Unite -buffer-name=files file<CR>
nnoremap <silent> ,r :<C-u>Unite -buffer-name=files file_mru<CR>


"-------------------------------------------
" Setting of the quickrun.vim.
"-------------------------------------------
let g:quickrun_config = {}
" For RSpec
let g:quickrun_config['ruby.rspec'] = {
            \'command': 'rspec',
            \'cmdopt': '-fs',
            \}
augroup FuruRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END


"-------------------------------------------
" Setting of the vimfiler.
"-------------------------------------------
let g:vimfiler_as_default_explorer = 1


"-------------------------------------------
" Setting of the smartchr.
"-------------------------------------------
autocmd MyAutoCmd FileType ruby inoremap <buffer> <expr> { smartchr#loop('{', '#{')
" inoremap <expr> = smartchr#loop(' = ', '=', ' == ')
