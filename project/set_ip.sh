#!/bin/bash
read -p "请输入需要创建的编号: " num
if [ $num -lt 10 ];then
	num=0$num
fi

clone-vm7 $num &> /dev/null
if [ $? -eq 0 ];then
	virsh start tedu_node$num &> /dev/null
	echo "正在创建,请稍后..."
	sleep 20
else
	echo "创建失败,虚拟机已存在,请重新操作"
	exit 1
fi

read -p "请输入要配置的网卡: " eth
read -p "请输入IP(ip/24): " ip
expect <<eof
	set timeout 1
	spawn virsh console tedu_node51 
	expect "*login:" 
	send "root\r"
	expect "*Password:" 
	send "123456\r"
	send "setip\r"
	expect "*(eth0/eth1/eth2/eth3):" 
	send "${eth}\r"
	expect "*(IP/24):"
	send "${ip}\r"
	send "\r" 
	send "exit"
	expect eof
eof
