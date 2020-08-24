openrc
touch /run/openrc/softlevel
/etc/init.d/mariadb setup
rc-service mariadb start
mysql -u root < /srcs/create_database

tail -f /dev/null