#!/bin/bash

function muestraayuda() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t diferenciaenminutaje - Calcula la diferencia entre el primer parámetro y el segundo en el formato de minutaje de HH:MM:SS."
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t diferenciaenminutaje 0:24:37 1:35:54"
  echo ""
  echo -e "\e[1mDESCRIPCIÓN\e[0m"
  echo -e "\t \e[1mdiferenciaenminutaje\e[0m Calcula el tiempo que hay entre dos minutajes y lo devuelve en el formato de minutaje de ffmpeg/avconv:"
  echo -e "\t \e[1mHH:MM:SS\e[0m."
}

function diferenciaenminutaje(){
  # comprueba que el parámetro que recibe está en el formato de minutaje de ffmpeg (HH:MM:SS)
  caracteresnumericos='^[0-9]+$'
  caracteresminutaje='^-?[0-9]+([:][0-9]+)+([:][0-9]+)?$'
  let acarreo=0

  if [[ $1 =~ $caracteresminutaje ]] || [[ $1 =~ $caracteresnumericos ]]
  then
    primero=1
  else
    primero=0
  fi
  if [[ $2 =~ $caracteresminutaje ]] || [[ $2 =~ $caracteresnumericos ]]
  then
    segundo=1
  else
    segundo=0
  fi

  if [ $primero -ne 1 ] || [ $segundo -ne 1 ]
  then
    exit -1
  fi


  dospuntosprimerparametro="${1//[^:]}"
  dospuntossegundoparametro="${2//[^:]}"
  # homogeneiza el primer parámetro
  if [ -z $dospuntosprimerparametro ]
  then
    if [ $1 -gt 59 ]
    then
      exit -1
    elif [ $1 -lt 10 ]
    then
      parametro1="00:00:0"$1
    else
      parametro1="00:00:"$1
    fi
  elif [ ${#dospuntosprimerparametro} -eq 1 ]
  then
    arrayminutaje1=(${1//:/ })
    if [ ${arrayminutaje1[0]} -gt 59 ] || [ ${arrayminutaje1[1]} -gt 59 ]
    then
      exit -1
    fi
    if [ ${#arrayminutaje1[0]} -lt 2 ]
    then
      minutos="0"${arrayminutaje1[0]}
    else
      minutos=${arrayminutaje1[0]}
    fi
    if [ ${#arrayminutaje1[1]} -lt 2 ]
    then
      segundos="0"${arrayminutaje1[1]}
    else
      segundos=${arrayminutaje1[1]}
    fi
    parametro1="00:"$minutos":"$segundos
  elif [ ${#dospuntosprimerparametro} -eq 2 ]
  then
    arrayminutaje1=(${1//:/ })
    if [ ${arrayminutaje1[0]} -gt 23 ] || [ ${arrayminutaje1[1]} -gt 59 ] || [ ${arrayminutaje1[2]} -gt 59 ]
    then
      exit -1
    fi
    if [ ${#arrayminutaje1[0]} -lt 2 ]
    then
      horas="0"${arrayminutaje1[0]}
    else
      horas=${arrayminutaje1[0]}
    fi
    if [ ${#arrayminutaje1[1]} -lt 2 ]
    then
      minutos="0"${arrayminutaje1[1]}
    else
      minutos=${arrayminutaje1[1]}
    fi
    if [ ${#arrayminutaje1[2]} -lt 2 ]
    then
      segundos="0"${arrayminutaje1[2]}
    else
      segundos=${arrayminutaje1[2]}
    fi

    parametro1=$horas":"$minutos":"$segundos
  fi

# homogeneiza el segundo parámetro
  if [ -z $dospuntossegundoparametro ]
  then
    if [ $2 -gt 59 ]
    then
      exit -1
    elif [ $2 -lt 10 ]
    then
      parametro2="00:00:0"$2
    else
      parametro2="00:00:"$2
    fi
  elif [ ${#dospuntossegundoparametro} -eq 1 ]
  then
    arrayminutaje2=(${2//:/ })
    if [ ${arrayminutaje2[0]} -gt 59 ] || [ ${arrayminutaje2[1]} -gt 59 ]
    then
      exit -1
    fi
    if [ ${#arrayminutaje2[0]} -lt 2 ]
    then
      minutos="0"${arrayminutaje2[0]}
    else
      minutos=${arrayminutaje2[0]}
    fi
    if [ ${#arrayminutaje2[1]} -lt 2 ]
    then
      segundos="0"${arrayminutaje2[1]}
    else
      segundos=${arrayminutaje2[1]}
    fi
    parametro2="00:"$minutos":"$segundos
  elif [ ${#dospuntossegundoparametro} -eq 2 ]
  then
    arrayminutaje2=(${2//:/ })
    if [ ${arrayminutaje2[0]} -gt 23 ] || [ ${arrayminutaje2[1]} -gt 59 ] || [ ${arrayminutaje2[2]} -gt 59 ]
    then
      exit -1
    fi
    if [ ${#arrayminutaje2[0]} -lt 2 ]
    then
      horas="0"${arrayminutaje2[0]}
    else
      horas=${arrayminutaje2[0]}
    fi
    if [ ${#arrayminutaje2[1]} -lt 2 ]
    then
      minutos="0"${arrayminutaje2[1]}
    else
      minutos=${arrayminutaje2[1]}
    fi
    if [ ${#arrayminutaje2[2]} -lt 2 ]
    then
      segundos="0"${arrayminutaje2[2]}
    else
      segundos=${arrayminutaje2[2]}
    fi

    parametro2=$horas":"$minutos":"$segundos
  fi

#
# Ahora, opera con los minutajes

arrayminutaje1=(${parametro1//:/ })
arrayminutaje2=(${parametro2//:/ })

  if [ ${arrayminutaje1[2]} -eq ${arrayminutaje2[2]} ]
  then
    segundos="00"
  elif [ ${arrayminutaje1[2]} -lt ${arrayminutaje2[2]} ]
  then
    let segundos=${arrayminutaje2[2]}-${arrayminutaje1[2]}
    if [[ ${#segundos} -lt 2 ]]
    then
      segundos="0"$segundos
    fi
  else
    let segundos=${arrayminutaje1[2]}-${arrayminutaje2[2]}
    let segundos=60-$segundos
    let acarreo=1
  fi

  if [[ $acarreo -eq 1 ]]
  then
    let arrayminutaje1[1]=${arrayminutaje1[1]}+1
  fi
  if [ ${arrayminutaje1[1]} -eq ${arrayminutaje2[1]} ]
  then
    minutos="00"
  elif [ ${arrayminutaje1[1]} -lt ${arrayminutaje2[1]} ]
  then
    let minutos=${arrayminutaje2[1]}-${arrayminutaje1[1]}
    if [[ ${#minutos} -lt 2 ]]
    then
      minutos="0"$minutos
    fi
  else
    let minutos=${arrayminutaje1[1]}-${arrayminutaje2[1]}
    let minutos=60-$minutos
    let acarreo=2
  fi


  if [[ $acarreo -eq 2 ]]
  then
    let arrayminutaje2[0]=${arrayminutaje2[0]}+1
  fi
  if [ ${arrayminutaje1[0]} -eq ${arrayminutaje2[0]} ]
  then
    horas="00"
  elif [ ${arrayminutaje1[0]} -gt ${arrayminutaje2[0]} ]
  then
    echo "Error. El primer minutaje es mayor que el segundo."
    exit -1
  else
    let horas=${arrayminutaje2[0]}-${arrayminutaje1[0]}
  fi

  echo $horas":"$minutos":"$segundos

}

if [ ! $1 ] || [ ! $2 ]
then
  echo "Para calcular la diferencia entre dos minutajes, hacen falta dos minutajes."
  echo "Por favor, revisa la sintaxis:"
  echo ""
  echo "diferenciaenminutaje hh:mm:ss HH:MM:SS"
  echo ""
else
  if [ "$1" == "-h" ] || [ "$1" == "ayuda" ] || [ "$2" == "-h" ] || [ "$2" == "ayuda" ]
  then
    muestraayuda
  else
    diferenciaenminutaje $1 $2
  fi
fi
