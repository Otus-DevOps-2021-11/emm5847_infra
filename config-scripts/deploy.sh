#!/bin/bash
#
#Deploy application
#


sudo apt install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

puma -d

if [[ $? == 0 ]]
then
    echo "Applications is successfully started"
else
    echo "Can't start application"
fi

ps aux | grep puma
