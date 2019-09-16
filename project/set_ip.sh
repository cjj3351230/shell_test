#!/bin/bash
read -p "请输入需要创建的虚拟机个数: " num
seq $num | for i in 

#if [ $num -lt 10 ];then
#	num=0$num
#fi
set_virtualhost(){
	clone-vm7 $num &> /dev/null
	if [ $? -eq 0 ];then
		virsh start tedu_node$num &> /dev/null
		echo "正在创建,请稍后..."
		sleep 20
		echo "创建成功!"
	else
		echo "创建失败,虚拟机已存在,请重新操作"
		exit 1
	fi
}


#部署mysql
setup_mysql(){
real_ip=${ip%/*}
expect <<eof
	spawn scp /linux-soft/03/mysql/mysql-5.7.17.tar $ip:/root
	expect "*password:"
	send "123456\r"
	sleep 5
	spawn ssh -X $real_ip
	send "tar -xf mysql-5.7.17.tar;yum -y install mysql-community*\r"
	send "exit"
eof
}

setip(){
read -p "请输入要配置的网卡(eth0/eth1/eth2/eth3): " eth
read -p "请输入IP(ip/24): " ip
expect <<eof
	set timeout 1
	spawn virsh console tedu_node$num 
	send "\r"
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
}

#主函数
main(){
	read -p "请输入需要创建的虚拟机个数: " num
	if
	fi 
}
