openrc
touch /run/openrc/softlevel
mv phpMyAdmin-5.0.2-all-languages/* www/phpmyadmin/
php -S 0.0.0.0:5000 -t /www/phpmyadmin