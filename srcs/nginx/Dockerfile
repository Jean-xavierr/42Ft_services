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

# CONFIG OPENSSL
RUN openssl req -x509 -nodes -subj '/C=FR/ST=PARIS/L=PARIS/O=jereligi/CN=localhost' -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

EXPOSE 80 443 301

CMD ["sh", "./setup_nginx.sh"]