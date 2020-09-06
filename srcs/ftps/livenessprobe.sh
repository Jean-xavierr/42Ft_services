# Livenessprobe check if vsftpd is running
if [ $(ps | grep -c vsftpd) != "2" ]; then
	return -1
fi