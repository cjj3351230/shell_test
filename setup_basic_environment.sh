#!/bin/bash

#源码安装nginx
setup_nginx(){
	#解压lnmp_soft包
	tar -xf lnmp_soft.tar.gz
	#进入lnmp_soft目录,解压nginx1.12至/root
	cd lnmp_soft/
	tar -xf nginx-1.12.2.tar.gz -C /root
	#进入nginx1.12的目录
	cd ..
	cd nginx-1.12.2/
	#添加nginx用户用于降权,安装nginx依赖包gcc,openssl-devel,pcre-devel
	useradd -s /sbin/nologin nginx
	yum -y install gcc openssl-devel pcre-devel
	#配置检查,添加ssl加密,网页状态查询,调度器模块
	./configure --user=nginx --group=nginx --with-http_ssl_module  --with-http_stub_status_module  --with-stream
	#编译并安装
	make && make install
}

#部署lnmp环境
setup_lnmp(){
	yum -y install mariadb-server mariadb-devel
	yum -y install  php php-fpm php-mysql
}

read -p "安装nginx请输入'1',或部署LNMP环境请输入'2': " choice
if [ $choice -eq 1 ];then
	setup_nginx
else
	setup_lnmp; setup_nginx 



