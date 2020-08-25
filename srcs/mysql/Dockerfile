FROM alpine:latest
MAINTAINER Jereligi <jereligi@student.42.fr>

# Install Mariadb
RUN apk update \
&& apk add mariadb mariadb-client openrc

ADD setup.sh 		/srcs/setup.sh

# CMD ["sh", "/srcs/setup.sh"]