#!/bin/bash
#NAME: confBind.sh
#AUTOR:Tomas Piñeiro
#AMEIL: tomaspial95@gmial.com
#GIT: https://github.com/tomaspineiro

PS3="Select the operation: "

select opt in 'Instalar y configurar Bind 9' 'Indicar host  (A)' 'Indicar redirecion (CNAME)' 'Indiar un nuevo host y redirecion A CNAME ' 'EXIT'; 
do
   case $opt in 

        'Instalar y configurar Bind 9')

            echo 'Instalar y configurar Bind 9'
            ayuda
            read -p '' n 

        ;;
        
        'Indicar host  (A)')

            echo 'Indicar host  (A) ' 
            echo $etc
            read -p '' n  
        ;;
        
        'Indicar redirecion (CNAME)')

            echo 'Indicar redirecion (CNAME)' 
            echo $var
            read -p '' n  
        
        ;;
        
        'Indiar un nuevo host y redirecion A CNAME ')
            
            echo 'Indiar un nuevo host y redirecion A CNAME '   
            read -p '' n
        ;;
        
        'EXIT')
            
            echo 'EXIT' 
            read -p '' n 
            break

        ;;
    esac 
done

echo 'E salido del menu'