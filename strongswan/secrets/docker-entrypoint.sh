#!bin/sh

/usr/libexec/ipsec/charon &
sleep 5
iptables -t nat -A POSTROUTING -s 192.168.0.1 -m policy --dir out --pol ipsec -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.0.1 -j MASQUERADE
swanctl -q
swanctl --log

