#!/binb/ash

#建立在clone-vm7脚本的基础上,新建虚拟机
setup_virtualhost(){
	read -p '输入新建的虚拟机编号(1-99): ' vh_num
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
	export v_name
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

#修改
set_ip(){
	read -p "请输入需要修改的网卡(eth0,eth1,eth2,eth3): " dev
	read -p '请输入IP: ' addr
	#判断是否修改了虚拟机名,没修改则为原始名
	if [ -n $v_name ];then
		v_name="tedu_node$vh_num"
	fi
	#判断虚拟机是否处在开机状态
	if virsh domstate $v_name |grep running ;then
		echo "修改虚拟机网卡数据,需要关闭虚拟机"
		virsh destroy $v_name
	fi
	#挂载,如果有目录则查看是否有挂载内容
	mountpoint="/media/virtp_w_picpath"
	[ ! -d $mountpoint ] && mkdir $mountpoint
	echo "请稍后..."
	if mount | grep "$mountpoint" &> /dev/null ;then
		umount $mountpoint
	fi
	guestmount  -d $v_name -i $mountpoint
	#判断原本网卡配置文件中是否有IP地址，有，就修改该IP，没有，就添加一个新的IP地址
	if grep "IPADDR"  $mountpoint/etc/sysconfig/network-scripts/ifcfg-$dev;then
		sed -i "/IPADDR/s/=.*/=$addr/"  $mountpoint/etc/sysconfig/network-scripts/ifcfg-$dev
	else
		echo "IPADDR=$addr" >>  $mountpoint/etc/sysconfig/network-scripts/ifcfg-$dev
	fi
	#如果网卡配置文件中有客户配置的IP地址，则脚本提示修改IP完成
	awk -F= -v x=$addr '$2==x{print "完成..."}' $mountpoint/etc/sysconfig/network-scripts/ifcfg-$dev

}




#停滞1秒并输出分隔符
sleep_1(){
	sleep 1
        echo -e "\n===================\n "
}





main(){
	setup_virtualhost
	sleep_1
	#根据用户选择修改或不修改配置文件名
	read -p "是否修改配置文件名?(y/n): " choose
	if [ $choose == 'y' ];then
		modify_profile
	elif [ $choose == 'n' ];then
		sleep 1 
	fi
	sleep_1
	#配置IP
	set_ip
}
main
