FROM ubuntu

RUN apt-get update && apt-get -y install gcc \
                make \
                curl \
                libpcre3-dev \
                libevent-dev \
                libpthread-workqueue-dev \
                zlib1g-dev

RUN curl -O "https://netcologne.dl.sourceforge.net/project/zabbix/ZABBIX Latest Stable/4.4.0/zabbix-4.4.0.tar.gz" &&\
    tar xzf zabbix-4.4.0.tar.gz 

WORKDIR zabbix-4.4.0

RUN ./configure --prefix=/usr/local/rtmonitor \
                --exec-prefix=/usr/local/rtmonitor \
                --sysconfdir=/usr/local/rtmonitor/conf \
                --bindir=/usr/local/rtmonitor/bin \
                --sbindir=/usr/local/rtmonitor/bin \
                --enable-agent \
                --enable-static \
                --disable-dependency-tracking

copy in /in

copy entrypoint.sh .

ENTRYPOINT /bin/bash entrypoint.sh

