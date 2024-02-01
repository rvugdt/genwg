#!/usr/bin/bash

echo -n "Which wg interface conf (ex. wg0) : "; read wgintname

if [ -f /etc/wireguard/$wgintname.conf ]; then
  wgintconf="/etc/wireguard/$wgintname.conf"
  wgintaddr=$(grep "Address" $wgintconf | cut -d '=' -f2 | cut -d '/' -f 1 | sed 's/ //')
  wgintaddrprefix=$(echo $wgintaddr | cut -d '.' -f1-3)
  wgintaddrprefix="$wgintaddrprefix."
  wgintport=$(grep ListenPort wgusers.conf | cut -d '=' -f2 | sed 's/ //')

  echo -n "Username: "; read username
  echo -n "Users ip $wgintaddrprefix"; read useraddr
  useraddr="$wgintaddrprefix$useraddr"
  echo -n "DNS: "; read DNS
  if [ -n "$DNS" ]; then
    DNS="DNS=$DNS"
  fi
  echo -n "Allowed IPs (ex: 192.168.0.0/24, 192.168.1.0/24) :"; read allowedips
  if [ -n "$allowedips" ]; then
    allowedips=", $allowedips"
  fi

  usercfgdir="/etc/wireguard/$wgintname/$username"

  mkdir -p $usercfgdir
  usrcfg=$usercfgdir/$username.conf
  wg genkey | tee $usercfgdir/privatekey | wg pubkey > $usercfgdir/publickey
  wg genpsk > $usercfgdir/psk

  pubk=$(cat $usercfgdir/publickey)
  privk=$(cat $usercfgdir/privatekey)
  psk=$(cat $usercfgdir/psk)

  # GENERATING USER CONF
cat <<EOF > $usrcfg
[Interface]
PrivateKey=$privk
Address=$useraddr/24
$DNS

[Peer]
PublicKey=$(cat /etc/wireguard/$wgint/keys/publickey)
PresharedKey=$psk
AllowedIPs=$wgintaddr/32$allowedips
Endpoint=$(curl -4 ifconfig.me):$wgintport
PersistentKeepalive=25

EOF

cat <<EOF >> $wgintconf

#$username
[Peer]
PublicKey=$pubk
PresharedKey=$psk
AllowedIPs=$useraddr/32
PersistentKeepalive=25

EOF

systemctl reload wg-quick@$wgintname
echo "DONE"
exit 0
fi

echo "ERROR: $wgintconf not found"
exit 1
