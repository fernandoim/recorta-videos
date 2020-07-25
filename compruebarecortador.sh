#!/bin/bash

function muestraayuda() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t compruebarecortador - Comprueba el programa con que se van a realizar los recortes en los vídeos:"
  echo -e "\t ffmpeg"
  echo -e "\t avconv"
  echo -e "\t mencoder"
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t compruebarecortador"
  echo ""
  echo -e "\e[1mDESCRIPCIÓN\e[0m"
  echo -e "\t \e[1mcompruebarecortador\e[0m Comprueba el programa de edición de vídeo en línea de comandos que tiene instalado el sistema."
  echo ""
  echo -e "\t En caso de que esté instalado \e[1mffmpeg\e[0m, devuelve ffmpeg."
  echo -e "\t Si ffmpeg no estuviera instalado, comprueba si lo está \e[1mavconv\e[0m. Y devolvería avconv."
  echo -e "\t Si no estuviera instalado ni ffmpeg ni avconv, comprobaría si está \e[1mmencoder\e[0m. En caso de que estuviera, devolvería mencoder."
  echo ""
  echo -e "\t En caso de que no estuviera instalado ni ffmpeg, ni avconv, ni mencoder, devuelve -1."
}

function compruebarecortador(){
  tieneffmpeg=$(which ffmpeg)
  if [ $tieneffmpeg ]
  then
    recortador="ffmpeg"
  else
    tieneavconv=$(which avconv)
    if [ $tieneavconv ]
    then
      recortador="avconv"
    else
      tienemencoder=$(which mencoder)
      if [ $tienemencoder ]
      then
        recortador="mencoder"
      fi
    fi
  fi

  if [ $recortador ]
  then
    echo $recortador
  else
    exit -1
  fi


}

if [ "$1" == "-h" ] || [ "$1" == "ayuda" ]
then
  muestraayuda
else
  compruebarecortador
fi
