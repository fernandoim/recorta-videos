
#!/bin/bash

function muestraayuda() {
  echo -e "\e[1mNOMBRE\e[0m"
  echo -e "\t numeracionsiguientefichero - Comprueba cuántos ficheros hay en un determinado directorio con un determinado patrón de nombre y devuelve la numeración a usar en el siguiente fichero con el mismo patrón."
  echo ""
  echo -e "\e[1mSINOPSIS\e[0m"
  echo -e "\t numeracionsiguientefichero /ruta/al/directorio nombre_con_patron"
  echo ""
  echo -e "\e[1mDESCRIPCIÓN\e[0m"
  echo -e "\t \e[numeracionsiguientefichero\e[0m Comprueba el número de ficheros que tienen un mismo patrón (por ejemplo: fotografia_recortada) en un directorio (por ejemplo: ~/fotografias) y devuelve ese número más 1."
  echo -e "\t Así, si estamos procesando en lote imágenes o recortando vídeos con un determinado patrón, se obtiene el numeral del fichero que se va a guardar en ese momento."
}

function numeracionsiguientefichero(){
if [ ! $2 ] || [ ! -d "$1" ]
then
  exit -1
else
  busqueda=$1"/"$2"*"
fi

numeroficheros=$(ls $busqueda | wc -l)
if [[ $numeroficheros = "0" ]]
then
  let numeroficheros=0
fi
let numeral=$numeroficheros+1

echo $numeral

}



if [ ! $1 ] || [ ! $2 ]
then
  echo "Para saber el número de ficheros que tienen un patrón en un directorio hace falta saber el directorio y el patrón."
  echo "Por favor, revisa la sintaxis:"
  echo ""
  echo "numeracionsiguientefichero directorio patrón"
  echo ""
else
  if [ "$1" == "-h" ] || [ "$1" == "ayuda" ] || [ "$2" == "-h" ] || [ "$2" == "ayuda" ]
  then
    muestraayuda
  else
    numeracionsiguientefichero $1 $2
  fi
fi
