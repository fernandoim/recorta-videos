#!/bin/bash

function muestraayuda() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t compruebafinalizador - Comprueba si la versión instalada de ffmpeg acepta to o t para indicar el final del corte."
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t compruebafinalizador video.mp4"
  echo ""
  echo -e "\e[1mDESCRIPCIÓN\e[0m"
  echo -e "\t \e[1mcompruebafinalizador\e[0m Comprueba si a la versión instalada de ffmpeg hay que indicarle -to o -t para indicar el final del corte."
  echo ""
  echo -e "\t En caso de que haya que indicarle -to, el valor será el minutaje del final del corte."
  echo -e "\t Si se le pasa el parámetro -t a ffmpeg, el valor será el tiempo que durará el corte."
  echo -e "\t Así pues, para recortar del minuto 10 al 12:"
  echo ""
  echo -e "\t ffmpeg -i entrada.mp4 -ss 00:10:00 \e[1m-t 00:02:00\e[0m salida.mp4"
  echo -e "\t ffmpeg -i entrada.mp4 -ss 00:10:00 \e[1m-to 00:12:00\e[0m salida.mp4"
  echo ""
  echo -e "\e[1mPRECAUCIÓN\e[0m"
  echo -e "\t El uso de la función \e[1mcompruebafinalizador\e[0m requiere un tiempo de procesamiento, por lo que podría ralentizar la ejecución de los scripts que usen esta función."
  echo -e "\t Además, si no se cambia de versión de ffmpeg, siempre será el mismo finalizador. Así que, con comprobar una única vez el finalizador de los cortes de ffmpeg, vale hasta que se actualice ffmpeg."
  echo -e "\t No hace falta ejecutar esta opción continuamente, puede guardar el resultado en un fichero de configuración y usar la información desde ahí."
}

function compruebafinalizador(){
  if [ ! $1 ]
  then
    echo "Es necesario que pase como parámetro un vídeo para hacer la comprobación."
    exit -1
  else
    aceptato=$(ffmpeg -i $1 -ss 00:00:00 -to 00:00:01 compruebato.mp4 2>&1 | grep "'to'")
    if [[ $aceptato =~ "Unrecognized option" ]]
    then
      finalizador="-t"
    elif [ -f compruebato.mp4 ]
    then
      finalizador="-to"
      rm compruebato.mp4
    else
      exit -1
    fi
  fi
  echo $finalizador
}

if [ "$1" == "-h" ] || [ "$1" == "ayuda" ]
then
  muestraayuda
else
  compruebafinalizador $1
fi
