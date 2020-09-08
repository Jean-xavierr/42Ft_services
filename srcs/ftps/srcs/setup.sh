# ftps starting
set -x # Print commands and their arguments as they are executed
mkdir -p /srcs/ftp/$USER
echo -e "$PASSWORD\n$PASSWORD" | adduser -h /srcs/ftp/$USER $USER
chown $USER:$USER /srcs/ftp/$USER
mkdir /srcs/ftp/$USER/folder_text
chown $USER:$USER /srcs/ftp/$USER/folder_text
touch /srcs/ftp/$USER/folder_text/text.txt

exec /usr/sbin/vsftpd -opasv_min_port=21000 -opasv_max_port=21010 -opasv_address=192.168.99.2 /etc/vsftpd/vsftpd.conf & tail -f /dev/null