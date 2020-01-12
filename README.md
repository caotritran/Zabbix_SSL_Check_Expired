# Zabbix_SSL_Check_Expired

Thanks to `selivan` and `omni-lchen` with refer link as below:

https://github.com/selivan/https-ssl-cert-check-zabbix

https://github.com/omni-lchen/zabbix-ssl/tree/master/zabbix-externalscripts

I created template and custom script both that author.

Guiline:
At host need add templates.
 
1. install jq package: https://stedolan.github.io/jq/
`yum install jq -y`

2. Create userparameter as folder `zabbix_agent.d/`

3. Put correct path scripts and remember check permission zabbix can excute check.
`mkdir /etc/zabbix/ssl_expire_check`
```
[root@localhost ssl_expire_check]# ll
total 12
-rwxr-xr-x 1 zabbix zabbix  369 11:39 12 Th01 domainDiscovery.sh
-rw-r--r-- 1 root   root    287 10:54 12 Th01 domains_list.json
-rwxr-xr-x 1 zabbix zabbix 1917 10:00 12 Th01 ssl_check_cert.sh
```

4. import template in folder `template/` at Zabbix >> Configuration >> Templates

Happy Monitor !!! :))
