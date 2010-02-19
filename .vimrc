" vi互換モードをオフに
set nocompatible

"filetypeの識別
filetype on
"インデント
filetype indent on
"プラグイン
filetype plugin on

" 行番号を表示する
set number

 " タブをスペースに変換する
set expandtab

 " ステータスラインになんやかや書き加える
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

 " BSでなんやかや削除できるようになる
set backspace=indent,eol,start

 "タブの幅を４目盛りに
set tabstop=4

 " オートインデント時の幅を４目盛りに
set shiftwidth=4

 "閉じ括弧を入力すると対応する括弧にフォーカスが一時的に移動
set showmatch
"上記の時間を設定
set matchtime=3

"y,pでクリップボードを操作できる
set clipboard+=unnamed

"vimrc,gvimrcを簡単に編集できるように
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>

"F5やS-F5を押すことにより、NOTEPADライクに日付が挿入できる
map <F5> a<C-R>=strftime("%H:%M %Y/%m/%d")<CR>
map <S-F5> i<C-R>=strftime("%H:%M %Y/%m/%d")<CR>

syntax on

nnoremap j gj
nnoremap k gk


let twitvim_login = "dekokun:16721672"

nnoremap  :noh

"%でdo-endやHTMLのタグの対応先にジャンプできるように
source $VIMRUNTIME/macros/matchit.vim

"自動的にインデント
set autoindent


"全角スペースを＿と表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" 自動的にVIMRC、GVIMRCの設定を読み込むように
augroup MyAutoCmd
  autocmd!
augroup END


if !has('gui_running') && !(has('win32') || has('win64'))
" .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
" .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC | 
\if has('gui_running') | source $MYGVIMRC  
    autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif


"autocomplpop.vimの色の設定
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

"F5やS-F5を押すことにより、NOTEPADライクに日付が挿入できる
nnoremap <F5> a<C-R>=strftime("%H:%M %Y/%m/%d")<CR>
nnoremap <S-F5> i<C-R>=strftime("%H:%M %Y/%m/%d")<CR>
inoremap <F5> <C-R>=strftime("%H:%M %Y/%m/%d")<CR>

" Yで、その場所から最後までをヤンク
nnoremap Y y$

" yyy で全部を貼り付け
nnoremap yyy ggyG

" 入力モード中は、emacsライクに動けるように。
inoremap  <Right>
inoremap  <Left>
inoremap  <Up>
inoremap  <Down>
inoremap  A
inoremap  I

"s*と記入することにより、カーソル下の単語を置換
nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

"特殊文字(SpecialKey)の見える化。listcharsはlcsでも設定可能。
""trailは行末スペース。
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<,eol:$

"バックアップ
set backup

"password file
source $HOME/.vimrc_local
