" –³–¼ƒŒƒWƒXƒ^‚É“ü‚éƒf[ƒ^‚ğA*ƒŒƒWƒXƒ^‚É‚à“ü‚ê‚éB
:set clipboard+=unnamed


" ©“®“I‚ÉVIMRCAGVIMRC‚Ìİ’è‚ğ“Ç‚İ‚Ş‚æ‚¤‚É
augroup MyAutoCmd
    autocmd!
augroup END

if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrc‚ÌÄ“Ç‚É‚àF‚ª•Ï‰»‚·‚é‚æ‚¤‚É‚·‚é
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
    " .vimrc‚ÌÄ“Ç‚É‚àF‚ª•Ï‰»‚·‚é‚æ‚¤‚É‚·‚é
    autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC | 
                \if has('gui_running') | source $MYGVIMRC  
    autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif


" ƒL[ƒ}ƒbƒsƒ“ƒO
"vimrc,gvimrc‚ğŠÈ’P‚É•ÒW‚Å‚«‚é‚æ‚¤‚É
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>

"F5‚âS-F5‚ğ‰Ÿ‚·‚±‚Æ‚É‚æ‚èANOTEPADƒ‰ƒCƒN‚É“ú•t‚ª‘}“ü‚Å‚«‚é
nnoremap <F5> a<C-R>=strftime("%H:%M %Y/%m/%d")<CR>
nnoremap <S-F5> i<C-R>=strftime("%H:%M %Y/%m/%d")<CR>
inoremap <F5> <C-R>=strftime("%H:%M %Y/%m/%d")<CR>

" <C-Space>‚Å“ü—Í•âŠ®(ruby)
imap <C-Space> <C-x><C-o>

" <Esc><Esc>‚ÅŒŸõ‚ÅƒnƒCƒ‰ƒCƒg‚³‚ê‚Ä‚¢‚é‚Ì‚ğÁ‚·
nnoremap <Esc><Esc> :noh<CR>

" Enter‚ÅA‰üs
nnoremap  i

" Y‚ÅA‚»‚ÌêŠ‚©‚çÅŒã‚Ü‚Å‚ğƒ„ƒ“ƒN
nnoremap Y y$

" s‚²‚Æ‚Å‚Í‚È‚­Œ©‚½‚Ü‚Ü‚Éã‰ºˆÚ“®‚ª‚Å‚«‚é‚æ‚¤‚É
nnoremap j gj
nnoremap k gk

" yyy ‚Å‘S•”‚ğ“\‚è•t‚¯
" nnoremap yyy ggyG

" “ü—Íƒ‚[ƒh’†‚ÉACtrl-fACtrl-b,Ctrl-n,Ctrl-p‚Å‘OŒãã‰º‚É“®‚¯‚é‚æ‚¤‚ÉB
inoremap  <Right>
inoremap  <Left>
inoremap  <Up>
inoremap  <Down>

"s*‚Æ‹L“ü‚·‚é‚±‚Æ‚É‚æ‚èAƒJ[ƒ\ƒ‹‰º‚Ì’PŒê‚ğ’uŠ·
nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

" “ü—Íƒ‚[ƒh’†‚ÉCtrl-d‚ÅdeleteƒL[‚Æ“¯‚¶“®‚«‚ğ‚³‚¹‚é
inoremap  <Del>

" “ü—Íƒ‚[ƒh’†‚ÉACtrl-eACtrl-a,‰Ÿ‰º‚Éemacs‚Æ“¯—l‚Ì“®‚«‚ğ‚³‚¹‚éB
inoremap  A
inoremap  I

" í‚É•¶šƒR[ƒh‚Æ‰üsƒR[ƒh‚ğ•\¦
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P



"‘SŠpƒXƒy[ƒX‚ğƒnƒCƒ‰ƒCƒg‚³‚¹‚éB
function! JISX0208SpaceHilight()
    syntax match JISX0208Space "@" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=LightCyan
endf
"syntax‚Ì—L–³‚ğƒ`ƒFƒbƒN‚µAV‹Kƒoƒbƒtƒ@‚ÆV‹K“Ç‚İ‚İ‚ÉƒnƒCƒ‰ƒCƒg‚³‚¹‚é
if has("syntax")
    syntax on
        augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    augroup END
endif


"“Áê•¶š(SpecialKey)‚ÌŒ©‚¦‚é‰»Blistchars‚Ílcs‚Å‚àİ’è‰Â”\B
"trail‚Ís––ƒXƒy[ƒXB
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<,eol:$


" ‘SŠpspace‚ğhighlight•\¦‚³‚¹‚é
augroup ZenkakuSpace
  autocmd!
  autocmd ColorScheme * highlight ZenkakuSpace term=underline ctermbg=Red guibg=Red
  " %u3000‚Í‘SŠpspace‚Ì•¶šcode
  autocmd VimEnter,WinEnter * match ZenkakuSpace /\%u3000/
augroup END


