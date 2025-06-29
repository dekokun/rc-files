# launch tmux
tmux ls > /dev/null
if [ "$VSCODE_INJECTION" -eq 1 ]; then
    :
elif [ $? -eq 1 -a -z "$TMUX" ]; then
    exec tmux new -s "default session"
elif [ -z "$TMUX" ] ; then
    exec tmux attach
else
    # echo "sessions should be nested with care."
    :
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
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias l='ls -a'
alias la='ls -a'
alias ll='ls -lahF'
alias vi='vim'
alias jq='gojq'
# sshのlogging
alias ssh=lssh
alias noti='terminal-notifier -message "コマンド完了"'


autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# for URL paste
autoload -U url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# lazy load
# source kubectl completion zsh is slow
kubectl() {
  unfunction "$0"
  source <(kubectl completion zsh)
  $0 "$@"
}

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

# Enhanced repo function (includes subdirectories)
repo () {
    # $HOME/src/github.com/ 下の全ディレクトリを2段階で検索
    local base_dir="$HOME/src/github.com"
    local selected_path=$(find "$base_dir" -maxdepth 2 -type d -not -path "$base_dir" | fzf -q "$*" --height 40% --border --prompt "Repository > ")
    
    if [ -n "$selected_path" ]; then
        cd "$selected_path"
    fi
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

# lazy load
rbenv() {
  unfunction "$0"
  source <(rbenv init -)
  $0 "$@"
}
plenv() {
  unfunction "$0"
  source <(plenv init -)
  $0 "$@"
}
nodenv() {
  unfunction "$0"
  source <(nodenv init -)
  $0 "$@"
}

pyenv() {
  unfunction "$0"
  eval "$(pyenv init -)"
  $0 "$@"
}

# direnv is not slow
source <(direnv hook zsh)


# The next line enables shell command completion for gcloud.
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.plenv/shims:$PATH"
export PATH="$HOME/anaconda3/bin:$PATH"
source $HOME/.cargo/env

export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

# https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-completion.html
autoload bashcompinit && bashcompinit
complete -C '$(brew --prefix)/bin/aws_completer' aws

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

source $HOME/.local/share/zinit/zinit.git/zinit.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
zinit load momo-lab/zsh-abbrev-alias # 略語を展開する
abbrev-alias -g O="origin"
abbrev-alias -g M='master'
# abbrev-alias -ge C='$(git rev-parse --abbrev-ref HEAD)'
abbrev-alias -c g=git
abbrev-alias -c claude="claude --dangerously-skip-permissions"
abbrev-alias -c gc='git commit -m"'
abbrev-alias -c j='repo'
abbrev-alias -c e="cursor ."
abbrev-alias -c er="cursor -r ."
abbrev-alias -c ej='cursor -a $(ghq list -p | fzf -q ""$@"")'
abbrev-alias -c ga="git padd"
abbrev-alias -c gs="git status"
abbrev-alias -c gsw="git switch"
abbrev-alias -c gb="git branch"
abbrev-alias -ce gps='git push origin $(git rev-parse --abbrev-ref HEAD)'
abbrev-alias -ce gpsf='git push origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease --force-if-includes'
abbrev-alias -ce gpl='git pull origin $(git rev-parse --abbrev-ref HEAD)'
abbrev-alias -ce gpls='git stash; git pull origin $(git rev-parse --abbrev-ref HEAD);git stash pop'
abbrev-alias -c gco="git checkout"
abbrev-alias -c gcob="git checkout -b dekokun/"
abbrev-alias -c gcp="git cherry-pick"
abbrev-alias -c k=kubectl
abbrev-alias -c kx="kubectl ctx"
abbrev-alias -c kn="kubectl ns"
abbrev-alias -c kd="kubectl describe"
abbrev-alias -c kg="kubectl get"
abbrev-alias -c kdp="kubectl describe po"
abbrev-alias -c kgp="kubectl get po"
abbrev-alias -c krb="kubectl run busybox --restart=Never -it --image=busybox --rm /bin/sh"
abbrev-alias -c o=open
abbrev-alias -c n=notify
abbrev-alias -c hub=gh

zinit load mollifier/cd-gitroot
abbrev-alias -c cdu='cd-gitroot'

zinit load junegunn/fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --exact'
eval "$(fzf --zsh)"
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"


# zprofを使う際にコメントを戻す。その際はzshenvの変更も必要
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi

# remove dangerous zsh alias
disable r

eval "$(zoxide init zsh)"

local WORDCHARS='*?_[]~&;!#$%^(){}<>'

. $(brew --prefix)/opt/asdf/libexec/asdf.sh

_notify() {
  # memo: soundlist: /System/Library/Sounds/
  if [ $? -eq 0 ]; then
    osascript -e 'display notification  "Process is success !" with title "Terminal" subtitle "Success" sound name "Hero"'
    say -v Kyoko "成功しました"

  else
    osascript -e 'display notification  "Process is failed..." with title "Terminal" subtitle "Failed..." sound name "Sosumi"'
    say -v Kyoko "失敗しました"
  fi
}
alias notify=_notify

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

. "$HOME/.local/bin/env"
eval "$(uv generate-shell-completion zsh)"

# Source local settings (not tracked in git)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
