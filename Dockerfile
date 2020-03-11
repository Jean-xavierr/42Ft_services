FROM alpine
MAINTAINER Jereligi <jereligi@student.42.fr>

# install package VIM | FTPS
RUN apk update && apk add vim && apk add vsftpd

ADD ./srcs/vsftpd.conf ./etc/vsftpd/vsftpd.conf
ADD ./srcs/script_init_ftp.sh	./utils/script_init_ftp.sh

CMD ./utils/script_init_ftp.sh
