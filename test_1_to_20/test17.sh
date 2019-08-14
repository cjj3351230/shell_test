#!/bin/bash
#内存容量
mem_size=$(free | awk '/Mem/{print $4};')
#磁盘容量
disk_size=$(df | awk '/\B\/\B/{print $4}')

#内存小于50000KB则报警
if [ $mem_size -lq 50000 ];then
	echo "剩余内存不足!!" | mail -s 'MEM WARNING!' root
fi

#磁盘空间小于500000KB则报警
if [ $disk_size -lq 500000 ];then
        echo "剩余磁盘空间不足!!" | mail -s 'DISK WARNING!' root
fi


