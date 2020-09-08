#!/bin/ash
service nginx status
return_nginx=$?
service sshd status
return_sshd=$?
if [ $return_nginx = 0 ] && [ $return_sshd = 0 ]; then
	exit 0
else
	exit 1
fi