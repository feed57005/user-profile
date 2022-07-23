#!/bin/bash

## detect compatible ssh implementation
## requires ssh-keygen, ssh-add, ssh

if ! type ssh-keygen &> /dev/null; then
	echo "ssh-keygen does not exists, install it"
	exit -1
fi

mkdir -p ~/.ssh &> /dev/null

if [ $# -lt 1 ]; then
	filename=~/.ssh/id_rsa
else
	filename=~/.ssh/$1
fi

if [ $# -ne 2 ]; then
	comment=$USER@`hostname`
else
	comment=$2
fi

if [ -x $filename ]; then
	read -p "$filename already exist, overwrite (y/n):" -n 1 -r
	if [[ $REPLY =~ ^[Nn]$ ]]; then
		exit 1
	fi
fi

echo "generating key $filename $comment"

ssh-keygen -b 2048 -t rsa -C "$comment" -f $filename

chmod 600 $filename $filename.pub

# TODO test SSH_AGENT_PID to see if ssh-agent is running
#      check distribution specific access to secure storage

echo "adding key $filename.pub"
ssh-add $filename

echo "public key:"
cat $filename.pub

# add authorized keys
# TODO read all hosts from a file
read -p "Add to remote authorized_keys ?(y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	read -p "ssh address: "
	cat $filename.pub | ssh $REPLY 'mkdir -p ~/.ssh && cat - >> ~/.ssh/authorized_keys'
fi
