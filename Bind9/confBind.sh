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
   
    archivo=$ruta #'named.conf.local'

    

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

    #sed -i 's/zone "168.192.in-addr.arpa" { type master; file "\/etc\/bind\/db.empty"; };/\/\/\/zone "168.192.in-addr.arpa" { type master; file "\/etc\/bind\/db.empty"; };/' $ruta'zones.rfc1918'

}

function directo () {

    echo '$ORIGIN '$dominio'.' >> $ruta
    echo '$TTL 86400 ;' >> $ruta
    echo '@ IN SOA '$nombre' hostmaster (' >> $ruta
    echo -e '  1; \n     21600; \n     3600; \n  604800; \n     21600; \n );'  >> $ruta
    echo '@      IN      NS      ' $nombre >> $ruta
    echo  $nombre'      IN      A       ' $ip >> $ruta

}

function inversa () {
   
    echo '$ORIGIN '$( echo $ip | cut -d'.' -f 3)'.'$( echo $ip | cut -d'.' -f 2)'.in-addr.arpa' >> $ruta
    echo '$TTL 86400 ;' >> $ruta
    echo '@ IN SOA '$nombre' hostmaster (' >> $ruta
    echo -e '   1; \n   21600; \n   3600; \n    604800; \n  21600; \n );'  >> $ruta
    echo '@     IN   NS     ' $nombre'.'$dominio'.' >> $ruta
    echo '1      IN      PTR       ' $nombre'.'$dominio'.' >> $ruta

}



ruta='./Bind9/txt.txt'

echo '' > $ruta

local $dominio $ip $nombre $ruta

echo -e  '\n #### ' >> $ruta
echo -e  ' #### \n' >> $ruta

directo $dominio $ip $nombre $ruta

echo -e  '\n #### ' >> $ruta
echo -e  ' #### \n' >> $ruta

inversa $dominio $ip $nombre $ruta





