source common.sh

print_head "Setup NodeJS repos. Vendor is providing a script to setup the repos."
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${LOG}
status_check

print_head "installing nodejs"
yum install nodejs -y &>> ${LOG}
status_check

print_head "add application user"
id roboshop
if [ $? -eq 0 ];then
useradd roboshop
fi
status_check

print_head "create app directory"
mkdir -p /app
status_check

print_head "remove old app content"
rm -rf /app
status_check

print_head "download app content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>> ${LOG}
status_check

print_head "navigate to app directory "
cd /app
status_check

print_head "unzip app content"
unzip /tmp/catalogue.zip &>> ${LOG}
status_check

print_head "install app dependencies"
npm install &>> ${LOG}
status_check

print_head "copy systemd service file"
cp ${path_location}/files/catalogue.service /etc/systemd/system/catalogue.service
status_check

print_head "enable and restart catalogue"
systemctl enable catalogue &>> ${LOG}
systemctl restart catalogue

print_head "setup mongodb repo file"
cp ${path_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>> ${LOG}
status_check

print_head "installing mongodb"
yum install mongodb-org-shell -y &>> ${LOG}
status_check

print_head "loading schema"
mongo --host 172.31.80.124 </app/schema/catalogue.js &>> ${LOG}
status_check