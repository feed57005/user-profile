#!/bin/bash

name=$1
if [ -z "$1" ]; then
	echo $0 ' <project_name>'
	exit 1
fi

data_path=`dirname $(readlink  $0)`/cpp-template
echo $data_path


git init $name
cd $name
proj_path=`pwd`

for file in `ls -A -1 $data_path`; do
	cp -R $data_path/$file $proj_path/
done
