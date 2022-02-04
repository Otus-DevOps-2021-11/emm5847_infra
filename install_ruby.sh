#!/bin/bash
#
#Install Ruby
#

sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

ruby -v && bundler -v

if [[ $? == 0 ]]
then
  echo "Ruby is successfully installed"
else
  echo "Ruby installation error"
fi
