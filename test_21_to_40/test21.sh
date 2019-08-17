#!/bin/bash
read -p "请输入要创建的用户名: " user
read -p "请输入密码(默认设置为123456): " password

#判断用户名是否为空,空则退出
if [ -z $user ];then
	echo '用户名为空,请重新操作!'
	exit
else
	useradd $user
fi

#判断密码是否为空,空则设置为123456
if [ -z $password ];then
	echo "123456" | passwd --stdin $user
else
	echo $password | passwd --stdin $user
fi
