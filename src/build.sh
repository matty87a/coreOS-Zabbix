#!/bin/sh
set -e
apt-get update
apt-get install -y apt-utils
apt-get install -y vim curl net-tools wget gnupg2 curl netcat update-notifier libssl1.0.0 apt-transport-https
wget https://bootstrap.pypa.io/get-pip.py
python3.5  get-pip.py
pip install humanfriendly
wget https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-2+xenial_all.deb
dpkg -i zabbix-release_4.0-2+xenial_all.deb
apt-get update
apt-get install -y zabbix-agent
apt-get clean
