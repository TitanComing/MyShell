#!/usr/bin/env bash
#-*-coding:utf-8-*-

echo "本脚本通过本地的socks5服务进行shell代理，请首先确保本地已经开启socks5服务..."
echo "注意:shell代理只对当前窗口有效"
echo "******************当前的IP信息：****************"
curl ip.gs | head -4
echo "请输入：数字1设置git和shell代理，数字2去除git代理"

read num
case ${num} in
  1)
  #git sock5代理
  git config --global http.proxy 'socks5://127.0.0.1:1080'
  git config --global https.proxy 'socks5://127.0.0.1:1080'
  export http_proxy="socks5://127.0.0.1:1080"
  export https_proxy="socks5://127.0.0.1:1080"
  echo "设置代理完毕......"
  ;;
  2)
  git config --global --unset http.proxy
  git config --global --unset https.proxy
  echo "去除git代理完毕......"
  ;;
esac
echo "*****************请查验当前IP信息：**************"
curl ip.gs | head -4
