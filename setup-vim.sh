#!/bin/bash

script=$0

if [ "$script" != './setup-vim.sh' ]; then
	echo $script
  echo "Run this script from user-profile directory as ./setup-vim.sh"
  exit -1;
fi

script_path=`pwd`

cp -R .vim $HOME
ln -s $script_path/.vimrc ~/.vimrc
ln -s $script_path/.vimrc ~/.nvimrc
ln -s $script_path/vim-snippets ~/.vim/snippets

mkdir -p $HOME/.config
ln -s $HOME/.vim $HOME/.config/nvim

git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim

if type vim &> /dev/null; then
  vim_exec=vim
elif type nvim &> /dev/null; then
  vim_exec=nvim
else
  echo "Vim not found, install it and run 'vim +BundleInstall +qall' to finish installation"
  exit -1
fi
vim +BundleInstall +qall
