#!/bin/bash
num=$(ps -aux | wc -l)	#$num比进程数多1
if [ $num -ge 101 ];then
	echo "老王来了!" | mail -s "WARNING" root
fi
