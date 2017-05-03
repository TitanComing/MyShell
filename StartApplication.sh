#!/bin/bash
#-*-coding:utf8-*-

#开机启动基础程序
#peng
#2017.5.3

echo "自动开启基础程序"

for Num in 1 2 3 4
do
  (
  echo "当前执行程序: $Num"
  case $Num in
    1 )
    cd /home/peng/software/finalspeed_client
    java -jar finalspeed_client.jar
    echo "启动FinallSpeed..."
      ;;
    2 )
    sleep 10
    cd  /usr/bin
    ss-qt5
    echo "启动shadowsocks-qt5..."
    ;;
    3 )
    cd /usr/bin
    chromium-browser
    echo "启动chrome..."
    ;;
    4 )
    cd /usr/bin
    atom
    echo "启动atom..."
    ;;
  esac
  )&
done
wait
