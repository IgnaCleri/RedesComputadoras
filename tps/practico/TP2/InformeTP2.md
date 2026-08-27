# Trabajo Práctico N°2 — Informe

**Grupo:** WireGuardians

**Integrantes del Grupo:**

| Name                            | DNI      | Mail UNC                          | Github                                                            |
| ------------------------------- | -------- | --------------------------------- | ----------------------------------------------------------------- |
| Viberti, Benjamin               | 46224179 | b.viberti@mi.unc.edu.ar           | [@benjaviberti](https://github.com/benjaviberti)                   |
| Espinoza Sutta, Aaron Alejandro | 96009173 | aaron.espinoza_4500@mi.unc.edu.ar | [@Aaron45000](https://github.com/Aaron45000)                       |
| Cleri, Juan Ignacio             | 46452662 | ignacio.cleri@mi.unc.edu.ar       | [@IgnaCleri](https://github.com/IgnaCleri)                         |
| Pineda, Juan Ignacio            | 45591343 | juan.ignacio.pineda@mi.unc.edu.ar | [@juanignaciopineda-dot](https://github.com/juanignaciopineda-dot) |
| Grafión, Atilio Leonel          | 43940195 | atilio.grafion@mi.unc.edu.ar      | [@Aollgn](https://github.com/Aollgn)                               |
| Badenes, Tomas                  | 44785038 | tomasbadenes@mi.unc.edu.ar        | [@b-Tomas](https://github.com/b-Tomas)                             |
| Oviedo, Ignacio Nicolas         | 43940195 | ignacio.oviedo.239@mi.unc.edu.ar  | [@GIX02](https://github.com/GIX02)                                 |
| Mendez, Jorge Nicolas           | 41301342 | jorge.mendez@mi.unc.edu.ar        | [@jorge088](https://github.com/jorge088)                           |

## Consigna 1

### a)

El fenómeno físico representado es el Efecto Doppler, ocasionado por el movimiento relativo entre la fuente emisora (barco) y el receptor (satélite).

Sus caracteristicas principales son:

- **Compresión de la onda:** Al reducirse la distancia entre el emisor y el receptor, cada nueva cresta de la onda se emite desde una posición más cercana que la anterior. Esto disminuye la longitud de onda ($\lambda$) y aumenta la frecuencia percibida ($f$) en el receptor.
- **Dependencia de la velocidad y frecuencia:** La desviación de frecuencia ($\Delta f$) es directamente proporcional a la velocidad relativa ($v$) entre los cuerpos y a la frecuencia central de la señal ($f_0$):

$$\Delta f = \frac{v}{c} f_0$$

- **Comportamiento dinámico:** Mientras el satélite se aproxima, la frecuencia recibida es mayor que la emitida ($f' > f$). Una vez que sobrepasa la vertical de la estación y comienza a alejarse, la frecuencia disminuye por debajo del valor nominal ($f' < f$).

### b)

Las bandas más afectadas son las de alta y muy alta frecuencia, principalmente **SHF (3 GHz – 30 GHz)** y **EHF (30 GHz – 300 GHz)**, utilizadas en enlaces satelitales y enlaces de microondas.

Esto se explica con la misma fórmula del punto anterior ($\Delta f = \frac{v}{c} f_0$): el corrimiento Doppler es directamente proporcional a la frecuencia de la portadora ($f_0$). Entonces, para una misma velocidad relativa $v$ (la de un satélite en órbita, por ejemplo), cuanto más alta es la portadora, mayor es el corrimiento absoluto en Hz. Como en SHF y EHF las portadoras ya son del orden de los GHz, ese corrimiento puede llegar a valores de kHz o incluso MHz, que resultan significativos frente al ancho de canal (generalmente angosto en estas bandas para aprovechar mejor el espectro). Esto desalinea la portadora recibida respecto de lo que espera el receptor, degradando la sincronización y elevando la tasa de error.

Las bandas más resilientes son las de baja frecuencia: **LF (30 kHz – 300 kHz)**, **MF (300 kHz – 3 MHz)** y **HF (3 MHz – 30 MHz)**. Al ser $f_0$ mucho menor, el mismo corrimiento relativo ($v/c$) produce un $\Delta f$ absoluto mucho más chico (del orden de fracciones de Hz a pocos Hz), insignificante frente al ancho de banda del canal. Además, estas bandas suelen usarse en enlaces terrestres o marítimos con velocidades relativas bajas (radio AM, comunicaciones marítimas, radioaficionados), lo que reduce todavía más el impacto del efecto Doppler.

### c)

No se debe encender el celular arriba de un avion para evitar molestias a los pilotos y no saturar las antenas en tierra.

- **Interferencia en la cabina:** Al estar en el aire y no haber señal el celular trabaja al maximo en busqueda de una antena. Esa transmisión a máxima potencia puede generar ruidos en los auriculares de los pilotos e interferir con los equipos de medición en el avion.
- **Saturación en redes de tierra:** Desde el aire, como no hay obstaculos que tapen la señal, el celular localiza cientos de antenas en tierra al mismo tiempo. Al intentar conectarse a todas las que encuentra satura la red celular de esa localidad mientras pasa.

Posee un vínculo directo con los puntos anteriores, ya que, tal como se explicó en el punto a), el corrimiento Doppler ($\Delta f = \frac{v}{c} f_0$) es proporcional a la velocidad relativa entre emisor y receptor. Las antenas terrestres están diseñadas para compensar el corrimiento típico de un usuario que se desplaza a velocidad de caminata, auto o incluso tren (hasta unos 200 km/h), mediante mecanismos de sincronización de portadora. Como el avión viaja a casi 900 km/h, el $\Delta f$ resultante excede el rango que esos mecanismos son capaces de corregir, por lo que la antena no logra engancharse establemente a la señal del celular y la conexión se corta de inmediato. Esto además retroalimenta el problema de saturación descripto en el punto anterior, ya que el equipo reintenta constantemente la búsqueda y conexión con nuevas antenas sin lograrlo.

## Consigna 2

### a)

El fenómeno físico observado representa el **ruido impulsivo**: un tipo de ruido eléctrico que se manifiesta como picos de amplitud elevada y de muy corta duración, que se superponen momentáneamente a la señal, a diferencia del ruido térmico, que es constante y de baja amplitud.

Se identifica en la Figura ya que la onda se transmite de forma limpia y periódica tanto al comienzo, cerca de la antena, como al final, cerca del celular; sin embargo, en el tramo intermedio (coincidente con la posición del operador y su equipo de radio), la forma de onda se distorsiona abruptamente en un conjunto de picos irregulares de mayor amplitud, para luego retomar su forma original. Esa alteración puntual es la representación gráfica característica del ruido impulsivo.

Sus causas pueden ser perturbaciones electromagnéticas externas (como tormentas atmosféricas) o fallos y defectos en los propios sistemas de comunicación.

Sus principales características son:

- **No es continuo:** a diferencia del ruido térmico (constante, predecible), aparece como pulsos o picos irregulares. Corta duración pero amplitud relativamente grande (picos de energía breves e intensos).
- **No es predecible:** no sigue un patrón constante ni predecible, por eso es más difícil de combatir mediante diseño del sistema que el ruido térmico.

### b)

- **VHF (30 MHz – 300 MHz) — Más afectada:** Es la banda más susceptible al ruido impulsivo, tanto de origen atmosférico (descargas eléctricas) como de origen humano (ignición de motores, conmutación en líneas eléctricas, electrodomésticos), cuyas interferencias concentran gran parte de su energía en este rango.
- **UHF (300 MHz – 3 GHz) — Afectación intermedia-baja:** Comienza a alejarse del grueso de energía del ruido impulsivo típico, por lo que su afectación disminuye respecto a VHF, aunque todavía conserva cierta sensibilidad a interferencias de equipos electrónicos cercanos.
- **SHF (3 GHz – 30 GHz) — Más resiliente al ruido impulsivo:** El ruido impulsivo deja de ser un problema relevante en esta banda; sin embargo, al tratarse de microondas de longitud de onda corta, aparecen otros fenómenos limitantes, como la atenuación por lluvia y por obstáculos físicos.
- **EHF (30 GHz – 300 GHz) — La más resiliente al ruido impulsivo:** Es la banda menos afectada por este fenómeno de las cuatro, pero paga el costo de ser la más vulnerable a la atenuación atmosférica (absorción por gases, lluvia, vapor de agua), lo que en la práctica limita su alcance más que el propio ruido impulsivo.

### c)

La **SNR** (Signal-to-Noise Ratio ó Relación Señal-Ruido) es el cociente entre la potencia de la señal y la potencia del ruido en un punto del medio de transmisión, expresado normalmente en decibelios:

$$SNR(dB) = 10 \times log_{10}\left(\frac{potencia\ señal}{potencia\ ruido}\right)$$

Una SNR alta indica que la señal recibida es de buena calidad —predomina claramente sobre el ruido de fondo— mientras que una SNR baja significa que el ruido está "contaminando" la señal de forma considerable, dificultando su correcta interpretación.

Respecto al BER (tasa de error de bit) Sí, están directamente relacionados, y de forma inversa: a mayor SNR, menor BER (menos errores por bit), y a menor SNR, mayor BER, ya que si la señal es mucho más fuerte que el ruido (SNR alta), el receptor puede distinguir con claridad si un bit corresponde a un 0 o un 1. Cuando el ruido se acerca en magnitud a la señal (SNR baja), aumenta la probabilidad de que el receptor confunda un bit por otro, elevando el BER.

## Consigna 3

### a) ¿Cómo ayudan los sistemas de transmisión digital a detectar y corregir errores producidos por ruido en el canal?

Los sistemas de transmisión digital logran detectar y corregir errores mediante la adición de redundancia estructurada a los datos antes de enviarlos. El ruido en un canal puede alterar los bits transmitidos, pero las técnicas de codificación permiten al receptor identificar la alteración y, en muchos casos, reconstruir el mensaje original sin pedir una retransmisión.

#### El principio básico: redundancia y distancia

Si se envía únicamente la información pura (por ejemplo, $101$), el receptor no tiene forma de saber si el ruido cambió un bit a $111$. Para evitar esto, el emisor añade bits adicionales calculados mediante fórmulas matemáticas específicas.

Esto se basa en la distancia de Hamming: la cantidad de posiciones en las que dos cadenas de bits difieren. Al espaciar matemáticamente las combinaciones válidas de datos, un bit alterado por ruido dará como resultado una combinación "no válida", alertando inmediatamente al receptor.

#### Mecanismos principales

- **Deteccion por paridad (para casos muy locales):** Parecido al bit de paridad en transmisiones serie de microcontroladores o de un bus de transmision de una memmoria ram.
- **CRC (Comprobacion de redundancia fisica):** Aplica una división polinómica sobre los datos para generar un residuo fijo al final del paquete. Es extremadamente eficiente para detectar ráfagas de ruido.
- **ARQ (Peticion de retransmision automatica):** Combina un método de detección con confirmaciones. Si el receptor detecta un error, solicita retransmitir el paquete afectado. Muy usado en el protocolo TCP/IP.
- **FEC (Correccion de errores adelante):** Añade suficiente redundancia para que el receptor no solo detecte el error, sino que calcule la posición exacta del bit alterado y lo invierta automáticamente. Usado en fibra optica o conexion 5G.

### b) ¿Y a compensar cambios en la frecuencia?

Los cambios de frecuencia en la señal recibida son causados principalmente por dos factores:

- Desviaciones en los osciladores
- Efecto Doppler

Para compensarlo, se utilizan mecanismos de sincronización de portadora y procesamiento digital de señales (DSP).

#### Sincronizacion de portadora

El receptor utiliza circuitos de realimentación y algoritmos en el dominio del tiempo para rastrear y enganchar la frecuencia de la señal entrante. Particularmente:

- Lazos de Seguimiento de Fase (PLL / Costas Loop)
- Bucles de Control de Frecuencia (FLL)

#### Estimación y compensación digital (dominio de frecuencia)

En modulaciones modernas de banda ancha (como Wi-Fi, 4G, 5G y redes satelitales), la compensación se procesa digitalmente mediante algoritmos. Estos son:

- Secuencias de Entrenamiento y Símbolos Pilot
- Transformada Rápida de Fourier (FFT)

#### Modulación OFDM y prefijo cíclico

En redes masivas como Wi-Fi 6, 4G y 5G, se emplea OFDM (Multiplexación por División de Frecuencias Ortogonales). La señal total se divide en subportadoras muy juntas pero ortogonales. Si ocurre un desplazamiento de frecuencia, se pierde la ortogonalidad. Para resolverlo, los sistemas digitales añaden un Prefijo Cíclico (CP) al inicio de cada bloque de datos. Este funciona como un colchón temporal que permite al receptor estimar el desfase de frecuencia antes de procesar el símbolo y corregir la rotación de los datos mediante ecualizadores digitales.

## Consigna 4

### a)

La **sincronización en la comunicación digital** requiere que el emisor y el receptor coordinen su temporización. El receptor debe conocer el instante exacto en que inicia cada bit y la velocidad a la que llegan. Así, puede muestrearlos en el momento correcto para evitar pérdidas o mezclas de información.

- **Sincronización de bits:** Le dice al receptor exactamente cuándo empieza y termina cada bit individual.
- **Sincronización de trama:** Le dice al receptor dónde empieza y dónde termina el bloque completo de bits (la trama), es decir, cuándo arranca y cuándo termina el mensaje entero.
- **La diferencia:** la sincronización de bits pasa muchas veces por segundo (una por cada bit), mientras que la sincronización de trama pasa una sola vez por cada bloque de datos completo.

### b)

Una **trama** (frame) es un bloque de bits organizado que agrupa la información a enviar junto con datos de control necesarios para que el receptor la entienda correctamente.

Comparación de sus tres partes:

- **Header (encabezado):** va al principio. Contiene información de control (direcciones, tipo de trama, etc.).
- **Payload (carga útil):** va en el medio. Es el contenido real, los datos que efectivamente le interesan al usuario (lo que se quiere transmitir).
- **Trailer (tráiler):** va al final. Contiene información de cierre y control de errores.
- **La diferencia principal:** header y trailer son "metadatos" que ayudan a transportar y verificar la información, mientras que el payload es la información en sí misma.

### c)

El **preámbulo** es un patrón fijo de bits que se coloca al **inicio de una trama** para indicar al receptor dónde comienza un mensaje nuevo. Este elemento **no forma parte de los datos útiles** que se desean transmitir, sino que funciona estrictamente como una señalización de control y se descarta una vez que cumple su función.

### d)

| Método | Cómo funciona | Ventaja | Desventaja |
| --- | --- | --- | --- |
| **Longitud fija** | Todas las tramas miden exactamente lo mismo | Simple, no hace falta contar ni buscar nada | Desperdicia espacio si los datos son más cortos que el tamaño fijo |
| **Campo de longitud** | Un campo en el header dice cuántos bytes tiene la trama | Flexible, tramas de tamaño variable | Si ese campo se corrompe por ruido, se pierde la sincronización de toda la trama |
| **Delimitadores** | Un patrón especial de bits marca inicio y fin | Robusto, el receptor solo busca el patrón | Requiere "relleno de bits o caracteres" (*bit/character stuffing*) si el patrón aparece por casualidad en los datos |

## Consigna 5

La resolución completa de esta consigna está documentada en **[`extraccion-de-payloads/Ejercicio_5.md`](extraccion-de-payloads/Ejercicio_5.md)**, junto con el programa en Go que la implementa ([`main.go`](extraccion-de-payloads/main.go)).

### Resumen

Se escribió un programa en Go que recorre el archivo `frames.bin`, localiza la trama de cada grupo por su etiqueta y extrae la carga útil correspondiente. El formato de trama utilizado es:

```
[ GROUP 5 bytes ][ SEQ 1 byte ][ LENGTH 1 byte ][ PAYLOAD LENGTH bytes ]
       +0              +5            +6                  +7
```

El programa busca todas las apariciones de la etiqueta de cada grupo, lee `SEQ` y `LENGTH` a partir de ese offset, valida los límites del payload, descarta las tramas mal alineadas (payload no imprimible) y finalmente ordena los paquetes por número de secuencia para reconstruir el mensaje concatenando los caracteres.

En total se identificaron **25 tramas** repartidas entre 24 etiquetas de grupo. El mensaje reconstruido resulta ser un enlace:

```
https://www.youtube.com/shorts/dbbe_ln6Lnw
```

### Carga útil de nuestro grupo

La trama correspondiente a **WireGuardians** se localiza mediante la etiqueta `wireg` y es la siguiente:

| Grupo | GROUP | Offset | SEQ | LENGTH | Payload |
| --- | --- | ---: | ---: | ---: | --- |
| WireGuardians | `wireg` | 1101 | 25 | 3 | `Lnw` |

Al ser `SEQ` 25 —el número de secuencia más alto de todo el archivo— nuestra carga útil es la que cierra el mensaje: los tres últimos caracteres del enlace reconstruido.

### Observaciones

- El enunciado especifica `GROUP` como un campo de **32 bits (4 caracteres)**, pero las tramas del archivo solo son consistentes con etiquetas de **5 bytes**; el programa trabaja con esta última longitud.
- Tres tramas presentan anomalías que impiden una extracción totalmente automática: los `SEQ` 7 y 10 llegan con valores corruptos (`0x20` y `0x0d` en lugar de `0x07` y `0x0a`) y la trama del `SEQ` 12 tiene bytes de relleno intercalados antes de su header.
- El grupo `Bitless` no tiene ninguna trama en el archivo, `NetRunners` es el único con dos, y aparece una etiqueta `ferne` que no figura en la planilla compartida.

El detalle completo —tabla de las 25 tramas con offset, `SEQ`, `LENGTH` y payload de cada grupo, y la descripción de cada función del programa— está en [`Ejercicio_5.md`](extraccion-de-payloads/Ejercicio_5.md).
