# 4 Red simple en Packet Tracer

## Router

![homerouter](imagenes/image-3.png)

En nuestro caso, el router que utilizamos para la red fue el genérico Home Router con la siguiente configuración:

IP y máscara de subred:

![ip-y-mascara-subred](imagenes/image-1.png)

Seguridad WPA2-PSK:

![alt text](imagenes/image-4.png)

Este router está trabajando con una frecuencia de 2.4 GHz (este router también tiene la posibilidad de trabajar con frecuencia de 5 GHz, pero la desactivé para mantener la simplicidad).

![alt text](imagenes/image.png)

El router, independientemente de si es 2.4 GHz o 5 GHz, está trabajando en la banda de microondas del espectro electromagnético.

## PC de escritorio

![pc](imagenes/image-5.png)

La PC de escritorio ya está conectada a la red con la IP 192.168.0.101 vía Ethernet.

![ip-pc](imagenes/image-8.png)


## Laptop

![laptop](imagenes/image-6.png)

La laptop ya está conectada a la red con la IP 192.168.0.100 vía Wi-Fi.

![ip-laptop](imagenes/image-10.png)

Ahora comprobemos si tiene conexión con la PC que está conectada a la red vía Ethernet.

![ping-con-pc](imagenes/image-13.png)


## Comprobación de conexiones

Ahora comprobaremos la conexión entre la PC y la laptop en distintas posiciones:

### Caso 1: Ambas en la oficina

![ping-con-pc-ofi](imagenes/image-12.png)


En este caso, el ping salió de esta manera:

![ping-cmd-caso1](imagenes/image-11.png)

### Caso 2: En el borde interno del límite

![ping-con-pc-borde](imagenes/image-14.png)

En este caso, el ping salió de esta manera:

![ping-cmd-caso2](imagenes/image-13.png)

Un poco mayor al anterior.


### Caso 3: Fuera del límite

![ping-con-pc-fuera](imagenes/image-7.png)

En este caso, el comando ping con la PC de escritorio no devolvió nada, ya que al estar fuera del límite de operación del router la laptop se desconectó.

![ping-cmd-caso3](imagenes/image-15.png)