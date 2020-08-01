
#!/bin/bash

function muestraayuda() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t ficheroaguardar - Devuelve la ruta completa del fichero a guardar numerando consecutivamente los ficheros según su patrón."
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t ficheroaguardar /ruta/al/directorio/a/guardar fichero_a_procesar"
  echo ""
  echo -e "\e[1mDESCRIPCIÓN\e[0m"
  echo -e "\t \e[1mficheroaguardar\e[0m Genera la ruta completa del fichero a guardar en un procesamiento de imágenes en lote o de recortes masivos de un mismo fichero de vídeo."
  echo -e "\t Toma el nombre del fichero original como base para generar un directorio donde almacenar los ficheros derivados."
  echo -e "\t Para evitar problemas a la hora del procesamiento automatizado, en caso de que no exista el directorio donde se quiere guardar ese fichero, lo crearía."
  echo -e "\t Se le puede indicar una extensión concreta con el parámeto -e y la extensión."
  echo -e "\t Si se le pasaran más parámetros a la función, anexaría esas cadenas al nombre del fichero."
  echo -e "\t En caso de que no se quiera usar el nombre del fichero original, se le puede indicar que renombre el fichero con el parámetro «r» o «renombra»."
}

function ficheroaguardar(){
  if [ ! -d $1 ] || [ ! -f $2 ]
  then
    exit -1
  else
    posicionultimocaracter=$((${#1} - 1))
    ultimocaracter=${1:$posicionultimocaracter:1}
    if [[ $ultimocaracter == "/" ]]
    then
      cadenautil=$((${#1} - 1))
      directorio=${1:0:${cadenautil}}
    else
      directorio=$1
    fi

    nombrefichero=$(basename $2)
    sinextension="${nombrefichero%.*}"
    directorioaguardar=$directorio"/"$sinextension
    if [ ! -d $directorioaguardar ]
    then
      mkdir $directorioaguardar
    fi
    shift
    shift
    if [[ "$1" == "-e" ]]
    then
      if [[ ${2:0:1} == "." ]]
      then
        extension=$2
      else
        extension="."$2
      fi
      shift
      shift
    else
      extension=${nombrefichero##*.}
    fi
    if [[ "$1" == "r" ]] || [[ "$1" == "renombra" ]]
    then
      sinextension=$2
      shift
      shift
    fi
    for parametro in "$@"
    do
      anexo=$anexo"_"$parametro
    done
    ficheroescena=$directorioaguardar"/"$sinextension$anexo"*"
    numeroficheros=$(ls $ficheroescena | wc -l)
    if [[ $numeroficheros = "0" ]]
    then
      let numeroficheros=0
    fi
    let numeral=$numeroficheros+1
    ficheroaguardar=$directorioaguardar"/"$sinextension$anexo"_"$numeral$extension
  fi
  echo $ficheroaguardar
}

if [ "$1" == "-h" ] || [ "$1" == "ayuda" ] || [ "$2" == "-h" ] || [ "$2" == "ayuda" ]
then
  muestraayuda
elif [ ! $1 ] || [ ! $2 ]
then
  echo "Para poder guardar ficheros en un directorio hace falta saber el directorio y el fichero."
  echo "Por favor, revisa la sintaxis:"
  echo ""
  echo "ficheroaguardar directorio fichero"
  echo ""
else
  ficheroaguardar $@
fi
