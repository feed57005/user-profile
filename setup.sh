#!/bin/bash

script=$0
script_path=`pwd`

if [ "$script" != './setup.sh' ]; then
  echo "Run this script from user-profile directory as ./setup.sh"
  exit -1;
fi

echo "Installing bash_profile"
bash_profile=~/.bash_profile
if [ -e $bash_profile ]; then
	echo "$bash_profile already exists adding only path"
	echo "# added by user-profile installation on " `date` >> $bash_profile
	echo "export PATH=~/bin:$PATH" >> $bash_profile
else
	ln -s $script_path/.bash_profile $bash_profile
fi

echo "Installing ~/bin scripts"
mkdir ~/bin &> /dev/null
ln -s $script_path/create-cpp-project.sh ~/bin/create-cpp-project
ln -s $script_path/bin/find-symbol ~/bin/find-symbol

echo "Installing configurations"
ln -s $script_path/.inputrc ~/.inputrc
ln -s $script_path/.tmux.conf ~/.tmux.conf
ln -s $script_path/.screenrc ~/.screenrc

if type vim &> /dev/null; then
	read -p "setup vim? (y/n/q)" -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		./install-vimrc.sh
	fi
else
	echo "vim not installed, run ./install-vimrc.sh manually after installation"
fi

read -p "generate ssh key? (y/n/q)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	./gen-ssh.sh id_rsa
fi
