source common.sh
path_location=$(pwd)
#print_Head "installing nginx"
#yum install nginx -y &>> ${LOG}
#status_check

print_Head "copying reverse proxy configuration file"
echo ${path_location}
status_check
