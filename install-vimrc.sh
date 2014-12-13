#!/bin/bash

script=$0

if [ "$script" != './install-vimrc.sh' ]; then
	echo $script
  echo "Run this script from user-profile directory as ./install-vimrc.sh"
  exit -1;
fi

script_path=`pwd`

cp -R .vim $HOME
ln -s $script_path/.vimrc ~/.vimrc
ln -s $script_path/vim-snippets ~/.vim/snippets

git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim

vim +BundleInstall +qall
