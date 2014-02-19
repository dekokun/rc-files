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
plugins=(autojump git svn vagrant brew)

source $ZSH/oh-my-zsh.sh
# export PROMPT="%{$fg_bold[blue]%}${HOST} $PROMPT"

# Customize to your needs...
#
bindkey -e

# BSD用lsのカラー設定
export LSCOLORS=Gxfxbxdxcxegedabagacad
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
alias gs='git status --short --branch $@'
alias gb='git branch'
# alias ga='git add'
alias gc='git commit'
alias gC='git commit --amend'
alias gco='git checkout'
alias gd='git diff --color-words $@'
alias gD='git diff --cached'
alias gl='git log'
alias r=rails
alias t=todo

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

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
