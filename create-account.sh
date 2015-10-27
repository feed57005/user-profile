#!/bin/bash

if [ $# -ne 1 ]; then
	echo "usage: $0 <username>"
	exit -1
fi

uid=$(id -u)
if [ $uid -ne 0 ]; then
	echo "Must be run as root/sudo"
	exit -1
fi

usr=$1
git_url=https://github.com/feed57005/user-profile

echo "creating user $usr"
useradd -m -s /bin/bash $usr
passwd $usr

read -p "add user to sudoers ? (y/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo "adding $usr to /etc/sudoers"
	echo "$usr ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi

read -p "install user-profile ? (y/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	if ! type git &> /dev/null; then
		echo "you need git to be installed"
		exit -1
	fi
	sudo -i -u $usr /bin/sh - <<EOF
cd ~/
git clone $git_url .user_profile
cd .user_profile
./setup.sh
exit
EOF
fi
