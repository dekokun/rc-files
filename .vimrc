" �������W�X�^�ɓ���f�[�^���A*���W�X�^�ɂ������B
:set clipboard+=unnamed


" �����I��VIMRC�AGVIMRC�̐ݒ��ǂݍ��ނ悤��
augroup MyAutoCmd
    autocmd!
augroup END

if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrc�̍ēǍ����ɂ��F���ω�����悤�ɂ���
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
    " .vimrc�̍ēǍ����ɂ��F���ω�����悤�ɂ���
    autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC | 
                \if has('gui_running') | source $MYGVIMRC  
    autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif


" �L�[�}�b�s���O
"vimrc,gvimrc���ȒP�ɕҏW�ł���悤��
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>

"F5��S-F5���������Ƃɂ��ANOTEPAD���C�N�ɓ��t���}���ł���
nnoremap <F5> a<C-R>=strftime("%H:%M %Y/%m/%d")<CR>
nnoremap <S-F5> i<C-R>=strftime("%H:%M %Y/%m/%d")<CR>
inoremap <F5> <C-R>=strftime("%H:%M %Y/%m/%d")<CR>

" <C-Space>�œ��͕⊮(ruby)
imap <C-Space> <C-x><C-o>

" <Esc><Esc>�Ō����Ńn�C���C�g����Ă���̂�����
nnoremap <Esc><Esc> :noh<CR>

" Enter�ŁA���s
nnoremap  i

" Y�ŁA���̏ꏊ����Ō�܂ł������N
nnoremap Y y$

" �s���Ƃł͂Ȃ������܂܂ɏ㉺�ړ����ł���悤��
nnoremap j gj
nnoremap k gk

" yyy �őS����\��t��
" nnoremap yyy ggyG

" ���̓��[�h���ɁACtrl-f�ACtrl-b,Ctrl-n,Ctrl-p�őO��㉺�ɓ�����悤�ɁB
inoremap  <Right>
inoremap  <Left>
inoremap  <Up>
inoremap  <Down>

"s*�ƋL�����邱�Ƃɂ��A�J�[�\�����̒P���u��
nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

" ���̓��[�h����Ctrl-d��delete�L�[�Ɠ���������������
inoremap  <Del>

" ���̓��[�h���ɁACtrl-e�ACtrl-a,��������emacs�Ɠ��l�̓�����������B
inoremap  A
inoremap  I

" ��ɕ����R�[�h�Ɖ��s�R�[�h��\��
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P



"�S�p�X�y�[�X���n�C���C�g������B
function! JISX0208SpaceHilight()
    syntax match JISX0208Space "�@" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=LightCyan
endf
"syntax�̗L�����`�F�b�N���A�V�K�o�b�t�@�ƐV�K�ǂݍ��ݎ��Ƀn�C���C�g������
if has("syntax")
    syntax on
        augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    augroup END
endif


"���ꕶ��(SpecialKey)�̌����鉻�Blistchars��lcs�ł��ݒ�\�B
"trail�͍s���X�y�[�X�B
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<,eol:$


" �S�pspace��highlight�\��������
augroup ZenkakuSpace
  autocmd!
  autocmd ColorScheme * highlight ZenkakuSpace term=underline ctermbg=Red guibg=Red
  " %u3000�͑S�pspace�̕���code
  autocmd VimEnter,WinEnter * match ZenkakuSpace /\%u3000/
augroup END


