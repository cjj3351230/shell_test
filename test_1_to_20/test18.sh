#!/bin/bash
#用户输入一个1-100的数字,与系统生成的100以内的随机数进行判断
read -p "请输入一个数字(1-100): " input
num=$[RANDOM%100+1]

while :
do
	if [ $input -gt $num ];then
		read -p "猜大了,请重新猜:" input
	elif [ $input -lt $num ];then
		read -p "猜小了,请重新猜:" input
	else
		echo "猜对了!"
		exit
	fi

done
