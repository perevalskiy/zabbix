#!/bin/bash

set -e

#rm -rf /usr/local/rtmonitor/*

#./configure --prefix=/usr/local/rtmonitor \
#                --exec-prefix=/usr/local/rtmonitor \
#                --sysconfdir=/usr/local/rtmonitor/conf \
#                --bindir=/usr/local/rtmonitor/bin \
#                --sbindir=/usr/local/rtmonitor/bin \
#                --enable-agent \
#                --enable-static \
#                --disable-dependency-tracking

#make install

rm -rf /usr/local/rtmonitor/share \
       /usr/local/rtmonitor/lib \
       /usr/local/rtmonitor/bin/zabbix_get \
       /usr/local/rtmonitor/bin/zabbix_sender \
       /usr/local/rtmonitor/conf/zabbix_agentd.conf.d \
       /usr/local/rtmonitor/conf/zabbix_agentd.conf

cd /

mkdir -p /usr/local/rtmonitor/log
mkdir -p /usr/local/rtmonitor/run
mkdir -p /usr/local/rtmonitor/conf.d

cp /in/speedtest /usr/local/rtmonitor/bin/ && chmod +x /usr/local/rtmonitor/bin/speedtest

cp /in/rtmonitor.conf /usr/local/rtmonitor/conf/

cp /in/speedtest.conf /usr/local/rtmonitor/conf.d/
