source common.sh

print_Head "setup mongodb repo file"
cp ${path_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>> ${LOG}
status_check

print_Head "installing mongodb"
yum install mongodb-org -y &>> ${LOG}
status_check

print_Head "updating listed address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
status_check

print_Head "enable and start mongodb"
systemctl enable mongod &>> ${LOG}
systemctl restart mongod
status_check


