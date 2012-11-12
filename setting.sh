# zshの設定
ln -s ~/rc/.zshenv ~/.zshenv
ln -s ~/rc/.zshrc ~/.zshrc
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# vimperatorの設定
git clone git@github.com:dekokun/vimperator-setting.git ~/.vimperator
ln -s ~/.vimperator/.vimperatorrc ~/.vimperatorrc

# vimの設定
git clone git@github.com:dekokun/vimruntime.git ~/.vim
ln -s ~/.vim/.vimrc ~/.vimrc
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim +"NeoBundleInstall" +"q"
