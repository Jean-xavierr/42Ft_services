# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup_ftps.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Jeanxavier <Jeanxavier@student.42.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/11 14:31:51 by jereligi          #+#    #+#              #
#    Updated: 2020/09/04 17:15:13 by Jeanxavier       ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

set -x
mkdir -p /srcs/ftp/$USER
echo -e "$PASSWORD\n$PASSWORD" | adduser -h /srcs/ftp/$USER $USER
chown $USER:$USER /srcs/ftp/$USER
mkdir /srcs/ftp/$USER/folder_text
chown $USER:$USER /srcs/ftp/$USER/folder_text
touch /srcs/ftp/$USER/folder_text/text.txt

exec /usr/sbin/vsftpd -opasv_min_port=21000 -opasv_max_port=21010 -opasv_address=192.168.99.6 /etc/vsftpd/vsftpd.conf & tail -f /dev/null