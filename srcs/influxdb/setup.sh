openrc
touch /run/openrc/softlevel
service influxdb start 
sleep 3
influx << EOF
CREATE DATABASE $INFLUXDB_NAME;
CREATE USER "$INFLUXDB_USER" WITH PASSWORD '$PASSWORD' WITH ALL PRIVILEGES;
GRANT ALL ON $INFLUXDB_NAME TO $INFLUXDB_USER;
EOF
# telegraf
tail -f /dev/null