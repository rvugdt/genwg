#!/bin/bash

echo -n "Interface name: "; read interface
echo -n "Interface ipv4: "; read iip
echo -n "Listen port: "; read port

wgintcfg="/etc/wireguard/$interface.conf"
wgintdir="/etc/wireguard/$interface"
keysdir="$wgintdir/keys"

if [ ! -f $wgintcfg ]; then

mkdir -p $keysdir

wg genkey | tee $keysdir/privatekey | wg pubkey > $keysdir/publickey

privkey=$(cat $keysdir/privatekey)
pubkey=$(cat $keysdir/publickey)

cat <<EOF > $wgintcfg
[Interface]
PrivateKey=$privkey
ListenPort=$port
Address=$iip/24

EOF

echo "DONE"
read -p "Would you enable $interface now? (y/n): " answer
if [[ "$answer" == "y" ]]; then
  systemctl enable --now wg-quick@$interface
fi
exit 0
fi
echo "ERROR: $wgintcfg not found!"
exit 1
