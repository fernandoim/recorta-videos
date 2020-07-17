# recorta-videos
Conjunto de funciones para recortar automáticamente vídeos. 
- recorta
- extrae
- dispersa
- rafaga
- trocea

Y funciones auxiliares para trabajar con el minutaje:

- compruebaminutaje
- minutajeasegundos
- segundosaminutaje
- ordenaminutajes

## Requisitos

Para ejecutar estas funciones es necesario que tenga instalado ffmpeg. 

Puede probar si lo tiene instalado con:

`ffmpeg -version`

En caso de que no lo tenga instalado, puede instalar ffmpeg con:

`sudo apt-get install ffmpeg`

## Generalidades

La sintaxis general de estas funciones es:

`función $video_origen $minutaje_comienzo [$minutaje_final] [r|renombra] [cadenas_de_texto_que_se_anexarán_al_final_del_nombre_del_vídeo]`

recorta sólo recibe el minutaje de comiezo, ya que el tiempo que va a extraer se calcula en cada ejecución de forma aleatoria. 
trocea puede recibir muchos minutajes ya que lo que hace es trocear el vídeo en tantos extractos como se le indica. 
El resto de funciones (extrae, dispersa y rafaga) necesitan un punto de inicio y un punto de final para hacer los recortes. 

Tras el minutaje se le pueden pasar cadenas de texto que anexará la función al final del título del vídeo. Justo antes de la extensión. Los espacios en blanco los convertirá en guiones bajos (_). 

Se le puede indicar como primer parámetro tras el minutaje bien `r` o bien `renombra` y borra el título del vídeo sustituyéndolo por las cadenas que se indican a continuación. 

Para evitar que haya varios vídeos con el nombre repetido, los vídeos se numeran añadiéndose la numeración al final del nombre, por lo que, si no se le indica que renombre, el nombre del fichero quedaría así:

`titulo_original_cadena1_cadena2_cadena3_1.mp4`  
`titulo_original_cadena1_cadena2_cadena3_2.mp4`  
`titulo_original_cadena1_cadena2_cadena3_3.mp4`  
`titulo_original_cadena1_cadena2_cadena3_4.mp4`

## Funciones

#### recorta
Extrae un único corte de vídeo de una cantidad aleatoria de segundos (por defecto, entre 3 y 10 segundos) desde el minutaje indicado como comienzo. 
