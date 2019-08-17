#!/bin/bash
#输入三个数执行降序排序输出
echo "请输入三个需要降序排序的数字"
read -p "请输入第一个数: " num1
read -p "请输入第二个数: " num2
read -p "请输入第三个数: " num3

#进行num1和num2比较,当第一个数字大于第二个数字时
if [ $num1 -gt $num2 ];then
	#当第一个数字大于第三个数字时
	if [ $num1 -gt $num3 ];then
		#num1 > num2 > num3
		if [ $num2 -gt $num3 ];then
			echo $num1 $num2 $num3
		#num1 > num3 > num2
		else
			echo $num1 $num3 $num2
		fi
	#num3 > num1 > num2
	else
		echo $num3 $num1 $num2
	fi
#num1 < num2
else
	#num2 > num3
	if [ $num2 -gt $num3 ];then
		#num2 > num1 > num3
		if [ $num1 -gt $num3 ];then
			echo $num2 $num1 $num3
		#num2 > num3 > num1
		else
			echo $num2 $num3 $num1
		fi
	#num1 < num2 < num3
	else
		echo $num3 $num2 $num1
	fi
fi

