#!/bin/bash

# Ruta donde buscar los directorios que comienzan con .wine
directorio_base="$HOME"

# Buscar directorios que comienzan con .wine y procesarlos uno a uno
find "$directorio_base" -maxdepth 1 -type d -name '.wine*' | while read dir; do
  # Extraer solo el nombre del directorio
  dir_name=$(basename "$dir")
  
  echo "Procesando directorio: $dir_name"
  if [[ "$dir_name" == ".wine" || "$dir_name" == ".wineSoundtoys" ]]; then
    echo "Omitiendo el directorio $dir"
    continue
  fi

  
  # Comprobar si el directorio fue encontrado
  if [ -d "$dir" ]; then
    # Añadir el subdirectorio "/drive_c/Program Files/Common Files/VST3"
    subdir_vst3="$dir/drive_c/Program Files/Common Files/VST3"
    echo "Añadiendo el subdirectorio $subdir_vst3 a yabridgectl"
    yabridgectl add "$subdir_vst3"

    # Añadir el subdirectorio "/drive_c/Program Files/Steinberg/VSTPlugins"
    subdir_vst_plugins="$dir/drive_c/Program Files/Steinberg/VSTPlugins"
    echo "Añadiendo el subdirectorio $subdir_vst_plugins a yabridgectl"
    yabridgectl add "$subdir_vst_plugins"
  fi
done

echo "Todos los directorios han sido añadidos."

