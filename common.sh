LOG=/tmp/roboshop.log
path_location=$(pwd)

print_head(){
  echo -e "\e[31m$1\e[0m"
}
status_check(){
  if [ $? == 0 ];then
    echo SUCCESS
    else
      echo FAILURE
  fi
}
nodejs(){
  print_head "Setup NodeJS repos. Vendor is providing a script to setup the repos."
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${LOG}
  status_check

  print_head "installing nodejs"
  yum install nodejs -y &>> ${LOG}
  status_check

  app_prereq

  print_head "install app dependencies"
  npm install &>> ${LOG}
  status_check

  systemd_setup

  schema_load
}

app_prereq(){
  print_head "add application user"
  id roboshop &>> ${LOG}
  if [ $? != 0 ]
  then
    useradd roboshop
  fi
  status_check

  print_head "create app directory"
  mkdir -p /app
  status_check

  print_head "remove old app content"
  rm -rf /app/*
  status_check

  print_head "download app content"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> ${LOG}
  status_check

  print_head "navigate to app directory "
  cd /app
  status_check

  print_head "unzip app content"
  unzip /tmp/${component}.zip &>> ${LOG}
  status_check
}

systemd_setup(){
  print_head "copy systemd service file"
  cp ${path_location}/files/${component}.service /etc/systemd/system/${component}.service
  status_check

  print_head "enable and restart ${component}"
  systemctl enable ${component} &>> ${LOG}
  systemctl restart ${component}
}

schema_load(){
  if [ $schema_load == "true" ]
  then
    if [ $schema_type == "mongo" ]
    then
      print_head "setup mongodb repo file"
      cp ${path_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>> ${LOG}
      status_check

      print_head "installing mongodb"
      yum install mongodb-org-shell -y &>> ${LOG}
      status_check

      print_head "loading schema"
      mongo --host 172.31.80.124 </app/schema/${component}.js &>> ${LOG}
      status_check
    fi
    if [ $schema_type == "mysql" ]
    then
      print_head "installing mysql"
      yum install mysql -y  &>> ${LOG}
      status_check

      print_head "loading schema"
      mysql -h 172.31.80.124 -uroot -pRoboShop@1 </app/schema/${component}.sql &>> ${LOG}
      status_check
    fi
  fi
}

maven(){
  print_head "installing maven"
  yum install maven -y &>> ${LOG}
  status_check

  app_prereq

  print_head "install app dependencies"
  mvn clean package &>> ${LOG}
  status_check

  systemd_setup

  schema_load

}
