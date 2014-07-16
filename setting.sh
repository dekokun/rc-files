# zshの設定
ln -s ~/rc/.zshenv ~/.zshenv
ln -s ~/rc/.zshrc ~/.zshrc
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

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
