#!/bin/bash
#
#Deploy application
#


sudo apt install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

puma -d

PID_PUMA=$(pidof puma)

if [[ $PID_PUMA ]]
then
    echo "Application is started"
else
    echo "Application is not started"
    exit 1
fi

