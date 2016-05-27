#!/bin/bash

script=$0
script_path=`pwd`

if [ "$script" != './setup.sh' ]; then
  echo "Run this script from user-profile directory as ./setup.sh"
  exit -1;
fi

read -p "Install .bash_profile ?(y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo "Installing bash_profile"
	bash_profile=~/.bash_profile
	# TODO check if its symlink to our .bash_profile
	if [ -e $bash_profile ]; then
		read -p ".bash_profile exists, append PATH to ~/bin ?(y/n): " -n 1 -r
		echo
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			echo "# added by user-profile installation on " `date` >> $bash_profile
			echo "export PATH=~/bin:$PATH" >> $bash_profile
		fi
	else
		ln -s $script_path/.bash_profile $bash_profile
	fi
  read -p "Add to .bashrc? (y/n): " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "source ~/.bash_profile" >> ~/.bashrc
  fi
fi

# install_files <list_file> <src_dir> <dst_dir>
function install_files {
	list_file=$1
	if [ ! -e $list_file ]; then
		echo "$list_file does not exist"
		return
	fi
	src_dir=$2
	dst_dir=$3
	while read -r line
	do
		ln -s $src_dir/$line $dst_dir/$line
	done < $list_file
}

echo "Installing ~/bin scripts"
mkdir ~/bin &> /dev/null
install_files install_scripts.txt $script_path ~

echo "Installing configurations"
install_files install_dotfiles.txt $script_path ~

read -p "Generate ssh key? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	./gen-ssh.sh id_rsa
fi

if type git &> /dev/null; then
	read -p "Setup git? (y/n): " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		./setup-git.sh
	fi
else
	echo "git is not installed!"
	exit -1
fi

if type vim &> /dev/null || type nvim &> /dev/null; then
	read -p "Setup vim? (y/n): " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		./setup-vim.sh
	fi
else
	echo "vim not installed, run ./install-vimrc.sh manually after it is available"
fi

