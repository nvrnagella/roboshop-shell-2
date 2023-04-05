source common.sh

if [ -z "${rabbitmq_root_password}" ]
then
  echo "please provide rabbitmq_root_password"
  exit 1
fi

component=payment

python
