# Grafana starting
set -x # Print commands and their arguments as they are executed
cd /grafana/bin/
./grafana-server

# http://influxdb-service.default.svc.cluster.local:8086
# database : telegraf