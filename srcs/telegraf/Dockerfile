FROM alpine:latest
MAINTAINER Jereligi <jereligi@student.42.fr>

# Install Telegraf
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.15.2_linux_amd64.tar.gz \
&& tar -zxf telegraf-1.15.2_linux_amd64.tar.gz \
&& mv telegraf-1.15.2 telegraf \
&& rm telegraf-1.15.2_linux_amd64.tar.gz
RUN cp -rf telegraf/etc/* /etc/
RUN cp -rf telegraf/usr/* /usr/
RUN apk add openrc

# Required by telegraf
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

ADD /srcs/setup.sh 			/srcs/setup.sh
ADD /srcs/livenessprobe.sh	/srcs/livenessprobe.sh
ADD /srcs/telegraf.conf 	/etc/telegraf/telegraf.conf

EXPOSE 8125

CMD ["telegraf"]