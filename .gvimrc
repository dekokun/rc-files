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

set backup

set backupdir=$HOME\vimperator\temp

set swapfile
set directory=$HOME\vimperator\temp

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

    "�t���X�N���[�����[�h   
    set fuoptions=maxvert,maxhorz
    autocmd GUIEnter * set
    fullscreen
    colorscheme
    wombat256
endif

