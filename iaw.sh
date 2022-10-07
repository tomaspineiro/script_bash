#!/bin/bash
#echo #off
#apt update
# este script es para mover los archivos de un lado a otro para hacer la pacrtica de php de IAW, y encener lamp apache 

# Declaramos las varibles para usar en el script  
DESTINO_DIRECTORY="/opt/lampp/htdocs/"
ORIGEN_DIRECTORY="/home/tom/Descargas/"
LAMPP_DIRECTORY="/opt/lampp/lampp"
DIRECTORY="tomas"


if [ -d "$DESTINO_DIRECTORY$DIRECTORY" ]; then
   # si el irectorio exite
   
   if [ -d "$ORIGEN_DIRECTORY$DIRECTORY" ]; then
      
      rm -f -r  "$DESTINO_DIRECTORY$DIRECTORY"
      mv "$ORIGEN_DIRECTORY$DIRECTORY"  "$DESTINO_DIRECTORY$DIRECTORY"
      # esta es la duda sino lo ejecuto me da error y no me deja entrar por que tengo que darle todo los permisos 
      chmod -R 777 "$DESTINO_DIRECTORY$DIRECTORY"
      $LAMPP_DIRECTORY "startapache"

      echo "todo fue sin problemas, a trabajr "

   else 

      echo 'tio no has descagado el archivo o descomprimelo no me jodas '

   fi
else
   # no exite el directroio a donde quiero ir 
   echo 'no exite'
   if [ -d "$ORIGEN_DIRECTORY$DIRECTORY" ]; then
      
      mv "$ORIGEN_DIRECTORY$DIRECTORY"  "$DESTINO_DIRECTORY$DIRECTORY"
      
   else 

      echo 'tio no has descagado el archivo o descomprimelo no me jodas '

   fi

fi
