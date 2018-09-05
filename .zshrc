[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

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
plugins=(autojump git vagrant brew zsh-syntax-highlighting)

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
# sshのlogging
alias ssh=lssh


# git checkout B  などと使う。ブランチの絞込
alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
# git checkout -b LR などと使う。リモートブランチを絞り込んでそのままリモートとローカルに展開する
alias -g LR='`git branch -a | peco --query "remotes/ " --prompt "GIT REMOTE BRANCH>" | head -n 1 | sed "s/^\*\s*//" | sed "s/remotes\/[^\/]*\/\(\S*\)/\1 \0/"`'
# git diff DF や git add DF などと使う。差分の存在するファイルの絞込
alias -g DF='`git status --short |  peco | sed -e "s/  / /" | cut -d " " -f 3`'
# git push origin master を楽しよう
alias -g O='origin'
alias -g M='master'
alias -g LS='`git ls-files | peco`'
alias -g CURRENT='`git rev-parse --abbrev-ref HEAD`'

# pecoによるインタラクティブな絞り込み
function exists { which $1 &> /dev/null }

if exists peco; then
    function peco_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N peco_select_history
    bindkey '^R' peco_select_history

    function peco-diff-file () {
    git diff $(git status --short | awk '{print $2}' | peco)
    }
    zle -N peco-diff-file
    bindkey '^xd' peco-diff-file

    # git系
    function peco-git-recent-branches () {
        local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
            perl -pne 's{^refs/heads/}{}' | \
            peco)
        if [ -n "$selected_branch" ]; then
            BUFFER="git checkout ${selected_branch}"
            zle accept-line
        fi
        zle clear-screen
    }
    zle -N peco-git-recent-branches
    bindkey '^xb' peco-git-recent-branches

    function peco-git-recent-all-branches () {
        local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads refs/remotes | \
            perl -pne 's{^refs/(heads|remotes)/}{}' | \
            peco)
        if [ -n "$selected_branch" ]; then
            BUFFER="git checkout -t ${selected_branch}"
            zle accept-line
        fi
        zle clear-screen
    }
    zle -N peco-git-recent-all-branches
    bindkey '^xa' peco-git-recent-all-branches

    # pecoでghqから絞込
    function peco-src () {
      local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
      if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
      fi
      zle clear-screen
    }
    zle -N peco-src
    bindkey '^]' peco-src
fi

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

export XDG_DATA_HOME=/usr/local/share


# The next line updates PATH for the Google Cloud SDK.
source '/Users/dekokun/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/dekokun/google-cloud-sdk/completion.zsh.inc'

source /usr/local/bin/aws_zsh_completer.sh
