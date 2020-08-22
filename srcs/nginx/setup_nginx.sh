# Nginx start
openrc
touch /run/openrc/softlevel
service nginx start

tail -f /dev/null # Freeze command to avoid end of container