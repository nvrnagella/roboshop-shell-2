source common.sh

print_head "disable mysql 8 which will come by default with centos 8"
dnf module disable mysql -y &>> ${LOG}
status_check

print_head "setup mysql repo file"
cp ${path_location}/files/mysql.repo /etc/yum.repos.d/mysql.repo &>> ${LOG}
status_check

print_head "installing mysql"
yum install mysql-community-server -y &>> ${LOG}
status_check

print_head "enable and start mysql"
systemctl enable mysqld &>> ${LOG}
systemctl restart mysqld
status_check

print_head "change the default root password in order to start using the database service."
mysql_secure_installation --set-root-password Roboshop@1
status_check
