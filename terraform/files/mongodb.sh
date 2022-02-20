!/bin/bash
#
#Install mongodb
#

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.2.list

while true
do
  if [[ $(ps aux | grep -c 'apt.systemd.daily') > 1 ]]
  then
    sleep 1
  else
    break
  fi
done

apt-get install apt-transport-https ca-certificates && sudo apt-get update && sudo apt-get install -y mongodb-org

systemctl start mongod
systemctl enable mongod

systemctl is-enabled mongod && systemctl is-active mongod

if [[ $? == 0 ]]
then
    echo "Mongodb is successfully started"
else
    echo "Mongod istallation error"
fi

