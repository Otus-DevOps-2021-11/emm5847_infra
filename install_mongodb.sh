#!/bin/bash
#
#Install mongodb
#

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | \
	sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list

sudo apt-get update && sudo apt-get install apt-transport-https ca-certificates && sudo apt-get install -y mongodb-org-server

sudo systemctl start mongod
sudo systemctl enable mongod

systemctl is-enabled mongod && systemctl is-active mongod

if [[ $? == 0 ]]
then
    echo "Mongodb is successfully started"
else
    echo "Mongod istallation error"
fi
