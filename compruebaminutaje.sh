#!/bin/bash

function muestraayuda() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t compruebaminutaje - Comprueba que el parámetro que recibe está en el formato de minutaje de ffmpeg."
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t compruebaminutaje 0:24:37"
  echo -e "\t compruebaminutaje 2437"
  echo ""
  echo -e "\e[1mDESCRIPCIÓN\e[0m"
  echo -e "\t \e[1mcompruebaminutaje\e[0m Comprueba que el parámetro que recibe está en el formato de minutaje de ffmpeg:"
  echo -e "\t \e[1mHH:MM:SS\e[0m."
  echo -e "\t Si le falta algún carácter, lo añade."
  echo -e "\t Si los minutos o segundos superan los 60, los pone a 0"
  echo -e "\t Si sólo recibe números, lo pasa a formato HH:MM:SS."
  echo -e "\t Si recibe caracteres distintos a números o dos puntos (:), devuelve 00:00:00."
  echo -e "\t Si no recibe nada, también devuelve 00:00:00."
}

function compruebaminutaje(){
  # comprueba que el parámetro que recibe está en el formato de minutaje de ffmpeg:
  # HH:MM:SS
  # Si le falta algún carácter, lo añade
  # Si los minutos o segundos superan los 60, los pone a 0
  # Si sólo recibe números, lo pasa a formato HH:MM:SS
  # Si recibe caracteres distintos a números o dos puntos (:), devuelve 00:00:00
  # Si no recibe nada, también devuelve 00:00:00

  caracteresminutaje='^-?[0-9]+([:][0-9]+)?$'
  caracteresnumericos='^[0-9]+$'
  dospuntos="${1//[^:]}"
  if [ ${#dospuntos} -gt 0 ] && [ ${#dospuntos} -lt 3 ]
  then

    arrayminutaje=(${1//:/ })
    if [[ ${#arrayminutaje[@]} -eq 2 ]]
    then
      horas="00"
      if [[ ${arrayminutaje[0]} =~ $caracteresnumericos ]] && [ ${arrayminutaje[0]} -lt 60 ]
      then
        minutos=${arrayminutaje[0]}
      elif [[ ${arrayminutaje[0]} =~ $caracteresnumericos ]] && [ ${arrayminutaje[0]} -lt 10 ] && [ ${#arrayminutaje[0]} -lt 2 ]
      then
        minutos="0"${arrayminutaje[0]}
      else
        minutos="00"
      fi
      if [[ ${arrayminutaje[1]} =~ $caracteresnumericos ]] && [ ${arrayminutaje[1]} -lt 60 ]
      then
        segundos=${arrayminutaje[1]}
      elif [[ ${arrayminutaje[1]} =~ $caracteresnumericos ]] && [ ${arrayminutaje[1]} -lt 10 ] && [ ${#arrayminutaje[0]} -lt 2 ]
      then
        segundos="0"${arrayminutaje[1]}
      else
        segundos="00"
      fi
    else
    if [[ ${arrayminutaje[0]} =~ $caracteresnumericos ]] && [ ${arrayminutaje[0]} -lt 24 ] && [ ${arrayminutaje[0]} -gt 10 ]
    then
      horas=${arrayminutaje[0]}
    elif [[ ${arrayminutaje[0]} =~ $caracteresnumericos ]] && [ ${arrayminutaje[0]} -lt 10 ] && [ ${#arrayminutaje[0]} -lt 2 ]
    then
      horas="0"${arrayminutaje[0]}
    else
      horas="00"
    fi
    if [[ ${arrayminutaje[1]} =~ $caracteresnumericos ]] && [ ${arrayminutaje[1]} -lt 60 ] && [ ${arrayminutaje[1]} -gt 10 ]
    then
      minutos=${arrayminutaje[1]}
    elif [[ ${arrayminutaje[1]} =~ $caracteresnumericos ]] && [ ${arrayminutaje[1]} -lt 10 ]
    then
      minutos="0"${arrayminutaje[1]}
    else
      minutos="00"
    fi
    if [[ ${arrayminutaje[2]} =~ $caracteresnumericos ]] && [ ${arrayminutaje[2]} -lt 60 ] && [ ${arrayminutaje[2]} -gt 10 ]
    then
      segundos=${arrayminutaje[2]}
    elif [[ ${arrayminutaje[2]} =~ $caracteresnumericos ]] && [ ${arrayminutaje[2]} -lt 10 ]
    then
      segundos="0"${arrayminutaje[2]}
    else
      segundos="00"
    fi
  fi
  minutaje=$horas":"$minutos":"$segundos
  elif [ ! $1 ] || ! [[ $1 =~ $caracteresminutaje ]]
  then
    minutaje="00:00:00"
  elif [[ $1 =~ $caracteresnumericos ]]
  then
    longitud=${#1}
    if [ $longitud -le 6 ]
    then
      let numerodeceros=6-$longitud
      ceros=""
      for i in `seq 1 $numerodeceros`
      do
        ceros="0"$ceros
      done
      minutajeenbruto=$ceros$1
      segundos=${minutajeenbruto: -2}
      minutos=${minutajeenbruto:2:2}
      horas=${minutajeenbruto:0:2}
      if [ $horas -gt 23 ]
      then
        horas="00"
      fi
      if [ $minutos -gt 59 ]
      then
        minutos="00"
      fi
      if [ $segundos -gt 59 ]
      then
        segundos="00"
      fi

      minutaje=$horas":"$minutos":"$segundos
    fi
  else
    # Si llegamos aquí es que la cadena tiene números y dos puntos

    arrayminutaje=(${1//:/ })
    segundos=${minutajeenbruto[2]}
    minutos=${minutajeenbruto[1]}
    horas=${minutajeenbruto[0]}
    if [ $horas -gt 23 ]
    then
      horas="00"
    fi
    if [ $minutos -gt 59 ]
    then
      minutos="00"
    fi
    if [ $segundos -gt 59 ]
    then
      segundos="00"
    fi
    if [ $horas -lt 10 ] && [ ${#horas} -lt 2 ]
    then
      horas="0"$horas
    fi
    if [ $minutos -lt 10 ] && [ ${#minutos} -lt 2 ]
    then
      minutos="0"$minutos
    fi
    if [ $segundos -lt 10 ] && [ ${#segundos} -lt 2 ]
    then
      segundos="0"$segundos
    fi
    minutaje=$horas":"$minutos":"$segundos
  fi
  echo $minutaje

}

if [ ! $1 ]
then
  echo "00:00:00"
else
  if [ "$1" == "-h" ] || [ "$1" == "ayuda" ]
  then
    muestraayuda
  else
    compruebaminutaje $1
  fi
fi
