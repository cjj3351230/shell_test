#!/bin/bash
groupadd users
for i in {1..100}
do
	if [ $i -lt 10 ];then 
		useradd -G users user_0$i
	else
		useradd -G users user_$i
	fi
done
