#!/bin/bash

default_check_timeout=3
error_code=-65535
ssl_ca_path=/etc/ssl/certs

function show_help() {
	echo $error_code
	cat >&2 << EOF
	Usage: $(basename $0) expire|valid hostname|ip port [domain] [check_timeout]
	Script checks SSL cerfificate expiration and validity for HTTPS.
	domain is optional, default is hostname
	check_timeout is optional, default is $default_check_timeout seconds.
	Output:
	* expire:
	  * N	number of days left before expiration, 0 or negative if expired
	  * $error_code	failed to get certificate
	* valid:
	  * 1	valid
	  * 0	invalid
	  * $error_code	failed to get certificate
	Return code is always 0, otherwise zabbix agent fails to get item value and triggres would not work.
EOF

}

function error() { echo $error_code; echo "ERROR: $@" >&2; exit 0; }

function result() { echo "$1"; exit 0; }

# Arguments
host="$1"
port=443
domain="${2:-$host}"
check_timeout="${3:-$default_check_timeout}"

# Check if required utilites exist
for util in timeout openssl date; do
	type "$util" >/dev/null || error "Not found in \$PATH: $util"
done

# Check arguments
[ "$#" -lt 1 ] && show_help && exit 0
[[ "$port" =~ ^[0-9]+$ ]] || error "Port should be a number"
[ "$port" -ge 1 -a "$port" -le 65535 ] || error "Port should be between 1 and 65535"
[[ "$check_timeout" =~ ^[0-9]+$ ]] || error "Check timeout should be a number"

# Get certificate
output=$( echo \
| timeout "$check_timeout" openssl s_client -CApath "$ssl_ca_path" -servername "$domain" -verify_hostname "$domain" -connect "$host":"$port" 2>/dev/null )
[ $? -ne 0 ] && error "Failed to get certificate"

# Run checks

expire_date=$( echo "$output" \
| openssl x509 -noout -dates \
| grep '^notAfter' | cut -d'=' -f2 )

expire_date_epoch=$(date -d "$expire_date" +%s) || error "Failed to get expire date"
current_date_epoch=$(date +%s)
days_left=$(( ($expire_date_epoch - $current_date_epoch)/(3600*24) ))
result "$days_left"

