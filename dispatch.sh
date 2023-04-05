source common.sh

if [ -z "${mysql_root_password}" ]
then
  echo "please provide mysql_root_password"
  exit 1
fi

component=dispatch

golang
