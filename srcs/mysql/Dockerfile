FROM alpine:latest
MAINTAINER Jereligi <jereligi@student.42.fr>

# Install Mariadb
RUN apk update \
&& apk add mariadb mariadb-client openrc

ADD setup.sh 		/srcs/setup.sh
ADD wordpress.sql /srcs/wordpress.sql

EXPOSE 3306

CMD ["sh", "/srcs/setup.sh"]