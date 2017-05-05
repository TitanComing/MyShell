#!/bin/bash
#-*-coding:utf8-*-

#与服务器文件交互
#peng
#2017.5.5

#scp连接信息
HostName="222.73.7.71"
Port1="9002"
Port2="9003"
User1="work1"
User2="work2"

echo "请输入目的服务器:work1或者work2,通过按键1和2选择......"
read WNum
echo "请选择上传还是下载:上传按键1,下载按键2......"
read TNum
echo "请选择操作文件还是目录:文件按键1,目录按键2......"
read FNum
echo "请输入源位置......"
read FromFile
echo "请输入目的位置......"
read ToFile

case $TNum in
  1)
  case $FNum in
    1)
    case $WNum in
      1)
      echo "服务器:${HostName}   端口:${Port1}  用户:${User1}"
      scp -P ${Port1} ${FromFile} ${User1}@${HostName}:${ToFile}
      ;;
      2)
      echo "服务器:${HostName}   端口:${Port2}  用户:${User2}"
      scp -P ${Port2} ${FromFile} ${User2}@${HostName}:${ToFile}
      ;;
    esac
    ;;
    2)
    case $WNum in
      1)
      echo "服务器:${HostName}   端口:${Port1}  用户:${User1}"
      scp -P ${Port1} -r ${FromFile} ${User1}@${HostName}:${ToFile}
      ;;
      2)
      echo "服务器:${HostName}   端口:${Port2}  用户:${User2}"
      scp -P ${Port2} -r ${FromFile} ${User2}@${HostName}:${ToFile}
      ;;
    esac
    ;;
  esac
  ;;
  2)
  case $FNum in
    1)
    case $WNum in
      1)
      echo "服务器:${HostName}   端口:${Port1}  用户:${User1}"
      scp -P ${Port1} ${User1}@${HostName}:${FromFile} ${ToFile}
      ;;
      2)
      echo "服务器:${HostName}   端口:${Port2}  用户:${User2}"
      scp -P ${Port2} ${User2}@${HostName}:${FromFile} ${ToFile}
      ;;
    esac
    ;;
    2)
    case $WNum in
      1)
      echo "服务器:${HostName}   端口:${Port1}  用户:${User1}"
      scp -P ${Port1} -r ${User1}@${HostName}:${FromFile} ${ToFile}
      ;;
      2)
      echo "服务器:${HostName}   端口:${Port2}  用户:${User2}"
      scp -P ${Port2} -r ${User2}@${HostName}:${FromFile} ${ToFile}
      ;;
    esac
    ;;
  esac
  ;;
esac
