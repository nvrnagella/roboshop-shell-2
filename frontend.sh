source common.sh
path_location=$(pwd)
print_Head "installing nginx"
yum install nginx -y &>> ${LOG}
status_check

print_Head "copying reverse proxy configuration file"
cp ${path_location}/files/roboshop.conf /etc/nginx/default.d/roboshop.conf &>> ${LOG}
status_check

print_Head "enable and start nginx"
systemctl enable nginx &>> ${LOG}
systemctl start nginx
status_check

print_Head "remove old nginx content"
rm -rf /usr/share/nginx/html/*
status_check

print_Head "download nginx content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>> ${LOG}
status_check

print_Head "navigate to app directory and unzip"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>> ${LOG}
status_check

print_Head "restart nginx"
systemctl restart nginx
status_check


