#!/bin/bash
#NAME: confBind.sh
#AUTOR:Tomas Piñeiro
#AMEIL: tomaspial95@gmial.com
#GIT: https://github.com/tomaspineiro

#variables del sistema, 

etc='/etc/bind/'
var='/var/cache/bind/'

#obtener la informacion del servidor
read -p 'Nombre del dominio: ' dominio
read -p 'Nombre del servidor: ' nombre
read -p 'IP del server: ' ip


#apt list --installed >/dev/null -m1  "^bind9-utils"

function local() {
   
    archivo=$ruta'named.conf.local'

    echo '' > $archivo

    echo 'include "/etc/bind/zones.rfc1918";' >> $archivo
    echo '' >> $archivo
    echo 'zone '$dominio' {' >> $archivo
    echo '  type master;' >> $ruta
    echo '  file "db.'$dominio'";' >> $archivo
    echo '};' >> $archivo
    echo 'zone "'$( echo $ip | cut -d'.' -f 3)'.'$( echo $ip | cut -d'.' -f 2)'.'$( echo $ip | cut -d'.' -f 1)'.in-addr.arpa" {' >> $archivo
    echo '  type master;' >> $archivo
    echo '  file "db.'$( echo $ip | cut -d'.' -f 1)'.'$( echo $ip | cut -d'.' -f 2)'.'$( echo $ip | cut -d'.' -f 3)'";' >> $archivo
    echo '};' >> $archivo

    sed -i 's!zone "168.192.in-addr.arpa" { type master; file "\/etc\/bind\/db.empty"; };!///&!' $ruta'zones.rfc1918'

}

function directo() {

    archivo=$ruta'db.'$dominio

    touch $archivo

    echo '$ORIGIN '$dominio'.' >> $archivo
    echo '$TTL 86400 ;' >> $archivo
    echo '@ IN SOA '$nombre' hostmaster (' >> $archivo
    echo -e '  1; \n     21600; \n     3600; \n  604800; \n     21600; \n );'  >> $archivo
    echo '@      IN      NS      ' $nombre >> $archivo
    echo  $nombre'      IN      A       ' $ip >> $archivo

}

function inversa() {
    
    archivo=$ruta'db.'$( echo $ip | cut -d'.' -f 1)'.'$( echo $ip | cut -d'.' -f 2)'.'$( echo $ip | cut -d'.' -f 3)

    touch $archivo

    echo '$ORIGIN '$( echo $ip | cut -d'.' -f 3)'.'$( echo $ip | cut -d'.' -f 2)'.'$( echo $ip | cut -d'.' -f 1)'.in-addr.arpa.' >> $archivo
    echo '$TTL 86400 ;' >> $archivo
    echo '@ IN SOA '$nombre' hostmaster (' >> $archivo
    echo -e '   1; \n   21600; \n   3600; \n    604800; \n  21600; \n );'  >> $archivo
    echo '@     IN   NS     ' $nombre'.'$dominio'.' >> $archivo
    echo '1      IN      PTR       ' $nombre'.'$dominio'.' >> $archivo

}

#function A_insert() {
    
#    archivo=$ruta'db.'$dominio

#    sed 
#}

#function CNAME_insert() {
    
#    archivo=$ruta'db.'$dominio
#    sed 
#}
function A_CNAME() {

    read -p 'IP del apache2: ' ip1

    echo 'www       IN      CNAME       apache2' >> $ruta'db.'$dominio
    echo 'apache2   IN      A       '$ip1 >> $ruta'db.'$dominio

}

ruta=$etc
local $dominio $ip $nombre $ruta

ruta=$var
directo $dominio $ip $nombre $ruta

ruta=$var
inversa $dominio $ip $nombre $ruta

ruta=$var
A_CNAME $ruta $dominio

reboot