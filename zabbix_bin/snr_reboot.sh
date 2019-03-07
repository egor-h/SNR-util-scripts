#!/bin/bash
if [[ $# == 0 ]]; then
	echo "Error: IP address is required"
	exit 1
fi

echo "Reboot $1"
snmpset -v2c -c private "$1" .1.3.6.1.4.1.40418.7.100.1.1.0 i 3
