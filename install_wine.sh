#!/bin/bash

# Solicitar al usuario la versión de Wine
read -p "Introduce la versión de Wine que deseas instalar (por ejemplo, 9.21): " version

# Comprobar que el usuario ha introducido una versión
if [ -z "$version" ]; then
    echo "¡Error! No se introdujo una versión."
    exit 1
fi

# Agregar la arquitectura i386
sudo dpkg --add-architecture i386

# Crear directorio para las claves
sudo mkdir -pm755 /etc/apt/keyrings

# Descargar la clave de Wine
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

# Descargar los archivos de configuración de Wine
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources

# Actualizar repositorios
sudo apt update

# Definir el variante
variant=staging

# Obtener el nombre de la codename
codename=$(shopt -s nullglob; awk '/^deb https:\/\/dl\.winehq\.org/ { print $3; exit 0 } END { exit 1 }' /etc/apt/sources.list /etc/apt/sources.list.d/*.list || awk '/^Suites:/ { print $2; exit }' /etc/apt/sources.list /etc/apt/sources.list.d/wine*.sources)

# Definir el sufijo
suffix=$(dpkg --compare-versions "$version" ge 6.1 && ((dpkg --compare-versions "$version" eq 6.17 && echo "-2") || echo "-1"))

# Instalar Wine con los parámetros definidos
sudo apt install --install-recommends {"winehq-$variant","wine-$variant","wine-$variant-amd64","wine-$variant-i386"}="$version~$codename$suffix"
