#!/bin/bash

script=$0

if [ "$script" != './install-vimrc.sh' ];
  then
  echo "Run this script as ./install-vimrc.sh"
  exit -1;
fi

home_path=$HOME
cp -R .vim $home_path
cp .vimrc $home_path

git clone https://github.com/gmarik/vundle $home_path/.vim/bundle/vundle

vim +BundleInstall +qall
