# simple scripts for generating wireguard interfaces and users.

## USAGE EXAMPLE:

root@debian:~> genwgcfg.sh

> Interface name: **wg5**

> Interface ipv4: **192.168.8.1**

> Listen port: **44444**

DONE

> Would you enable wg5 now? (y/n): **y**

> Created symlink /etc/systemd/system/multi-user.target.wants/wg-quick@wg5.service → /lib/systemd/system/wg-quick@.service.


root@debian:~> genwguser.sh

> Which wg interface conf (ex. wg0) : **wg5**

> Username: **user001**

> Users ip 192.168.8.**11**

> DNS: **8.8.8.8**

> Allowed IPs (ex: 192.168.0.0/24, 192.168.1.0/24) :**0.0.0.0**

> curl find out your external IPv4

**DONE**
