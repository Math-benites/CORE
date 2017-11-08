echo source /etc/network/interfaces.d/* >> /etc/network/interfaces
echo >> /etc/network/interfaces
echo auto lo >> /etc/network/interfaces
echo iface lo inet loopback >> /etc/network/interfaces
echo PLACA DE REDE COM INTERNET? eth0,eth1
read FACE0
echo >> /etc/network/interfaces
echo auto $FACE0 >> /etc/network/interfaces
echo allow-hotplug $FACE0 >> /etc/network/interfaces
echo iface $FACE0 inet dhcp >> /etc/network/interfaces
echo >> /etc/network/interfaces
echo INTERFACE REDE PROXY eth0/eth1
echo FACE
echo auto $FACE  >> /etc/network/interfaces 
echo iface $FACE inet static >> /etc/network/interfaces
echo IP ADDRESS DA REDE PROXY /192.168.1.1
read ADD
echo address $ADD >> /etc/network/interfaces 
echo NETMASK DA REDE PROXY /255.255.255.0
read NET
echo netmask $NET >> /etc/network/interfaces
echo GATEWAY DA REDE PROXY /192.168.1.1
read NWORK
echo network $NWORK >> /etc/network/interfaces
echo BROADCAST DA REDE PROXY /192.168.1.255
echo broadcast $BROAD >> /etc/network/interfaces
exit
