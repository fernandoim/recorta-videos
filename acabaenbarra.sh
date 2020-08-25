#!/bin/bash


function acabaenbarra() {
  # Homogeneiza las rutas de directorios añadiendo la barra final en aquellas rutas que no acaben en barra. 

  posicionultimocaracter=$((${#1} - 1))
  ultimocaracter=${1:$posicionultimocaracter:1}
  if [[ $ultimocaracter == "/" ]]
  then
    directorio=$1
  else
    directorio=$1"/"
  fi

  echo $directorio
}


acabaenbarra $1
