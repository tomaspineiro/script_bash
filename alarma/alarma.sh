#!/bin/bash
#echo off

# ESP: OBJETIVO DEL SCRIPT: Este programa lo creo con el fin de tener una manera sencilla de crear alarmas con popups mientras trabajo.
# ING: SCRIPT OBJECTIVE: This program is created to provide a simple way to set up alarm popups while working.

# ESP: Para usar este script necesitamos tener instalados los comandos 'at' y 'zenity'. Si no están instalados, el script no funcionará.
# ING: To use this script, we need the 'at' and 'zenity' commands installed. If they are not installed, the script will not work.

# ESP: DECLARACIÓN DE VARIABLES
# ING: VARIABLE DECLARATION
text=$1
hora=$2

# ESP: Comprobamos que las variables $text y $hora no estén vacías
# ING: Check that the variables $text and $hora are not empty
if [ -z "$text" ] || [ -z "$hora" ]; then
    # ESP: Mensaje de uso si no se ingresaron valores correctos
    # ING: Usage message if no valid values were provided
    echo "ESP:"
    echo "USO: $0 <mensaje> <hora>"
    echo "  <mensaje>: Una palabra o texto entre comillas."
    echo "  <hora>: La hora a la que queremos que suene (formato HH:MM)."
    echo ""
    echo "ING:"
    echo "USAGE: $0 <message> <time>"
    echo " <message>: A single word or text enclosed in quotes."
    echo " <time>: The time you want the alarm to trigger (format HH:MM)."
    exit 1

fi

# ESP: Verificar si 'at' está instalado
# ING: Verify if 'at' is installed
if ! command -v at >/dev/null; then
    echo "Error: El comando 'at' no está instalado. Instálalo con: sudo apt install at"
    echo "Error: The 'at' command is not installed. Install it using: sudo apt install at"
    exit 1
fi

# ESP: Verificar si 'zenity' está instalado
# ING: Verify if 'zenity' is installed
if ! command -v zenity >/dev/null; then
    echo "Error: El comando 'zenity' no está instalado. Instálalo con: sudo apt install zenity"
    echo "Error: The 'zenity' command is not installed. Install it using: sudo apt install zenity"
    exit 1
fi

# ESP: Creamos el popup con la alerta que saltará a la hora indicada
# ING: Create the popup with the alert that will trigger at the specified time
echo "DISPLAY=:0 zenity --info --title='Alarma' --text='$text'" | at $hora

# ESP: Verificamos si el comando 'at' falló
# ING: Verify if the 'at' command failed
if [ $? -ne 0 ]; then
    echo "Error: No se pudo programar la alarma. Verifica la hora ingresada."
    echo "Error: The alarm could not be scheduled. Check the entered time."
    exit 1
else
    echo "✅ ESP: Alarma programada correctamente para las $hora con el mensaje: '$text'"
    echo "✅ ING: Alarm successfully scheduled for $hora with the message: '$text'"
fi
