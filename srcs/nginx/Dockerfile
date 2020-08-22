FROM alpine:latest
MAINTAINER Jereligi <jereligi@student.42.fr>

# Install Nginx and dependencies
RUN apk update && apk add openrc \
&& apk add nginx && apk add vim \
&& apk add openssl

ADD nginx.conf /etc/nginx/nginx.conf
ADD setup_nginx.sh setup_nginx.sh
RUN chmod +x setup_nginx.sh
RUN mkdir www
ADD index.html /www/index.html

# KEY SSH
ADD nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
ADD nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key

EXPOSE 80 443 301

# CMD ["sh", "./setup_nginx.sh"]