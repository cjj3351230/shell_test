#!/bin/bash
sum=0
a=0
while [ $a -lt 100 ]
do
	let a++
	let sum+=a
done 
echo $sum
