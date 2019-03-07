#!/bin/bash

PORT_SPEED_BASE=".1.3.6.1.2.1.2.2.1.5" # + port id (int)
PORT_STATUS_BASE=".1.3.6.1.2.1.2.2.1.8" # + port id (int)

RESULT_JSON='{"ports": ['
IP="$1"

if [[ $# == 0 ]]; then
	echo "IP address required"
	return
fi


for port in $(echo {1..28} 11001); do
#	oid="$PORT_SPEED_BASE.$port"
#	echo $oid
	spd_query=$(snmpget -v2c -c private -Oqv "$IP" "$PORT_SPEED_BASE.$port")
	status_query=$(snmpget -v2c -c private -Oqv "$IP" "$PORT_STATUS_BASE.$port")

	if [[ $status_query =~ No\ Such\ Instance\ .* ]]; then
		status_query="-1"
		spd_query="-1"
	fi

	RESULT_JSON="$RESULT_JSON\n  {\"port\":$port,  \"status\": $status_query, \"spd\":$spd_query}"

	if [[ $port != "11001" ]]; then
		RESULT_JSON="$RESULT_JSON,"
	fi
done

RESULT_JSON="$RESULT_JSON\n]}"

echo -en $RESULT_JSON
