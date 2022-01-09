# emm5847_infra
emm5847 Infra repository

1. ssh -i ~/.ssh/appuser -l appuser -J appuser@84.201.185.214 10.128.0.25

2. Add new HOST section to ~/.ssh/config 

HOST someinternalhost
  ForwardAgent yes
  Hostname 10.128.0.25
  IdentityFile ~/.ssh/appuser
  ProxyJump appuser@84.201.185.214
  User appuser

Then connect to host

ssh someinternalhost

3. Install VPN server pritunl

bastion_IP = 84.201.185.214
someinternalhost_IP = 10.128.0.25

4. Install Let's Encrypt Certificate

Install snapd
sudo apt-get install snapd
sudo systemctl start snapd.service
sudo systemctl enable snapd.service

Install certboot
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

Get certificate for domain name 84.201.185.214.sslip.io
sudo certbot certonly --standalone

In web interface of pritunl enter domain name 84.201.185.214.sslip.io in Settings -> Lets Encrypt Domain 

