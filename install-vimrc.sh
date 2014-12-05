#!/bin/bash

script=$0

if [ "$script" != './install-vimrc.sh' ];
  then
  echo "Run this script from user-profile directory as ./install-vimrc.sh"
  exit -1;
fi

script_path=`pwd`

cp -R .vim $HOME
ln -s $script_path/.vimrc ~/.vimrc

git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim

vim +BundleInstall +qall
