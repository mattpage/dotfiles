#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

PACKAGES_NEEDED="\
    fzf \
    ripgrep \
    fuse \
    universal-ctags \
    neovim \
    yamllint"

if ! dpkg -s ${PACKAGES_NEEDED} > /dev/null 2>&1; then
    if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
        sudo apt-get update
    fi
    sudo echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
    sudo apt-get -y -q install ${PACKAGES_NEEDED}
fi

sudo modprobe fuse
sudo groupadd fuse
sudo usermod -a -G fuse "$(whoami)"

curl -fsSL https://raw.githubusercontent.com/mattpage/vimfiles/main/.vimrc -o $(pwd)/vimrc

ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/vim $HOME/.vim
ln -s $(pwd)/screenrc $HOME/.screenrc

rm -f $HOME/.zshrc
ln -s $(pwd)/zshrc $HOME/.zshrc

rm -rf $HOME/.config
mkdir $HOME/.config
ln -s "$(pwd)/config/nvim" "$HOME/.config/nvim"

mkdir -p $(pwd)/vim/backup $(pwd)/vim/colors

mkdir $HOME/vim-sessions

# vim -Es -u $HOME/.vimrc -c "PlugInstall | qa"

sudo chsh -s "$(which zsh)" "$(whoami)"
source $HOME/.zshrc

# some git settings
git config --global init.defaultBranch main
git config --global push.default simple
git config --global push.autoSetupRemote true
git config --global commit.gpgsign false
