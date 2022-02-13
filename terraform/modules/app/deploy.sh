#!/bin/bash
set -e
APP_DIR=${1:-$HOME}
DB_URL="$2"

echo $1 "first"
echo $2 "second"

while true
do
  if [[ $(ps aux | grep -c 'apt.systemd.daily') > 1 ]]
  then
    sleep 1
  else
    break
  fi
done

sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
sudo sed -i "s/DATABASE_URL=127.0.0.1/DATABASE_URL=$DB_URL/" /tmp/puma.service
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma

