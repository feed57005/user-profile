#!/bin/bash
if ! type git &> /dev/null; then
	echo "install git"
	exit -1
fi

read -p "git user.name: "
git config --global user.name "$REPLY"

read -p "git user.email: "
git config --global user.email "$REPLY"

# [alias]
git config --global alias.nl "log --stat"
git config --global alias.ls "status"
git config --global alias.sls "stash list --name-status"
git config --global alias.b "branch --color -vv -a --abbrev=5"

# [color]
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.status auto
git config --global color.stash auto
