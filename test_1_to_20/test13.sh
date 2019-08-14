#!/bin/bash
name_list=$(cat user.txt)
for name in $name_list
do
	useradd $name >&2
	if [ $? -eq 0 ];then
		echo $name"用户创建成功"
	fi
done

