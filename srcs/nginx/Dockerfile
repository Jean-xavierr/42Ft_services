FROM alpine:latest
MAINTAINER Jereligi <jereligi@student.42.fr>

# Install Nginx and dependencies
RUN apk update && apk add openrc \
&& apk add nginx openssl openssh

ADD /srcs/nginx.conf		/etc/nginx/nginx.conf
ADD /srcs/setup.sh 			/srcs/setup.sh
RUN chmod +x 				/srcs/setup.sh
RUN mkdir www
ADD /srcs/index.html		/www/index.html
ADD /srcs//livenessprobe.sh	/srcs/livenessprobe.sh

# CONFIG OPENSSL
RUN openssl req -x509 -nodes -subj '/C=FR/ST=PARIS/L=PARIS/O=jereligi/CN=localhost' \
		 -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
		 -out /etc/ssl/certs/nginx-selfsigned.crt
# CONGIF SSH
ADD /srcs/sshd_config 		/etc/ssh/

EXPOSE 22 80 443

CMD ["sh", "/srcs/setup.sh"]