" �^�u���X�y�[�X�ɕϊ�
set expandtab
" �^�u�̉�ʏ�ł̕�
set ts=4
" �I�[�g�C���f���g���̃^�u��
set shiftwidth=4
"�������Ƃ��ɍs�ԍ���t�^����
set printoptions=number:y
" �J���[�ݒ�:
colorscheme torte

"�o�b�N�A�b�v�t�@�C���t�H���_


if has('gui_macvim')
    set transparency=10 " �����x���w��
    set antialias
    set guioptions-=t   " �c�[���o�[��\��
    set guioptions-=r   " �E�X�N���[���o�[��\��
    set guioptions-=R
    set guioptions-=l   " ���X�N���[���o�[��\��
    set guioptions-=L
    set guifont=Osaka-Mono:h14
    set imdisable       " IM�𖳌���
endif

" �O��̃E�C���h�E�̑傫���Əꏊ���o���Ă���
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
