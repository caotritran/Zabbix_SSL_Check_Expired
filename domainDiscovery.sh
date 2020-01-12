#!/bin/bash

DOMAIN_GROUP="DomainGroup1"
ALL_DOMAINS="/etc/zabbix/ssl_expire_check/domains_list.json"
QUERY_DOMAINS=$(cat $ALL_DOMAINS | jq  --arg DOMAIN_GROUP $DOMAIN_GROUP -r '.[$DOMAIN_GROUP][] | .domain.name' | xargs 2>/dev/null)

for domain in $QUERY_DOMAINS; do
  domainlist="$domainlist,"'{"{#DOMAIN}":"'${domain# }'"}'
done
echo '{"data":['${domainlist#,}']}'
