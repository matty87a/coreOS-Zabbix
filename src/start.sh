#!/bin/sh

if [ $ZABBIX_SERVER ]; then
	sed -i "s/Server=.*/Server=$ZABBIX_SERVER/g" /etc/zabbix/zabbix_agentd.conf
	sed -i "s/ServerActive=.*/ServerActive=$ZABBIX_SERVER/g" /etc/zabbix/zabbix_agentd.conf
fi

if [ $ZABBIX_HOSTNAME ]; then
	sed -i "s/Hostname=.*/Hostname=$ZABBIX_HOSTNAME/g" /etc/zabbix/zabbix_agentd.conf
fi

mkdir -p /var/run/zabbix ; chown -R zabbix:zabbix /var/run/zabbix
/usr/sbin/zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf && tail -f /dev/null
