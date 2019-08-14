#!/bin/bash
for num in {1..2000}
do
	a=$[${num}%177]
	if [ $a -eq 0 ];then
		echo $num
	fi
done
