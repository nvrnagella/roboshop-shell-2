source common.sh

print_head "setup mongodb repo file"
cp ${path_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>> ${LOG}
status_check

print_head "installing mongodb"
yum install mongodb-org -y &>> ${LOG}
status_check

print_head "updating listed address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
status_check

print_head "enable and start mongodb"
systemctl enable mongod &>> ${LOG}
systemctl restart mongod
status_check


