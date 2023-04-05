source common.sh

print_head "Configure YUM Repos from the script provided by vendor"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>> ${LOG}
status_check

print_head "installing erlang "
yum install erlang -y &>> ${LOG}
status_check

print_head "Configure YUM Repos for rabbitmq"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>> ${LOG}
status_check

print_head "installing rabbitmq "
yum install rabbitmq-server -y  &>> ${LOG}
status_check

print_head "enable rabbitmq "
systemctl enable rabbitmq-server &>> ${LOG}
status_check

print_head "start rabbitmq "
systemctl restart rabbitmq-server
status_check

print_head "adding user for rabbitmq "
rabbitmqctl add_user roboshop roboshop123
status_check

print_head "setting admin tag for rabbitmq user "
rabbitmqctl set_user_tags roboshop administrator
status_check

print_head "setting v host permission for rabbitmq user "
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
status_check