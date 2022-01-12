#!/bin/bash
#
#Install Ruby
#

sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

ruby -v && bundler -v

[[ $? != 0 ]] && { echo "Installation error"; exit 1 }

