FROM phusion/baseimage

ADD ./src/build.sh /build.sh
RUN chmod +x /build.sh
RUN /build.sh
RUN rm -f /build.sh

EXPOSE 10050:10050

ADD ./src/start.sh /
RUN chmod +x /start.sh

RUN mkdir -p /var/log/extra ; touch /var/log/extra/logs ; chmod 666 /var/log/extra/logs
RUN mkdir -p /var/run/zabbix ; chown -R zabbix:zabbix /var/run/zabbix

RUN chmod +s /usr/bin/curl

RUN touch /etc/default/locale

RUN mkdir -p /var/log/extra/
RUN mkdir -p /etc/zabbix
ADD ./opt /opt
RUN chmod +x /opt/zabbix/bin/*
ADD ./etc/zabbix /etc/zabbix
ENTRYPOINT ["/start.sh"]
