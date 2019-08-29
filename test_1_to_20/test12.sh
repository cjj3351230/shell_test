#!/bin/bash
read -p "请输入要查询权限的用户名: " user_name
read -p "请输入要查看的文件完整路径: " file_name
user_group_list=`id $user_name | awk -F'=' '{print $4}' | sed 's/[0-9]*//g;s/(//g;s/)//g;s/,/ /g'`
file_user=$(getfacl $file_name | grep 'owner' | awk -F': ' '{print $2}')
file_group=$(getfacl $file_name | grep '# group' | awk -F': ' '{print $2}')
permission=$(getfacl $file_name | sed -n  '4,$p' | sed -n '/^$/!p' | sed -n "/$user_name/p" | awk -F: '{print $3}')
judge=`echo ${user_group_list} | sed -n "/${file_group}/p"`
echo    "该用户的组有: "$user_group_list
echo    "该文件的属主为: "$file_user
echo    "该文件的属组为: "$file_group
echo    "该用户的acl权限为: "$permission
echo    "判断的值为: "$judge

if [ ! -n "$permission" ];then  #没有acl权限,则判断是否是属主或属组

        if [ $user_name == $file_user ];then      #为属主,有读写权限
                echo "用户${user_name}有读权限"
                echo "用户${user_name}有写权限"
                echo "用户${user_name}无执行权限"
                exit
        elif [ -n $judge ];then
                echo "用户${user_name}有读权限"
                echo "用户${user_name}无写权限"
                echo "用户${user_name}无执行权限"
                exit
        else
                echo "用户${user_name}有读权限"
                echo "用户${user_name}无写权限"
                echo "用户${user_name}无执行权限"
        fi
else    #有acl权限,则判断有哪几个
        p_r=${permission:0:1}
        p_w=${permission:1:1}
        p_x=${permission:2:1}
        echo $p_r $p_w $p_x
        if [ "${p_r}" == "r" ];then
                echo "用户${user_name}有读权限"
        else
                echo "用户${user_name}无读权限"
        fi
        if [ "${p_w}" == "w" ];then
                echo "用户${user_name}有写权限"
        else
                echo "用户${user_name}无写权限"
        fi
        if [ "${p_x}" == "x" ];then
                echo "用户${user_name}有执行权限"
        else
                echo "用户${user_name}无执行权限"
        fi
fi
