# launch tmux
tmux ls > /dev/null
if [ $? -eq 1 -a -z "$TMUX" ]; then
    exec tmux
elif [ -z "$TMUX" ] ; then
    exec tmux attach
else
    echo "sessions should be nested with care."
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="crunch"


# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew zsh-syntax-highlighting fasd)

source $ZSH/oh-my-zsh.sh
# export PROMPT="%{$fg_bold[blue]%}${HOST} $PROMPT"

# Customize to your needs...
#
bindkey -e

# BSD用lsのカラー設定
export LSCOLORS=Gxfxbxdxcxegedabagacad
# lessを便利に。参照： http://qiita.com/delphinus/items/b04752bb5b64e6cc4ea9 
export LESS='-g -i -M -R -S -W -z-4 -x4'

# alias
alias o='open'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -lh'
alias vi='vim'
alias j='fasd_cd -d'
# sshのlogging
alias ssh=lssh
alias noti='terminal-notifier -message "コマンド完了"'

# git push origin master を楽しよう
alias -g O='origin'
alias -g M='master'
alias -g CURRENT='`git rev-parse --abbrev-ref HEAD`'

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
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
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups
setopt share_history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

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
eval "$(ndenv init - zsh)"
eval "$(direnv hook zsh)"

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
