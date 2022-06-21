#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

# switch shells
sudo chsh -s "$(which zsh)" "$(whoami)"

mkdir -p $(pwd)/vim/backup $(pwd)/vim/bundle $(pwd)/vim/colors $(pwd)/vim-sessions

# install a bunch of vim plugins
git clone https://github.com/altercation/vim-colors-solarized.git $(pwd)/vim/bundle/vim-colors-solarized
git clone https://github.com/scrooloose/nerdtree.git $(pwd)/vim/bundle/nerdtree
git clone https://github.com/vim-scripts/bufexplorer.zip.git $(pwd)/vim/bundle/bufexplorer.zip
git clone https://github.com/rbgrouleff/bclose.vim.git $(pwd)/vim/bundle/bclose.vim
git clone https://github.com/w0rp/ale.git $(pwd)/vim/bundle/ale
git clone https://github.com/junegunn/fzf.vim $(pwd)/vim/bundle/fzf.vim
git clone https://github.com/jremmen/vim-ripgrep.git $(pwd)/vim/bundle/vim-ripgrep
git clone https://github.com/tpope/vim-commentary.git $(pwd)/vim/bundle/vim-commentary
git clone https://github.com/pangloss/vim-javascript.git $(pwd)/vim/bundle/vim-javascript
git clone https://github.com/mxw/vim-jsx.git $(pwd)/vim/bundle/vim-jsx
git clone https://github.com/ajh17/VimCompletesMe.git $(pwd)/vim/bundle/VimCompletesMe
git clone https://github.com/ludovicchabant/vim-gutentags.git $(pwd)/vim/bundle/vim-gutentags
git clone https://github.com/itchyny/lightline.vim $(pwd)/vim/bundle/lightline.vim
git clone https://github.com/tpope/vim-rails.git $(pwd)/vim/bundle/vim-rails
git clone https://github.com/tpope/vim-fugitive.git $(pwd)/vim/bundle/vim-fugitive
git clone https://github.com/tpope/vim-rhubarb.git $(pwd)/vim/bundle/vim-rhubarb
git clone https://github.com/MattesGroeger/vim-bookmarks.git $(pwd)/vim/bundle/vim-bookmarks
git clone https://github.com/bkad/CamelCaseMotion.git $(pwd)/vim/bundle/CamelCaseMotion
git clone https://github.com/vim-test/vim-test.git  $(pwd)/vim/bundle/vim-test
git clone https://github.com/tpope/vim-obsession.git  $(pwd)/vim/bundle/vim-obsession
git clone https://github.com/Yggdroot/indentLine.git $(pwd)/vim/bundle/indentLine
git clone https://github.com/ojroques/vim-oscyank.git $(pwd)/vim/bundle/vim-oscyank
# git clone https://github.com/fatih/vim-go.git $(pwd)/vim/bundle/vim-go

# install the solarized colors
cp $(pwd)/vim/bundle/vim-colors-solarized/colors/solarized.vim $(pwd)/vim/colors

sudo apt-get install -y \
  fuse fzf ripgrep npm universal-ctags yamllint

# install latest stable node
sudo npm cache clean -f
sudo npm install -g n
node_version=`node --version`
sudo ln -s "/workspaces/github/vendor/node/node-$node_version-linux-x64/lib/node_modules/n/bin/n" /usr/local/bin/n
sudo n stable

# install fzf
rm -rf $HOME/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --all

# git completion
curl -fLo $HOME/.zsh/git-completion.zsh --create-dirs https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
curl -fLo $HOME/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

# create a bunch of links
ln -sf $(pwd)/vimrc $HOME/.vimrc
ln -sf $(pwd)/vim $HOME/.vim
ln -sf $(pwd)/zshrc $HOME/.zshrc
