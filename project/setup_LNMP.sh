#!/binb/ash

#建立在clone-vm7脚本的基础上,新建虚拟机
setup_virtualhost(){
	read -p '输入新建的虚拟机编号(1-20): ' vh_num
	export vh_num
	clone-vm7 $vh_num &> /dev/null
	#判断是否创建成功
	if [ $? -eq 0 ];then
		#如果输入的虚拟机编号小于10则自动补0
		if [ $vh_num -lt 10 ];then
        		vh_num=0$vh_num
		fi
		echo "虚拟机tedu_node${vh_num}创建成功!"
	else
		echo "编号输入重复或错误,请重新操作!"
		echo "============="
		setup_virtualhost
	fi
}


#修改新建虚拟机的配置文件
modify_profile(){
	read -p "请输入需要修改的虚拟机名: " v_name
	#修改配置文件中<name>行
	#删除配置文件中uuid,定以后自动生成
	#删除所有mac地址,定义后自动生成
	sed -i "s/<name>.*<\/name>/<name>$v_name<\/name>/" /etc/libvirt/qemu/tedu_node${vh_num}.xml
	sed -r -i "s/<uuid.*//" /etc/libvirt/qemu/tedu_node${vh_num}.xml
	sed -r -i "s/<mac.*//" /etc/libvirt/qemu/tedu_node${vh_num}.xml
	
	#定义虚拟机并删除原文件
	virsh define /etc/libvirt/qemu/tedu_node${vh_num}.xml &> /dev/null	
	rm -rf /etc/libvirt/qemu/tedu_node${vh_num}.xml
	echo "虚拟机已改名为${v_name}"
}


main(){
	setup_virtualhost
	echo -e "###########################\n "
	#根据用户选择修改或不修改配置文件名
	read -p "是否修改配置文件名?(y/n): " choose
	if [ $choose == 'y' ];then
		modify_profile
	fi
	echo -e "###########################\n "
}
main
