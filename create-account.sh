#!/bin/bash

uid=$(id -u)
if [ $uid -ne 0 ]; then
	echo "Must be run as root/sudo"
	exit 1
fi

if [ $# -ne 1 ]; then
  read -p "Username: "
  usr=$REPLY
else
  usr=$1
fi

git_url=https://github.com/feed57005/user-profile

echo "Creating user $usr"
useradd -m -s /bin/bash $usr
if [[ $? != 0 ]]; then exit 1; fi

passwd $usr
if [[ $? != 0 ]]; then exit 1; fi

read -p "Add user to sudoers ? (y/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo "Adding $usr to /etc/sudoers"
	echo "$usr ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi

read -p "Install user-profile ? (y/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	if ! type git &> /dev/null; then
		echo "You need git to be installed"
		exit 1
	fi
	if ! type sudo &> /dev/null; then
		echo "You need sudo to be installed"
		exit 1
	fi
	eval install_script=~$usr/install_user_profile.sh
	cat > $install_script <<EOF
#!/bin/bash
cd ~/
git clone $git_url .user_profile
cd .user_profile
git submodule init
git submodule update
./setup.sh
exit
EOF
	sudo -i -u $usr /bin/bash $install_script
  rm $install_script
fi

echo "Succesfully created user $usr"
