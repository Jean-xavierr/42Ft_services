FROM alpine:latest
MAINTAINER Jereligi <jereligi@student.42.fr>

# Install FTPS and dependencis
RUN apk update \
&& apk add vsftpd && apk add openssl curl

ADD /srcs/vsftpd.conf			/etc/vsftpd/vsftpd.conf
ADD /srcs/setup.sh				/srcs/setup.sh
ADD /srcs/livenessprobe.sh		/srcs/livenessprobe.sh

# CONFIG OPENSSL
RUN openssl req -x509 -nodes -subj '/C=FR/ST=PARIS/L=PARIS/O=jereligi/CN=localhost' \
		-days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key \
		 -out /etc/ssl/certs/vsftpd.crt

EXPOSE 20 21 21000-21010

CMD ["sh", "/srcs/setup.sh"]