#!/bin/bash
#
#Run App
#

app_dir="/opt"

apt install -y git
cd $app_dir
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

if [[ $? == 0 ]]
then
    echo "Applications is successfully installed"
else
    echo "Can't install application"
fi

cat <<EOF > /lib/systemd/system/puma.service
[Unit]
Description=Run reddit application
After=network.target

[Service]
ExecStart=/usr/local/bin/puma --dir /opt/reddit
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl enable puma.service && systemctl start puma.service

if [[ $? == 0 ]]
then
    echo "Applications is successfully started"
else
    echo "Can't start application"
fi
