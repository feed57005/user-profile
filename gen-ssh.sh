#!/bin/bash

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
echo "generating key $filename $comment"

ssh-keygen -b 2048 -t rsa -C "$comment" -f $filename

# TODO test SSH_AGENT_PID to see if ssh-agent is running

echo "adding key $filename.pub"
chmod 600 $filename $filename.pub
ssh-add $filename

echo "public key:"
cat $filename.pub
