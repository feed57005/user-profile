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

echo "creating user $usr"
useradd -m -s /bin/bash $usr
passwd $usr

echo "adding $usr to sudoers"
usermod -G sudo -a $usr

read -p "run user-profile setup? (y/n/q)" -n 1 -r
echo
su - $usr
if [[ $REPLY =~ ^[Yy]$ ]]; then
	./setup.sh
fi
