#!/bin/bash
#判断当前的UID是否为0,是则为管理员
root=$(echo $UID)
if [ $root == "root" ];then
	echo "正在安装,请稍后..."
	yum -y install vsftpd &> /dev/null
	sleep 5
	echo "vsftpd安装成功!"
else
	echo "您不是管理员"
fi

