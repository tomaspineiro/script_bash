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

#procesamos los datos 
ip1=$( echo $ip | cut -d'.' -f 1)
ip2=$( echo $ip | cut -d'.' -f 2)
ip3=$( echo $ip | cut -d'.' -f 3)



function local () {
   
    archivo=$ruta'named.conf.local'

    echo '' > $archivo

    echo 'include "/etc/bind/zones.rfc1918";' >> $archivo
    echo '' >> $archivo
    echo 'zone '$dominio' {' >> $archivo
    echo '  type master;' >> $ruta
    echo '  file "db.'$dominio'";' >> $archivo
    echo '};' >> $archivo
    echo 'zone "'$ip3'.'$ip2'.'$ip1'.in-addr.arpa" {' >> $archivo
    echo '  type master;' >> $archivo
    echo '  file "db.'$ip1'.'$ip2'.'$ip3'";' >> $archivo
    echo '};' >> $archivo

    sed -i 's/zone "168.192.in-addr.arpa" { type master; file "\/etc\/bind\/db.empty"; };/\/\/\/zone "168.192.in-addr.arpa" { type master; file "\/etc\/bind\/db.empty"; };/' zones.rfc1918

}

function directo () {
   
    echo ' #### ' >> $ruta

    echo '$ORIGIN '$dominio'.' >> $ruta
    echo '$TTL 86400 ;' >> $ruta
    echo '@ IN SOA '$nombre' hostmaster (' >> $ruta
    echo '  1;' \n '    21600;' \n '    3600;' \n ' 604800;' \n '    21600;' \n ');'  >> $ruta
    echo '@      IN      NS      ' $nombre >> $ruta
    echo  $nombre'      IN      A       ' $ip >> $ruta

}

function inversa () {
   
    echo ' #### ' >> $ruta

    echo '$ORIGIN '$ip3'.'$ip2'.'$ip1'.in-addr.arpa' >> $ruta
    echo '$TTL 86400 ;' >> $ruta
    echo '@ IN SOA '$nombre' hostmaster (' >> $ruta
    echo '  1;' \n '    21600;' \n '    3600;' \n ' 604800;' \n '    21600;' \n ');'  >> $ruta
    echo '@     IN   NS     ' $nombre'.'$dominio'.' >> $ruta
    echo '1      IN      PTR       ' $nombre'.'$dominio'.' >> $ruta

}



ruta=$etc
local $dominio $ip3 $ip2 $ip1 $ip $nombre $ruta

directo $dominio $ip3 $ip2 $ip1 $ip $nombre $ruta

inversa $dominio $ip3 $ip2 $ip1 $ip $nombre $ruta



cat $ruta

