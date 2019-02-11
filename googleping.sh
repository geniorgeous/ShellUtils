#!/bin/bash

ping www.google.com -c 1
ping=`ping www.google.com -c 1`
result=$?
if [ $result == 0 ]
	then
		echo 'PING of Google OK => connected on the Internet'
	else
		echo 'PING error => not connected on the Internet'
fi
exit $result