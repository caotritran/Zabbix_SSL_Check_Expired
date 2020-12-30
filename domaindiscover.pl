#!/bin/bash

#DOMAIN_GROUP="DomainGroup1"
#ALL_DOMAINS="/etc/zabbix/ssl_expire_check/domains_list.json"
#QUERY_DOMAINS=$(cat $ALL_DOMAINS | jq  --arg DOMAIN_GROUP $DOMAIN_GROUP -r '.[$DOMAIN_GROUP][] | .domain.name' | xargs 2>/dev/null)

#for domain in $QUERY_DOMAINS; do
#  domainlist="$domainlist,"'{"{#DOMAIN}":"'${domain# }'"}'
#done
#echo '{"data":['${domainlist#,}']}'


#!/usr/bin/perl

use strict;

my $first = 1;
my %hash = ();

open(FILE1, "/etc/zabbix/domain.list") || die "Error: $!\n";

print "{\n";
print "\t\"data\":[\n\n";

while (<FILE1>) {
                my $domain = substr($_, 0, -1);
                print ",\n" if not $first;
                $first = 0;

                print "\t{\n";
                print "\t\t\"{#DOMAIN}\":\"$domain\"\n";
                print "\t}";
		
}

print "\n\t]\n";
print "}\n";
