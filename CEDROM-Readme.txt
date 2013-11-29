#CEDROM TODO
vi /etc/apt/source.list

apt-get install sudo
apt-get install unzip
apt-get install vi
apt-get install java-common

mkdir /cedromsni
cd /cedromsni
scp root@10.1.5.148:/cedrom-sni/CEDROM-ES-INSTALL.tar /cedromsni/.
scp root@10.1.5.148:/cedrom-sni/oracle-java7-installer_7u25.deb /cedromsni/.

dpkg -i oracle-java7-installer_7u25.deb
tar -xvf CEDROM-ES-INSTALL.tar
cd /cedromsni/install
./ES-NODE.sh