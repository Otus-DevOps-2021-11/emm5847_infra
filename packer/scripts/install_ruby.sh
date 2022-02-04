#!/bin/bash
#
#Install Ruby
#


while true
do
  if [[ $(ps aux | grep -c 'apt.systemd.daily') > 1 ]]
  then
    sleep 1
  else
    break
  fi
done

apt-get update && apt-get install -y ruby-full ruby-bundler build-essential

ruby -v && bundler -v

if [[ $? == 0 ]]
then
  echo "Ruby is successfully installed"
else
  echo "Ruby installation error"
fi
