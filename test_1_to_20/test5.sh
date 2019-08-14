#!/bin/bash
num=$(ls /cjk | wc -l)
b='.bak'
#echo $num
for i in $(seq $num)
do
	filename=$(ls /cjk/ | awk "NR==$i")
	mv "/cjk/$filename" "/cjk/${filename}.bak"
done
