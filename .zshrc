# launch tmux
tmux ls > /dev/null
if [ $? -eq 1 -a -z "$TMUX" ]; then
    exec tmux new -s "default session"
elif [ -z "$TMUX" ] ; then
    exec tmux attach
else
    echo "sessions should be nested with care."
fi

# promptはstarshipに任せる
eval "$(starship init zsh)"
#
bindkey -e

# BSD用lsのカラー設定
export LSCOLORS=Gxfxbxdxcxegedabagacad
# lessを便利に。参照： http://qiita.com/delphinus/items/b04752bb5b64e6cc4ea9 
export LESS='-g -i -M -R -S -W -z-4 -x4'

# alias
alias g='git'
alias o='open'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias l='ls -a'
alias la='ls -a'
alias ll='ls -lah'
alias vi='vim'
alias j='fasd_cd -d'
alias jq='gojq'
# sshのlogging
alias ssh=lssh
alias noti='terminal-notifier -message "コマンド完了"'

# git push origin master を楽しよう
alias -g O='origin'
alias -g M='master'
alias -g CURRENT='`git rev-parse --abbrev-ref HEAD`'

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --exact'
autojump-fzf() {
  if [[ -z "$*" ]]; then
    cd "$(fasd_cd -d | fzf -1 -0 --no-sort --tac +m | sed 's/^[0-9,.]* *//')"
  else
    cd "$(fasd_cd -d | fzf --query="$*" -1 -0 --no-sort --tac +m | sed 's/^[0-9,.]* *//')"
  fi
  zle accept-line
}
zle -N autojump-fzf
bindkey '^j' autojump-fzf

# ghqから絞込
function ghq-src () {
  local selected_dir=$(ghq list -p | fzf +m)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N ghq-src
bindkey '^]' ghq-src

# zshのbuiltin関数のman確認
function manb() {
  man -P "less -p'^       $1 '" zshbuiltins
}

# history設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# 古いコマンドと同じものは無視
setopt hist_save_no_dups
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 補完時にヒストリを自動的に展開
setopt hist_expand
# 履歴をインクリメンタルに追加
setopt inc_append_history

# 各環境依存の設定読み込み
[ -f $HOME/.zshrc.mine ] && source $HOME/.zshrc.mine

# anyenv
if [ -d $HOME/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi


# rbevnの設定
eval "$(rbenv init - zsh)"
eval "$(plenv init - zsh)"
eval "$(direnv hook zsh)"
eval "$(nodenv init -)"

export XDG_DATA_HOME=/usr/local/share


# The next line updates PATH for the Google Cloud SDK.
source '/Users/dekokun/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/dekokun/google-cloud-sdk/completion.zsh.inc'

export PATH="$HOME/.plenv/shims:$PATH"
export PATH="$HOME/anaconda3/bin:$PATH"
source $HOME/.cargo/env

source /usr/local/bin/aws_zsh_completer.sh
fpath+=${ZDOTDIR:-~}/.zsh_functions

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zprofを使う際にコメントを戻す。その際はzshenvの変更も必要
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi
