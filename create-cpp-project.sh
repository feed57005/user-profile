#!/bin/bash

name=$1
if [ -z "$1" ]; then
	return 1
fi

pushd `dirname $0` > /dev/null
data_path=`pwd`'/cpp-template'
popd > /dev/null

proj_files=`ls -A -1 $data_path`

git init $name
cd $name
proj_path=`pwd`

for file in $proj_files; do
	cp $data_path/$file $proj_path/
done
