# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    script_init_ftp.sh                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jereligi <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/11 14:31:51 by jereligi          #+#    #+#              #
#    Updated: 2020/03/12 14:39:48 by jereligi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

echo -e "test2018\ntest2018" | adduser -h /src/ftp/jereligi jereligi
mkdir -p /src/ftp/jereligi
chown jereligi /src/ftp/jereligi
mkdir /src/ftp/jereligi/folder_text
touch /src/ftp/jereligi/folder_text/text.txt

exec /usr/sbin/vsftpd -opasv_min_port=21000 -opasv_max_port=21010 -opasv_address=127.0.0.1 /etc/vsftpd/vsftpd.conf
