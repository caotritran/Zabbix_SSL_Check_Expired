# Zabbix_SSL_Check_Expired

Thanks to `selivan` and `omni-lchen` with refer link as below:

https://github.com/selivan/https-ssl-cert-check-zabbix

https://github.com/omni-lchen/zabbix-ssl/tree/master/zabbix-externalscripts

I created template and custom script both that author.

Guiline:
At host need add templates.
 
1. install zabbix sender
`yum install zabbix-sender -y`

2. Create userparameter as folder `zabbix_agent.d/`

3. Put correct path scripts and remember check permission zabbix can excute check.
`/usr/lib/zabbix/externalscripts/ssl_check_cert.sh`

```
[root@monitor-sweb zabbix_agentd.d]# ll ../
total 60
-rwxr-xr-x 1 zabbix zabbix  1148 02:33 29 Th12 domaindiscover.pl
-rw-r--r-- 1 zabbix zabbix   932 09:58 29 Th12 domain.list
```

4. import template in folder `template/` at Zabbix >> Configuration >> Templates

Happy Monitor !!! :))
