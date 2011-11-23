# 言語設定
export LANG=ja_JP.UTF-8 

# emacsバインド
bindkey -e
# viバインド
#bindkey -v

# mailcheck off
export MAILCHECK=0

# umask
umask 022

# BSD用lsのカラー設定
export LSCOLORS=exfxbxdxcxegedabagacad

# OSによってlsオプションを分ける
case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G"
    ;;
linux*)
    alias ls="ls --color"
    ;;
cygwin*)
    export LS_COLORS='no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:'
    alias ls="ls --show-control-chars --color=auto"
    ;;
esac

# alias
setopt complete_aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -lh'
alias vi='vim'
alias em='emacs'
alias h='history -E -32'
alias vizsh='vi ~/.zshrc; source ~/.zshrc'
alias vivimrc='vi ~/.vimrc'
alias viemacs='vi ~/.emacs'
alias gs='git status $@'
alias gd='git diff $@'
alias ga='git add -p $@'
alias gc='git commit -v $@'
alias r=rails

# history設定
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups
setopt share_history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# zsh補完機能
autoload -U compinit
compinit

# lsの配色と補完候補の配色を合わせる
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=32' 'bd=46;34' 'cd=43;34'

# プロンプト設定
setopt prompt_subst
autoload colors
colors
case ${UID} in
0)
    PROMPT="%B%{[31m%}%/#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[31m%}%/%%%{[m%} "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac 

# TABで変換候補切り替え
setopt auto_menu

# cdコマンド無しでディレクトリ移動
setopt auto_cd

# cd - でディレクトリ移動可能
setopt auto_pushd

# cd - 候補かぶってるのは無視する
setopt pushd_ignore_dups

# コマンドチェック
setopt correct

# 候補を詰めて表示 
setopt list_packed

# 候補が無い場合にビープ音鳴らさない
setopt nolistbeep 

# /を勝手に削除しない
setopt noautoremoveslash

# ターミナルの枠表示
case "${TERM}" in
screen)
    preexec(){
        echo -ne "\ek$1\e\\"
    }
    precmd(){
        echo -ne "\ek$(basename $SHELL)\e\\"
    }
    ;;
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}:${PWD}\007"
    }
    ;;
esac

# nvm と指定されたバージョンの Node.js がインストール済みの場合だけ
# 設定を有効にする
if [[ -f ~/.nvm/nvm.sh ]]; then
  source ~/.nvm/nvm.sh

  if which nvm >/dev/null 2>&1 ;then
    _nodejs_use_version="v0.4.12"
    if nvm ls | grep -F -e "${_nodejs_use_version}" >/dev/null 2>&1 ;then
      nvm use "${_nodejs_use_version}" >/dev/null
    fi
    unset _nodejs_use_version
  fi
fi

#SCREEN起動
if [ $TERM != "screen" ]; then
    exec screen -S main -xRR
fi 
# 各環境依存の設定読み込み
[ -f $HOME/.zshrc.mine ] && source $HOME/.zshrc.mine
