# Phpmyadmin starting
set -x # Print commands and their arguments as they are executed
mv phpMyAdmin-5.0.2-all-languages/* www/phpmyadmin/
php -S 0.0.0.0:5000 -t /www/phpmyadmin