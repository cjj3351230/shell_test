#!/bin/bash
read -p "请输入一个数字: " num
while [ $num -le 1 ]
do
	read -p "您输入的数字应该大于1: " num
done

a=0
b=0

while [ $a -lt $num ]
do
	let a++
	let b+=a
done 
echo $b
