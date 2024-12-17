#!/bin/bash
# echo off

# ESP: OBJETIVO DEL SCRIPT: Este script está diseñado para instalar las dependencias necesarias (como 'at' y 'zenity') en un sistema Linux para que puedas ejecutar un script de alarma en cualquier momento y desde cualquier directorio.
# ING: SCRIPT OBJECTIVE: This script is designed to install the necessary dependencies (such as 'at' and 'zenity') on a Linux system so you can run an alarm script at any time and from any directory

# ESP: Actualiza la lista de paquetes disponibles y Realiza una actualización de todos los paquetes instalados en el sistema.
# ING: Updates the list of available packages and Upgrades all installed packages to the latest available versions.
apt update
apt upgrade -y

# ESP: Instala el paquete 'at' que permite programar tareas.
# ING: Installs the 'at' package, which allows scheduling tasks.
apt install at -y

# ESP: Instala el paquete 'zenity' que permite crear ventanas emergentes (popups).
# ING: Installs the 'zenity' package, which allows creating popup windows.
apt install zenity -y

# ESP: Copia el script 'alarma.sh' al directorio '/usr/local/bin' para hacerlo ejecutable desde cualquier ubicación.
# ING: Copies the 'alarma.sh' script to the '/usr/local/bin' directory to make it executable from anywhere.
cp alarma.sh /usr/local/bin/alarma

# ESP: Da permisos de ejecución al archivo 'alarma' en '/usr/local/bin'.
# ING: Grants execution permissions to the 'alarma' file in '/usr/local/bin'.
chmod +x /usr/local/bin/alarma