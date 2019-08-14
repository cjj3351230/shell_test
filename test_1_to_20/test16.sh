#!/bin/bash

#安装nginx依赖包,mariadb依赖包,php依赖包
yum -y install gcc pcre-devel openssl-devel
yum -y install mariadb mariadb-server mariadb-devel
yum -y install php php-fpm php-mysql
#tar解包,需要先从真机将包scp到虚拟机
tar -xf lnmp_soft.tar.gz

#源码安装nginx
cd lnmp_soft
tar -xf nginx-1.12.2.tar.gz -C /root
cd ..
cd nginx-1.12.2/
useradd -s /sbin/nologin nginx
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module
make && make install

#启动nginx检验
cd /usr/local/nginx/
 ./sbin/nginx 

