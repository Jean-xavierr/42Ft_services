FROM alpine
MAINTAINER Jereligi <jereligi@student.42.fr>

# install package VIM | FTPS
RUN apk update && apk add vim && apk add bash && apk add vsftpd

ADD ./vsftpd.conf ./etc/vsftpd/vsftpd.conf
ADD ./script_init_ftp.sh	./utils/script_init_ftp.sh

CMD ./utils/script_init_ftp.sh
