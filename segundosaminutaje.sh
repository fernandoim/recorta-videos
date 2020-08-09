#!/bin/bash

function muestraayudasegundosaminutaje() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t segundosaminutaje - Convierte un número de segundos indicado como parámetro en formato HH:MM:SS."
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t segundosaminutaje 1714"
  echo ""
  echo -e "\e[1mDESCRIPCIÓN\e[0m"
  echo -e "\t \e[1msegundosaminutaje\e[0m Calcula el número de segundos indicado y lo convierte en formato HH:MM:SS."
  echo ""
  echo -e "\t Es la función complementaria a \e[1mminutajeasegundos\e[0m, que convierte en número de segundos un formato HH:MM:SS. "
  echo -e "\t Juntas permiten convertir un minutaje a segundos, opererar en segundos y volver a trabajar en formato minutaje."
  echo ""
  echo -e "\e[1mMIRE TAMBIÉN\e[0m"
  echo -e "\t \e[1mminutajeasegundos\e[0m"
  echo ""
}



function segundosaminutaje(){
  if [[ $1 -gt 3600 ]]
  then
    let horas=$1/3600
  fi
  if [[ $horas -lt 10 ]]
  then
    horas="0"$horas
  fi
  let descontarhoras=3600*$horas
  let sinhoras=$1-$descontarhoras
  let minutos=$sinhoras/60
  let descontarminutos=$minutos*60
  let segundos="$1"-"$descontarhoras"-"$descontarminutos"


  echo $horas":"$minutos":"$segundos

}

if [ ! $1 ]
then
  echo "Para poder calcular el minutaje, es necesario que indique un número de segundos."
  exit -1
else
  if [ "$1" == "-h" ] || [ "$1" == "ayuda" ]
  then
    muestraayudasegundosaminutaje
    exit 0
  else
    # Comprueba que el parámetro es numérico y que es menor al número de segundos de un día
    caracteresnumericos='^[0-9]+$'
    if [[ $1 =~ $caracteresnumericos ]] && [[ $1 -lt 86400 ]]
    then
      segundosaminutaje $1
    else
      echo "Formato no válido. Compruebe que ha indicado en números los segundos que quiere transformar en minutaje y que no superan los segundos de un día. "
      exit -1
    fi
  fi
fi
