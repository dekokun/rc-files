" 無名レジスタに入るデータを、*レジスタにも入れる。
:set clipboard+=unnamed


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


" キーマッピング
"vimrc,gvimrcを簡単に編集できるように
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>

"F5やS-F5を押すことにより、NOTEPADライクに日付が挿入できる
nnoremap <F5> a<C-R>=strftime("%H:%M %Y/%m/%d")<CR>
nnoremap <S-F5> i<C-R>=strftime("%H:%M %Y/%m/%d")<CR>
inoremap <F5> <C-R>=strftime("%H:%M %Y/%m/%d")<CR>

" <C-Space>で入力補完(ruby)
imap <C-Space> <C-x><C-o>

" <Esc><Esc>で検索でハイライトされているのを消す
nnoremap <Esc><Esc> :noh<CR>

" Enterで、改行
nnoremap 
 i


" Yで、その場所から最後までをヤンク
nnoremap Y y$

" 行ごとではなく見たままに上下移動ができるように
nnoremap j gj
nnoremap k gk

" yyy で全部を貼り付け
" nnoremap yyy ggyG

" 入力モード中に、Ctrl-f、Ctrl-b,Ctrl-n,Ctrl-pで前後上下に動けるように。
inoremap  <Right>
inoremap  <Left>
inoremap  <Up>
inoremap  <Down>

"s*と記入することにより、カーソル下の単語を置換
nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

" 入力モード中にCtrl-dでdeleteキーと同じ動きをさせる
inoremap  <Del>

" 入力モード中に、Ctrl-e、Ctrl-a,押下時にemacsと同様の動きをさせる。
inoremap  A
inoremap  I

" 常に文字コードと改行コードを表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P



"全角スペースをハイライトさせる。
function! JISX0208SpaceHilight()
    syntax match JISX0208Space "　" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=LightCyan
endf
"syntaxの有無をチェックし、新規バッファと新規読み込み時にハイライトさせる
if has("syntax")
    syntax on
        augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    augroup END
endif


"特殊文字(SpecialKey)の見える化。listcharsはlcsでも設定可能。
"trailは行末スペース。
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<,eol:$


" 全角spaceをhighlight表示させる
augroup ZenkakuSpace
  autocmd!
  autocmd ColorScheme * highlight ZenkakuSpace term=underline ctermbg=Red guibg=Red
  " %u3000は全角spaceの文字code
  autocmd VimEnter,WinEnter * match ZenkakuSpace /\%u3000/
augroup END


