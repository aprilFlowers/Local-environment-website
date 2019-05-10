#!/bin/bash

#数据盘分区(2个空行 代表 2个回车, 切不可删除)
fdisk /dev/vdb << INPUT_CMD
d
n
p
1


w
INPUT_CMD

#数据盘格式化
mkfs.ext3 /dev/vdb1 || exit 1

#手动挂载数据盘
mkdir /app || exit 1
mount /dev/vdb1 /app || exit 1

#设置开机自动挂载数据盘
echo '/dev/vdb1 /app ext3 defaults 0 0' >> /etc/fstab


#修改系统设置
sysctl -w kernel.shmmax=68719476736
echo "kernel.shmmax=68719476736" >> /etc/sysctl.conf
sysctl -w kernel.shmall=16777216
echo "kernel.shmall=16777216" >> /etc/sysctl.conf

echo "ulimit -c unlimited" >> /etc/profile
echo "ulimit -f unlimited" >> /etc/profile

echo "export LANG=\"en_US.UTF-8\"" >> /etc/profile

#设置vim
\cp vimrc ~/.vimrc -f


#安装lrzsz
yum -y install lrzsz || exit 2

#安装监测环境
yum -y install oprofile sysstat iptraf dstat || exit 2

#安装编程环境
yum -y install gcc+ gcc-c++ make gdb mysql perl-DBD-MySQL || exit 2

#启动rsync
mkdir -p /app/sdo/rsync 
\cp rsync/* /app/sdo/rsync/
chmod 600 /app/sdo/rsync/rsyncd.*
mkdir -p /app/sdo/rsync/logs
rsync --daemon --config=/app/sdo/rsync/rsyncd.conf || exit 2


#创建游戏目录
mkdir -p /app/sdo/server


echo -e "\n\033[35m工作环境初始化完成！ \n\033[0m"
