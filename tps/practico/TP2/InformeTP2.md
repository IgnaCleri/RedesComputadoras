# Trabajo Práctico N°2 — Informe

**Integrantes del Grupo:**

| Name                            | DNI      | Mail UNC                          | Github                                                            |
| ------------------------------- | -------- | --------------------------------- | ----------------------------------------------------------------- |
| Viberti, Benjamin               | 46224179 | b.viberti@mi.unc.edu.ar           | [@benjaviberti](https://github.com/benjaviberti)                   |
| Espinoza Sutta, Aaron Alejandro | 96009173 | aaron.espinoza_4500@mi.unc.edu.ar | [@Aaron45000](https://github.com/Aaron45000)                       |
| Cleri, Juan Ignacio             | 46452662 | ignacio.cleri@mi.unc.edu.ar       | [@IgnaCleri](https://github.com/IgnaCleri)                         |
| Pineda, Juan Ignacio            | 45591343 | juan.ignacio.pineda@mi.unc.edu.ar | [@juanignaciopineda-dot](https://github.com/juanignaciopineda-dot) |
| Grafión, Atilio Leonel         | 43940195 | atilio.grafion@mi.unc.edu.ar      | [@Aollgn](https://github.com/Aollgn)                               |
| Badenes, Tomas                  | 44785038 | tomasbadenes@mi.unc.edu.ar        | NA                                                                |
| Oviedo, Ignacio Nicolas         | 43940195 | ignacio.oviedo.239@mi.unc.edu.ar  | NA                                                                |
| Mendez, Jorge Nicolas         | 41301342 | jorge.mendez@mi.unc.edu.ar  | NA                                                                |

## Consigna 1
### a) 

El fenómeno físico representado es el Efecto Doppler, ocasionado por el movimiento relativo entre la fuente emisora (barco) y el receptor (satélite).

Sus caracteristicas principales son:

* Compresión de la onda: Al reducirse la distancia entre el emisor y el receptor, cada nueva cresta de la onda se emite desde una posición más cercana que la anterior. Esto disminuye la longitud de onda ($\lambda$) y aumenta la frecuencia percibida ($f$) en el receptor.
* Dependencia de la velocidad y frecuencia: La desviación de frecuencia ($\Delta f$) es directamente proporcional a la velocidad relativa ($v$) entre los cuerpos y a la frecuencia central de la señal ($f_0$):
$$\Delta f = \frac{v}{c} f_0$$
* Comportamiento dinámico: Mientras el satélite se aproxima, la frecuencia recibida es mayor que la emitida ($f' > f$). Una vez que sobrepasa la vertical de la estación y comienza a alejarse, la frecuencia disminuye por debajo del valor nominal ($f' < f$).

### b) 

 Las bandas más afectadas son las de alta y muy alta frecuencia (SHF y EHF), que se usan en enlaces satelitales y enlaces de microondas.
 
 Las bandas más resilientes son las de de baja frecuencia (HF, MF, LF), donde al ser la portadora de menor frecuencia, el corrimiento en Hz provocado por el Doppler es insignificante.

### c) 

No se debe encender el celular arriba de un avion para evitar molestias a los pilotos y no saturar las antenas en tierra.

* Interferencia en la cabina:
Al estar en el aire y no haber señal el celular trabaja al maximo en busqueda de una antena. Esa transmisión a máxima potencia puede generar ruidos en los auriculares de los pilotos e interferir con los equipos de medición en el avion.

2. Saturación en redes de tierra:
Desde el aire, como no hay obstaculos que tapen la señal, el celular localiza cientos de antenas en tierra al mismo tiempo. Al intentar conectarse a todas las que encuentra satura la red celular de esa localidad mientras pasa.

Sí esta relacionado con el efecto Doppler. Las antenas terrestres están preparadas para recibir señales de celulares que se mueven a velocidad de caminata, auto, etc (hasta 200km/h). Como el avión viaja a casi 900 km/h, la velocidad deforma la onda de radio del celular mucho más rápido de lo que las antenas pueden procesar. Esto hace que las antenas en tierra se desorienten y la conexión se corte de inmediato.

## Consigna 2

## Consigna 3

## Consigna 4

## Consigna 5

La resolución completa (programa en Go, formato de las tramas, anomalías encontradas y mensaje reconstruido) está documentada en:

[Extracción de Payloads — Ejercicio 5](extraccion-de-payloads/Ejercicio_5.md)
