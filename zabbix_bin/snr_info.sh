#!/bin/bash

IP="$1"

OID_arr=(
.1.3.6.1.2.1.1.5.0 # device name
.1.3.6.1.2.1.1.1.0 # device description
.1.3.6.1.2.1.1.3.0 # device uptime
)

for oid in ${OID_arr[*]}; do
	snmpget -v2c -c private -Oqv "$IP" "$oid"
done
