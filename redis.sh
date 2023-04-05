source common.sh

print_head "Setup redis repos. Vendor is providing a script to setup the repos."
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> ${LOG}
status_check

print_head "enable redis 6.2 from package"
dnf module enable redis:remi-6.2 -y &>> ${LOG}
status_check

print_head "installing redis"
yum install redis -y &>> ${LOG}
status_check

print_head "updating listed address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf && /etc/redis/redis.conf
status_check

print_head "enable and start redis"
systemctl enable redis &>> ${LOG}
systemctl restart redis
status_check