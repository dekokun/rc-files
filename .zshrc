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
# alias
alias o='open'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -lh'
alias vi='vim'

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
fi


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
