# homebrew
`dirname $0`/homebrew.sh

## bashrc
ln -s ~/rc/.bashrc ~/.bashrc
ln -s ~/rc/.bash_profile ~/.bash_profile

# zshの設定
ln -s ~/rc/.zshenv ~/.zshenv
ln -s ~/rc/.zshrc ~/.zshrc
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# gitの設定
ln -s ~/rc/.gitconfig ~/.gitconfig
touch ~/.gitconfig.local
ln -s ~/rc/.gitignore_global ~/.gitignore_global
ln -s ~/rc/.gitattributes_global ~/.gitattributes_global

# vimperatorの設定
git clone https://github.com/dekokun/vimperator-setting.git ~/.vimperator
ln -s ~/.vimperator/.vimperatorrc ~/.vimperatorrc

# vimの設定
git clone https://github.com/dekokun/vimruntime.git ~/.vim
ln -s ~/.vim/.vimrc ~/.vimrc
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim +"NeoBundleInstall" +"q"
git config --global core.editor '/usr/bin vim'

# tmux
ln -s ~/rc/.tmux.conf ~/.tmux.conf
(
  cd /tmp
  git clone https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
  cd tmux-MacOSX-pasteboard
  make
  cp reattach-to-user-namespace ~/bin/
)

# autojump
if [ -f `brew --prefix`/share/zsh/site-functions/_j ]; then
  ln -s `brew --prefix`/share/zsh/site-functions/_j ~/.oh-my-zsh/plugins/autojump/_j
else
  echo 'please install autojump with homebrew'
fi

# peco
(
    brew install go
    go get peco
)

# intellijIDEAの設定
ln -s ~/rc/.ideavimrc ~/.ideavimrc

# Ruby系セッティング
# rbenvはhomebrewがいれている前提
rbenv install 2.1.3
rbenv global 2.1.3
gem install bundler

## Node系セッティング
# nodebrewはhomebrewがいれている前提
nodebrew install stable
nodebrew use stable
