" タブをスペースに変換
set expandtab
" タブの画面上での幅
set ts=4
" オートインデント時のタブ幅
set shiftwidth=4
"印刷するときに行番号を付与する
set printoptions=number:y
" カラー設定:
colorscheme torte

"バックアップファイルフォルダ


if has('gui_macvim')
    set transparency=10 " 透明度を指定
    set antialias
    set guioptions-=t   " ツールバー非表示
    set guioptions-=r   " 右スクロールバー非表示
    set guioptions-=R
    set guioptions-=l   " 左スクロールバー非表示
    set guioptions-=L
    set guifont=Osaka-Mono:h14
    set imdisable       " IMを無効化
endif

" 前回のウインドウの大きさと場所を覚えておく
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif
