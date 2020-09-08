# Influxdb starting
set -x # Print commands and their arguments as they are executed
openrc
touch /run/openrc/softlevel
service influxdb start 
sleep 3
# Create Database
influx << EOF
CREATE DATABASE $INFLUXDB_NAME;
CREATE USER "$INFLUXDB_USER" WITH PASSWORD '$PASSWORD' WITH ALL PRIVILEGES;
GRANT ALL ON $INFLUXDB_NAME TO $INFLUXDB_USER;
EOF

tail -f /dev/null  # Freeze command to avoid end of container