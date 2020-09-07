# Livenessprobe check if php built-in webserver is running
if [ $(ps | grep -c php) < "2" ]; then
	return -1
fi