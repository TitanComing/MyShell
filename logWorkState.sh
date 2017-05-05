#!/usr/bin/env bash
#-*-coding:utf-8-*-

#ssh连接
HostName="222.73.7.71"
Port1="9002"
Port2="9003"
User1="work1"
User2="work2"

echo "请选择登录的服务器器编号(1或者2)......"
read Num
case $Num in
  1)
  echo "正在登录服务器:${HostName}   端口:${Port1}  用户:${User1}"
  ssh -p ${Port1} ${User1}@${HostName}
  ;;
  2)
  echo "正在登录服务器:${HostName}   端口:${Port2}  用户:${User2}"
  ssh -p ${Port2} ${User2}@${HostName}
  ;;
esac
