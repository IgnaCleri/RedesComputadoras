# 4 Red simple en Packet Tracer

## Router

![homerouter](imagenes/image-3.png)

En nuestro caso el router que utilizamos para la red fue el generico home router con la siguiente configuracion:

IP y mascara subred:

![ip-y-mascara-subred](imagenes/image-1.png)

Seguridad WPA2-PSK:

![alt text](imagenes/image-4.png)

Este Router esta trabajando con una frencuencia de 2.4Ghz (este router tambien tiene la posibilidad de trabajar con frecuencia 5Ghz pero las desactive para mantener la simplicidad)

![alt text](imagenes/image.png)

El router independientemente si es 2.4ghz o 5ghz esta trabajando en la anda de microondas del espectro electromagnetico

## PC de escritorio

![pc](imagenes/image-5.png)

La pc de escritorio ya esta conectada a la red con la ip 192.168.0.101 via ethernet

![ip-pc](imagenes/image-8.png)


## Laptop

![laptop](imagenes/image-6.png)

La laptop ya esta conectada a la red con la ip 192.168.0.100 via wifi, 

![ip-laptop](imagenes/image-10.png)

Ahora comprobemos si tiene conexion con la pc que esta conectada a la red via ethernet

![ping-con-pc](imagenes/image-13.png)


## Comprobacion de conexiones

Ahora comprobaremos la conexion entre la pc y la laptop en distintas posiciones:

### Caso 1: Ambas en la oficina

![ping-con-pc-ofi](imagenes/image-12.png)


En este caso el ping salio de esta manera:

![ping-cmd-caso1](imagenes/image-11.png)

### Caso 2: en el borde interno del limite

![ping-con-pc-borde](imagenes/image-14.png)

En este caso el ping salio de esta manera:

![ping-cmd-caso2](imagenes/image-13.png)

Un poco mayor al anterior.


### Caso 3: fuera del limite

![ping-con-pc-fuera](imagenes/image-7.png)

En este caso el comando ping con la pc de escritorio no devolvio nada, ya que al estar fuera del limite de operacion del router la laptop se desconectó.

![ping-cmd-caso3](imagenes/image-15.png)