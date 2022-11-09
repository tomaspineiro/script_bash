#!/bin/bash

#variables del sistema, 

etc='/etc/bind/'
var='/var/cache/bind/'
ruta='$ruta'
#obtener la informacion del servidor
read -p 'Nombre del dominio: ' dominio
read -p 'Nombre del servidor: ' nombre
read -p 'IP del server: ' ip

#procesamos los datos 
ip1=$( echo $ip | cut -d'.' -f 1)
ip2=$( echo $ip | cut -d'.' -f 2)
ip3=$( echo $ip | cut -d'.' -f 3)

function local() {
   
    echo '' > $ruta

    echo 'include "/etc/bind/zones.rfc1918";' >> $ruta
    echo '' >> $ruta
    echo 'zone '$dominio' {' >> $ruta
    echo '  type master;' >> $ruta
    echo '  file "db.'$dominio'";' >> $ruta
    echo '};' >> $ruta
    echo 'zone "'$ip3'.'$ip2'.'$ip1'.in-addr.arpa" {' >> $ruta
    echo '  type master;' >> $ruta
    echo '  file "db.'$ip1'.'$ip2'.'$ip3'";' >> $ruta
    echo '};' >> $ruta

}

function directo() {
   
    echo '' > $ruta

    echo '$ORIGIN '$dominio'.' >> $ruta
    echo '$TTL 86400 ;' >> $ruta
    echo '@ IN SOA '$nombre' hostmaster (' >> $ruta
    echo '  1;' \n '    21600;' \n '    3600;' \n ' 604800;' \n '    21600;' \n ');'  >> $ruta
    echo '@      IN      NS      ' $nombre >> $ruta
    echo '1      IN      A       ' $ip >> $ruta

}

function inversa() {
   
    echo '' > $ruta

    echo '$ORIGIN '$ip3'.'$ip2'.'$ip1'.in-addr.arpa' >> $ruta
    echo '$TTL 86400 ;' >> $ruta
    echo '@ IN SOA '$nombre' hostmaster (' >> $ruta
    echo '  1;' \n '    21600;' \n '    3600;' \n ' 604800;' \n '    21600;' \n ');'  >> $ruta
    echo '@     IN   NS     ' $nombre >> $ruta
    echo '1      IN      A       ' $ip >> $ruta

}
local $dominio $ip3 $ip2 $ip1 $ruta
directo $dominio $ip3 $ip2 $ip1 $ip $nombre $ruta
cat $ruta

