
echo "installing nginx"
#yum install nginx -y
if [ $? == 0 ];then
  echo SUCCESS
  else
    echo FAILURE
fi