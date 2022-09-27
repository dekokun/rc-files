# rosetta
sudo softwareupdate --install-rosetta
# homebrew
`dirname $0`/homebrew.sh

## bashrc
ln -s ~/rc/.bashrc ~/.bashrc
ln -s ~/rc/.bash_profile ~/.bash_profile

# zshの設定
ln -s ~/rc/.zshenv ~/.zshenv
ln -s ~/rc/.zshrc ~/.zshrc
ln -s ~/rc/.zprofile ~/.zprofile

# gitの設定
ln -s ~/rc/gitconfig ~/.gitconfig
touch ~/.gitconfig.local
ln -s ~/rc/.gitignore_global ~/.gitignore_global
ln -s ~/rc/.gitattributes_global ~/.gitattributes_global
ln -s ~/rc/githooks ~/.git/hooks

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

# 各種env系
git clone https://github.com/riywo/anyenv ~/.anyenv
anyenv install --init
anyenv install plenv
anyenv install rbenv
anyenv install nodenv
# alacritty
mkdir -p ~/.config/alacritty/
ln -s ~/rc/alacritty.yml ~/.config/alacritty/alacritty.yml

# 
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# zinit
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
