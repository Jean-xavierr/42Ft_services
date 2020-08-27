FROM alpine:latest
MAINTAINER Jereligi <jereligi@student.42.fr>

# Install Influxdb and Telegraf
RUN apk add openrc influxdb

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.15.2_linux_amd64.tar.gz \
&& tar -zxf telegraf-1.15.2_linux_amd64.tar.gz \
&& mv telegraf-1.15.2 telegraf \
&& rm telegraf-1.15.2_linux_amd64.tar.gz

ADD setup.sh /srcs/setup.sh

EXPOSE 8086

CMD ["sh", "/srcs/setup.sh"]