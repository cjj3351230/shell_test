#!/bin/bash
echo "正在启动测试程序,请稍等..." && sleep 1
echo "开始测试.." && sleep 1
echo "############################"
up_num=0;down_num=0
all_times=1
while [ "$all_times" -le 254 ]
do
    ping -c 1 -W 1 192.168.4.$all_times > /dev/null 2>&1
    if [ "$?" -eq 0 ];then
	echo -e "该网段${all_times}主机状态为\e[1;36m开机\e[0m"
	let up_num++
    else
	echo -e "该网段${all_times}主机状态为\e[1;35m关机\e[0m"
	let down_num++
    fi
    let all_times++
done
echo "开机的主机数为: $up_num"
echo "关机的主机数为: $down_num"
