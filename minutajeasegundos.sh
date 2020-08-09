#!/bin/bash

function muestraayuda() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t minutajeasegundos - Calcula el número de segundos de un minutaje en formato HH:MM:SS."
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t minutajeasegundos 0:24:37"
  echo ""
  echo -e "\e[1mDESCRIPCIÓN\e[0m"
  echo -e "\t \e[1mminutajeasegundos\e[0m Calcula el número de segundos de un minutaje en formato HH:MM:SS y delvuelve el número de segundos."
  echo ""
  echo -e "\t Es la función complementaria a \e[1msegundosaminutaje\e[0m, que calcula el número de segundos en formato HH:MM:SS. "
  echo -e "\t Juntas permiten convertir un minutaje a segundos, opererar en segundos y volver a trabajar en formato minutaje."
  echo -e "\e[1mMIRE TAMBIÉN\e[0m"
  echo -e "\t \e[1msegundosaminutaje\e[0m"
  echo ""
}



function minutajeasegundos(){
  tiempohoras=$(echo ${1:0:2})
  tiempominutos=$(echo ${1:3:2})
  tiemposegundos=$(echo ${1:6:2})

  let segundoshoras=$tiempohoras*3600
  let segundosminutos=$tiempominutos*60
  let numerosegundos="$segundoshoras"+"$segundosminutos"+"$tiemposegundos"

  echo $numerosegundos
}

if [ ! $1 ]
then
  echo "Para poder calcular el número de segundos, es necesario que indique un minutaje en formato HH:MM:SS."
  exit -1
else
  if [ "$1" == "-h" ] || [ "$1" == "ayuda" ]
  then
    muestraayuda
  else

    . compruebaminutaje.sh
    minutaje=$(compruebaminutaje $1)
    minutajeasegundos $minutaje
  fi
fi
