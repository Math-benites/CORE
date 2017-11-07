#!/bin/Sh
echo source /etc/network/interfaces.d/* >> /etc/network/interfaces
echo # Placa de rede LoopBack >> /etc/network/interfaces
echo auto lo >> /etc/network/interfaces
echo iface lo inet loopback >> /etc/network/interfaces
ECHO PLACA DE REDE COM INTERNET (eth0,eth1)
READ FACE0;
#Placa de rede com ip automatico >> /etc/network/interfaces
auto $FACE0 >> /etc/network/interfaces
allow-hotplug $FACE0 >> /etc/network/interfaces
iface $FACE0 inet dhcp >> /etc/network/interfaces
echo #Placa de rede para a rede interna >> /etc/network/interfaces
ECHO INTERFACE REDE PROXY (eth0,eth1)
READ FACE;
echo auto $FACE  >> /etc/network/interfaces 
echo iface $FACE inet static >> /etc/network/interfaces
ECHO IP ADDRESS DA REDE PROXY (192.168.1.1)
READ ADD;
echo address $ADD >> /etc/network/interfaces 
ECHO NETMASK DA REDE PROXY (255.255.255.0)
READ NET;
echo netmask $NET >> /etc/network/interfaces
ECHO GATEWAY DA REDE PROXY (192.168.1.1)
READ NWORK;
echo network $NWORK >> /etc/network/interfaces
ECHO BROADCAST DA REDE PROXY (192.168.1.255)
echo broadcast $BROAD 192.168.1.255 >> /etc/network/interfaces
exit
