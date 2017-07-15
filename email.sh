#!/usr/bin/env bash
#-*-coding:utf-8-*-
#基于Postfix和Dovecot搭建简易邮件服务器
#created by peng
#
#20170714 v0.1 支持centos6.5 64位系统

function install() {
  #安装基本的软件
  yum -y update
  #安装chkconfig
  yum -y install chkconfig
  #安装postfix
  yum -y install postfix
  #移除替换系统自带的sendmail
  /etc/rc.d/init.d/sendmail stop
  yum remove sendmail
  #修改MTA（默认邮件传输代理）
  echo -e "\n" | alternatives --config mta
  alternatives --display mta
  #安装Dovecot
  yum -y install dovecot
  chkconfig dovecot on
  chkconfig postfix on
}

function setpostfix() {
  cp /etc/postfix/main.cf /etc/postfix/main-bak.cf
  MAINCF=/etc/postfix/main.cf
  #设置postfix的参数
  # 75行: 取消注释，设置hostname
  sed -i '/#myhostname = host.domain.tld/c myhostname = mail.titancoming.me' ${MAINCF}
  # 83行: 取消注释，设置域名
  sed -i '/#mydomain = domain.tld/c mydomain = titancoming.me' ${MAINCF}
  # 99行: 取消注释
  sed -i '/#myorigin = $mydomain/c myorigin = $mydomain' ${MAINCF}
  # 116行: 修改
  sed -i '/inet_interfaces = localhost/c inet_interfaces = all' ${MAINCF}
  # 119行: 推荐ipv4，如果支持ipv6，则可以为all
  sed -i '/inet_protocols = all/c inet_protocols = ipv4' ${MAINCF}
  # 164行: 添加
  sed -i '/^mydestination = $myhostname/c mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain' ${MAINCF}
  # 264行: 取消注释，指定内网和本地的IP地址范围
  sed -i "/mynetworks = 168.100.189.0/c mynetworks = 127.0.0.0/8, 10.0.0.0/24" ${MAINCF}
  # 419行: 取消注释，邮件保存目录
  sed -i '/#home_mailbox = Maildir/c home_mailbox = Maildir/' ${MAINCF}
  # 571行: 添加
  sed -i '571 ismtpd_banner = $myhostname ESMTP' ${MAINCF}

cat >> ${MAINCF} << EOF
  # 规定邮件最大尺寸为10M
  message_size_limit = 10485760
  # 规定收件箱最大容量为1G
  mailbox_size_limit = 1073741824
  # SMTP认证
  smtpd_sasl_type = dovecot
  smtpd_sasl_path = private/auth
  smtpd_sasl_auth_enable = yes
  smtpd_sasl_security_options = noanonymous
  smtpd_sasl_local_domain = $myhostname
  smtpd_recipient_restrictions = permit_mynetworks,permit_auth_destination,permit_sasl_authenticated,reject
EOF
}


function setdovecot() {
  cp /etc/dovecot/dovecot.conf /etc/dovecot/dovecot-bak.conf
  cp /etc/dovecot/conf.d/10-auth.conf /etc/dovecot/conf.d/10-auth-bak.conf
  cp /etc/dovecot/conf.d/10-mail.conf /etc/dovecot/conf.d/10-mail-bak.conf
  cp /etc/dovecot/conf.d/10-master.conf /etc/dovecot/conf.d/10-master-bak.conf
  DOVECOTCONF=/etc/dovecot/dovecot.conf
  _10AUTHCONF=/etc/dovecot/conf.d/10-auth.conf
  _10MAILCONF=/etc/dovecot/conf.d/10-mail.conf
  _10MASTERCONF=/etc/dovecot/conf.d/10-master.conf

  #设置dovecot
  #26行: 不使用ipv6
  sed -i '/#listen = */c listen = *' ${DOVECOTCONF}

  # 9行: 取消注释并修改
  sed -i '/#disable_plaintext_auth = yes/c disable_plaintext_auth = no' ${_10AUTHCONF}
  # 97行: 添加
  sed -i '97 iauth_mechanisms = plain login' ${_10AUTHCONF}

  # 30行: 取消注释并添加
  sed -i '/#mail_location = /c mail_location = maildir:~/Maildir' ${_10MAILCONF}

  # 88-90行: 取消注释并添加
  # Postfix smtp验证
  sed -i '90 aunix_listener /var/spool/postfix/private/auth {' ${_10MASTERCONF}
  sed -i '91 a  mode = 0666' ${_10MASTERCONF}
  sed -i '92 a  user = postfix' ${_10MASTERCONF}
  sed -i '93 a  group = postfix' ${_10MASTERCONF}
  sed -i '94 a}' ${_10MASTERCONF}
}
function init() {
  stop
  #重置服务配置
  cp -f /etc/postfix/main-bak.cf /etc/postfix/main.cf
  cp -f /etc/dovecot/dovecot-bak.conf /etc/dovecot/dovecot.conf
  cp -f /etc/dovecot/conf.d/10-auth-bak.conf /etc/dovecot/conf.d/10-auth.conf
  cp -f /etc/dovecot/conf.d/10-mail-bak.conf /etc/dovecot/conf.d/10-mail.conf
  cp -f /etc/dovecot/conf.d/10-master-bak.conf /etc/dovecot/conf.d/10-master.conf
}

function start() {
  #启动邮件服务
  /etc/rc.d/init.d/dovecot start
  /etc/rc.d/init.d/postfix start
}
function restart() {
  #重启服务
  /etc/rc.d/init.d/dovecot restart
  /etc/rc.d/init.d/postfix restart
}
function stop() {
  #停止服务
  /etc/rc.d/init.d/dovecot stop
  /etc/rc.d/init.d/postfix stop
}

case $1 in
    all )
  stop
  install
  setpostfix
  setdovecot
  start
  ;;
install )
    install
    start
    ;;
setconfig )
setpostfix
setdovecot
    ;;
   start )
    start
    ;;
    stop )
    stop
    ;;
 restart )
    restart
    ;;
    init )
    init
    ;;
    * )
    echo '请输入 all | install | setconfig | start | stop | restart | init'
    ;;
esac
