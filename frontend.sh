source common.sh

print_head "installing nginx"
yum install nginx -y &>> ${LOG}
status_check

print_head "copying reverse proxy configuration file"
cp ${path_location}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf &>> ${LOG}
status_check

print_head "enable and start nginx"
systemctl enable nginx &>> ${LOG}
systemctl start nginx
status_check

print_head "remove old nginx content"
rm -rf /usr/share/nginx/html/*
status_check

print_head "download nginx content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>> ${LOG}
status_check

print_head "navigate to app directory and unzip"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> ${LOG}
status_check

print_head "restart nginx"
systemctl restart nginx
status_check


