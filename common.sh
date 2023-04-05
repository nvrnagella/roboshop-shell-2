LOG=/tmp/roboshop.log
print_Head(){
  echo -e "\e[31m$1\e[0m"
}
status_check(){
  if [ $? == 0 ];then
    echo SUCCESS
    else
      echo FAILURE
  fi
}

