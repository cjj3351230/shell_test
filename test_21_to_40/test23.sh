#!/bin/bash
Bot=(剪刀 石头 布)
echo '剪刀,石头,布游戏3秒后开始!'
sleep 3

#结果为赢
result_w(){
    read -p "恭喜你赢了!是否继续?(y/n): " choice2
        if [ "$choice2" == "y" ];then
            echo "正在初始化,请稍等..." && sleep 1
            echo '剪刀,石头,布游戏3秒后开始!' && sleep 3
        else
            echo "Goodbye! See you next time!"
            exit
	fi
}

#结果为输
result_l(){
    echo "一定是意外!再来一次!" && sleep 1
    echo "正在初始化,请稍等..." && sleep 1
    continue
}

#结果打平
result_e(){
    echo "平局,请继续..." && sleep 1
    continue
}

main(){
    while :
    do
	echo '################################'
        read -p "请出拳: " choice1
        num=$[RANDOM%3]
        echo "人机出拳结果为:" ${Bot[num]} && sleep 1
        Bot_result=${Bot[num]}
    	if [ "$Bot_result" == "剪刀" ];then
    	    [ "$choice1" == "剪刀" ] && result_e
    	    [ "$choice1" == "石头" ] && result_w
    	    [ "$choice1" == "布" ] && result_l
    	elif [ "$Bot_result" == "石头" ];then
    	    [ "$choice1" == "剪刀" ] && result_l
    	    [ "$choice1" == "石头" ] && result_e
    	    [ "$choice1" == "布" ] && result_w
    	else	
    	    [ "$choice1" == "剪刀" ] && result_w
    	    [ "$choice1" == "石头" ] && result_l
    	    [ "$choice1" == "布" ] && result_e
    	fi
    done
}

#调用主函数
main
