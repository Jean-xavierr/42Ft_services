# Comment line start with 'skip-networking'
mv /etc/my.cnf.d/mariadb-server.cnf /etc/my.cnf.d/old_mariadb-server.cnf
sed 's/^skip-networking/#&/' /etc/my.cnf.d/old_mariadb-server.cnf > /etc/my.cnf.d/mariadb-server.cnf
rm /etc/my.cnf.d/old_mariadb-server.cnf

# Config Openrc and start Mariadb
openrc
touch /run/openrc/softlevel
/etc/init.d/mariadb setup
rc-service mariadb start

Create Database wordpress
mysql -u root << EOF 
CREATE DATABASE $WP_DB_NAME;
CREATE USER '$WP_USER'@'%' IDENTIFIED BY '$PASSWORD';
GRANT ALL ON $WP_DB_NAME.* TO '$WP_USER'@'%' IDENTIFIED BY '$PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

tail -f /dev/null