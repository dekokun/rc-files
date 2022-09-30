ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/kurachishintarou/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install zsh
brew install tmux
brew install git
brew install vim
brew install gnu-sed
brew install autojump
brew install curl
brew install wget
brew install graphviz
brew install hub
brew install jq
brew install mysql
brew install reattach-to-user-namespace
brew install htop
brew install ruby-build
brew install nodebrew
brew install go
brew install jq
brew install ghq
brew install shellcheck
brew install tmux-xpanes
brew install ag
brew install fasd
brew install terminal-notifier
brew install direnv
brew install itchyny/tap/gojq
brew install starship
brew install exa
brew install nodenv
brew install gh
brew install git-delta
brew install asdf
brew install git-secrets
brew install asdf
brew install awscli
brew install helm
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
brew install oci-cli
# k8s
brew install stern
brew install kubeconform
# ricty font install
brew tap sanemat/font
brew install ricty
## (generate)
cp -f $(brew --prefix)/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf

# fzf
brew install fzf
$(brew --prefix)/opt/fzf/install --all

brew install --cask google-chrome
brew install --cask virtualbox
brew install --cask vagrant
brew install --cask karabiner-elements
brew install --cask google-japanese-ime
brew install --cask alacritty
brew install --cask visual-studio-code
brew install --cask docker
brew install --cask google-cloud-sdk
brew install --cask alfred
brew install --cask slack
brew install --cask deepl
