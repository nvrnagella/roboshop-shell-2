source common.sh

print_Head(){
  echo "\e[31m $1 \e[0m"
}
print_Head "installing nginx"
#yum install nginx -y &>> ${LOG}
status_check
