# zprofを使う際にコメントを戻す。zprof使う場合は.zshrcも編集必要
# zmodload zsh/zprof && zprof

# 様々な設定を行う前に各種ツールの読み込み
# nvm と指定されたバージョンの Node.js がインストール済みの場合だけ
# 設定を有効にする
if [[ -f ~/.nvm/nvm.sh ]]; then
  source ~/.nvm/nvm.sh
fi

# PerlBrew
[[ -s $HOME/perl5/perlbrew/etc/bashrc ]] && source $HOME/perl5/perlbrew/etc/bashrc

# RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

export PATH=$(brew --prefix)/bin:$HOME/.nodebrew/current/bin:/usr/local/sbin:/usr/local/bin:$PATH:~/bin:$HOME/Library/Haskell/bin:~/rc/bin
export GOPATH=~
export REPORTTIME=1
# lessを便利に。参照： http://qiita.com/delphinus/items/b04752bb5b64e6cc4ea9 
export LESS='-g -i -M -R -S -W -z-4 -x4'
export EDITOR=$(brew --prefix)/bin/vim
. "$HOME/.cargo/env"

export XDG_CONFIG_HOME=$HOME/.config

export LANG=ja_JP.UTF-8
