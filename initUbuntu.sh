#!/bin/bash
#-*-coding:utf8-*-

#安装ubuntu之后初始4系统
#peng
#2017.5.7

#path
echo "请输入root密码:"
read password

#pip
echo "安装pip......"
wget https://bootstrap.pypa.io/get-pip.py  --no-check-certificate
sudo python get-pip.py
rm get-pip.py
echo "************pip安装成功***********"
echo ""
echo ""

#java
echo "安装java......"
echo password | sudo apt-get -y install default-jre
echo password | sudo apt-get -y install default-jdk
echo "*************java安装成功**********"
echo ""
echo ""

#atom
echo "安装atom......"
echo password | sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update > /dev/null
sudo apt-get -y install atom
echo "*************atom安装成功*************"
echo ""
echo ""

#ssh
echo "安装ssh-client......."
echo password | sudo apt-get -y install openssh-client
echo "************ssh—client安装成功**********"
echo ""
echo ""

#docker
echo "安装docker......"
curl	-sSL	https://get.docker.com/	|	sh
echo "**************docker安装成功************"
echo ""
echo ""

#docker-compose
echo "安装docker-compose......."
sudo pip	install	-U docker-compose
echo "**************docker-compose安装成功**************"
echo ""
echo ""

#shadowsocks-qt5
echo "安装shadowsocks-qt5......"
echo password | sudo add-apt-repository ppa:hzwhuang/ss-qt5
sudo apt-get update > /dev/null
sudo apt-get -y install shadowsocks-qt5
echo "**************shadowsocks-qt5安装成功**********"
echo ""
echo ""

#chromium-browser
echo "安装google-chrome-stable......."
wget -q -O - https://raw.githubusercontent.com/longhr/ubuntu1604hub/master/linux_signing_key.pub | sudo apt-key add
sh -c 'echo "deb [ arch=amd64 ] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update > /dev/null
sudo apt-get -y install google-chrome-stable
echo "**********google-chrome-stable安装成功**********"
echo ""
echo ""

echo "正在进行最后的更新......"
echo password | sudo apt-get update > /dev/null
echo password | sudo apt-get upgrade
echo "***********最后的更新运行完毕***********"
echo ""
echo ""
echo "正在清理无用的安装包......"
echo password | sudo apt-get -y clean && sudo apt-get -y autoclean && sudo apt-get -y autoremove
echo "***************无用的安装包清理完毕******************"
echo ""
echo ""
echo "********************************************"
echo "**************安装运行完毕*********************"
echo "********************************************"
echo ""
echo ""

echo "获取安装程序版本......."
echo "******pip --version****"
pip --version
echo ""
echo "******java --version****"
java -version
echo ""
echo "******atom --version****"
atom --version
echo ""
echo "******docker --version****"
docker --version
echo ""
echo "******docker-compose --version****"
docker-compose --version
echo ""
echo "******shadowsocks-qt5 --version****"
ss-qt5 --version
echo ""
echo "******google-chrome-stable --version****"
google-chrome-stable --version
