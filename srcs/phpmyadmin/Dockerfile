FROM alpine:latest
MAINTAINER Jereligi <jereligi@student.42.fr>

# Install PhpMyAdmin and dependencies
RUN apk update && apk add openrc \
&& apk add wget php7 php7-fpm \
php7-opcache php7-gd php7-mysqli \
php7-zlib php7-curl php7-mbstring \
php7-json php7-session

RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
&& tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
&& rm phpMyAdmin-5.0.2-all-languages.tar.gz \
&& mkdir www/ \
&& cd www/ && mkdir phpmyadmin 

ADD /srcs/setup.sh 				/srcs/setup.sh
ADD /srcs/config.inc.php		/www/phpmyadmin
ADD /srcs/livenessprobe.sh		/srcs/livenessprobe.sh

EXPOSE 5000

CMD ["sh", "/srcs/setup.sh"]