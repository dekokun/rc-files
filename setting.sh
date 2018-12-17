# homebrew
`dirname $0`/homebrew.sh

## bashrc
ln -s ~/rc/.bashrc ~/.bashrc
ln -s ~/rc/.bash_profile ~/.bash_profile

# zshの設定
ln -s ~/rc/.zshenv ~/.zshenv
ln -s ~/rc/.zshrc ~/.zshrc
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
(cd ~/.oh-my-zsh/custom/plugins && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git)

# gitの設定
ln -s ~/rc/.gitconfig ~/.gitconfig
touch ~/.gitconfig.local
ln -s ~/rc/.gitignore_global ~/.gitignore_global
ln -s ~/rc/.gitattributes_global ~/.gitattributes_global

# vimfxの設定
# コレ以外にfirefoxのextensions.VimFx.config_file_directoryを設定する必要があるのに注意
mkdir ~/.config/
git clone git@github.com:dekokun/vimfx-setting.git ~/.config/vimfx

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

# for vim completor
# https://github.com/maralla/completor.vim
go get -u github.com/nsf/gocode

# intellijIDEAの設定
ln -s ~/rc/.ideavimrc ~/.ideavimrc

# 各種env系
git clone https://github.com/riywo/anyenv ~/.anyenv
anyenv install plenv
anyenv install rbenv
anyenv install ndenv

# Ruby系セッティング
rbenv install 2.1.3
rbenv global 2.1.3
gem install bundler

# Node系セッティング
# 適当に新しいものを入れておく
ndenv install v0.12.7

mkdir tools
git clone https://github.com/dennishafemann/tmux-cssh.git ~/tools/tmux-cssh
ln -s ~/tools/tmux-cssh/tmux-cssh ~/bin/tssh

# alacritty
ln -s ~/rc/alacritty.yml ~/.config/alacritty/alacritty.yml
