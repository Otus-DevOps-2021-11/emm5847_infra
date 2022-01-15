#!/bin/bash
#
#Install mongodb
#

apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 656408E390CFB1F5
echo "deb http://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | \
	sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update && sudo apt-get install -y mongodb-org-server

sudo systemctl start mongod
sudo systemctl enable mongod

systemctl is-enabled mongod && systemctl is-active mongod

if [[ $? == 0 ]]
then
    echo "Mongodb is successfully started"
else
    echo "Mongod istallation error"
fi
