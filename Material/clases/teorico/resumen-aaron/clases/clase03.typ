#import "../lib.typ": *

= Clase 3 (24/8) — Introducción a las redes de datos: arquitecturas de protocolos

#lectura[
  [STA] Parte I, *Capítulo 2*: 2.1 ¿Por qué una arquitectura de protocolos? · 2.2 Arquitectura simple
  (modelo de tres capas, arquitecturas normalizadas) · 2.3 OSI (modelo, normalización, primitivas,
  capas) · 2.4 TCP/IP (capas, TCP y UDP, funcionamiento, aplicaciones, interfaces) · Apéndice 2A (TFTP).
  Los temas *Internet: orígenes, servicios, arquitectura* y *organismos de normalización* no están
  desarrollados en ese capítulo y se resumen de [COM] Cap. 1 y conocimiento general.
]

== Concepto de red de telecomunicación y de arquitectura de protocolos (2.1)

Una *red de telecomunicación* es el conjunto de nodos, enlaces y reglas que permite intercambiar
información entre sistemas finales que no están conectados directamente. Para transferir, por ejemplo,
un archivo, hace falta: (1) activar un camino o indicar a la red el destino, (2) asegurarse de que el
destino está listo para recibir, (3) que la aplicación remota pueda aceptar y guardar el archivo y
(4) traducir formatos si son incompatibles. En vez de un único módulo, el problema se divide en
*capas* apiladas:

- Cada capa realiza un subconjunto de funciones relacionadas, *usa los servicios de la inferior* y *ofrece servicios a la superior*; idealmente cambiar una capa no obliga a cambiar las demás.
- La comunicación se logra entre *capas pares* (mismo nivel en sistemas distintos) intercambiando bloques de datos según un *protocolo*.

#clave[
  *Protocolo*: conjunto de reglas para el intercambio de datos entre entidades pares. Sus aspectos clave son
  la *sintaxis* (formato de los bloques de datos), la *semántica* (información de control para
  coordinación y manejo de errores) y la *temporización* (ajuste de velocidades y secuenciación).
  *Arquitectura de protocolos*: la estructura en capas de módulos hardware/software que implementan esas funciones.
]

== Una arquitectura simple de tres capas (2.2)

#fig("fig-2-1.png", [Arquitectura simplificada para transferencia de archivos.], fuente: "Stallings, Fig. 2.1, p. 24", ancho: 65%)

Analogía de la oficina: el ejecutivo (aplicación) prepara el documento, el administrativo (servicio de
comunicaciones) lo pone en un sobre con dirección y remitente, y el departamento de envíos (acceso a la
red) elige correo o mensajería. Generalizando:

- *Capa de acceso a la red*: intercambio de datos entre el computador y *su* red (dirección destino, prioridades). Depende del tipo de red; aísla a las capas superiores de esos detalles.
- *Capa de transporte*: intercambio *fiable* (todos los datos, en orden) independientemente de la aplicación.
- *Capa de aplicación*: lógica de cada aplicación (un módulo por tipo).

*Dos niveles de direccionamiento*: cada computador tiene una *dirección de red*; cada aplicación tiene
dentro del computador un *punto de acceso al servicio (SAP)* o *puerto*. La red solo necesita la
dirección del computador; el SAP lo usa la capa de transporte.

#grid(columns: (1fr, 1fr), gutter: 8pt,
  fig("fig-2-3.png", [Protocolos en una arquitectura simplificada.], fuente: "Stallings, Fig. 2.3, p. 26", ancho: 100%),
  fig("fig-2-4.png", [Unidades de datos de los protocolos (PDU).], fuente: "Stallings, Fig. 2.4, p. 27", ancho: 100%),
)

*Encapsulado*: cada capa agrega una *cabecera* con información de control a los datos de la capa superior;
el conjunto es la *PDU* (_Protocol Data Unit_) de esa capa. La cabecera de transporte lleva, por ejemplo,
*SAP destino*, *número de secuencia* (para reordenar) y *código de detección de errores*; la de acceso a la
red lleva la *dirección del computador destino* y *solicitudes de recursos* (prioridad). La capa
inferior *no mira* el contenido de la PDU superior. En el destino cada capa quita su cabecera y entrega
el resto hacia arriba.

#fig("fig-2-5.png", [Funcionamiento de una arquitectura de protocolos.], fuente: "Stallings, Fig. 2.5, p. 28", ancho: 70%)

*Arquitecturas normalizadas*: sin estándares, comunicar equipos de distintos fabricantes es una
pesadilla. Ventajas: los fabricantes ganan mercado y los clientes pueden exigir el estándar. Las dos
arquitecturas determinantes son *TCP/IP* (la más usada) y *OSI* (referencia teórica); SNA de IBM es propietaria.

== El modelo de referencia OSI (2.3)

Desarrollado por ISO desde 1977; norma *ISO 7498* (1984), equivalente a la UIT-T *X.200*. Principios de
diseño (Tabla 2.1, resumen): no demasiadas capas; fronteras donde la interfaz sea mínima; separar
funciones manifiestamente distintas y agrupar las similares; permitir rediseñar una capa sin afectar a
las adyacentes; cada capa solo se relaciona con sus vecinas; subcapas cuando haga falta.

#grid(columns: (1fr, 1.25fr), gutter: 8pt,
  fig("fig-2-6.png", [Las siete capas de OSI.], fuente: "Stallings, Fig. 2.6, p. 31", ancho: 92%),
  fig("fig-2-7.png", [El entorno OSI: encapsulado en cada capa.], fuente: "Stallings, Fig. 2.7, p. 33", ancho: 100%),
)

#tabla(
  columns: (auto, auto, 1fr),
  [*N.º*], [*Capa*], [*Función principal*],
  [7], [Aplicación], [Acceso de las aplicaciones al entorno OSI; servicios distribuidos (transferencia de archivos, correo, terminal remota).],
  [6], [Presentación], [Sintaxis y representación de los datos; transformación, compresión y cifrado.],
  [5], [Sesión], [Control del diálogo (full o half-duplex), agrupamiento de datos y recuperación por puntos de comprobación.],
  [4], [Transporte], [Transferencia extremo a extremo fiable: sin errores, en orden, sin pérdidas ni duplicados; calidad de servicio. ISO definió 5 clases; en TCP/IP son TCP y UDP.],
  [3], [Red], [Transferencia entre sistemas finales a través de una o varias redes; encaminamiento y conmutación. Innecesaria en un enlace punto a punto directo.],
  [2], [Enlace de datos], [Hace fiable el enlace físico: tramas, detección y control de errores, flujo; activar/mantener/desactivar el enlace (HDLC, LLC).],
  [1], [Física], [Transmisión de bits por el medio. Características *mecánicas* (conectores), *eléctricas* (niveles, velocidad), *funcionales* (función de cada circuito) y *de procedimiento* (secuencia de eventos). Ej. EIA-232.],
)

Salvo en la física, *no hay comunicación directa entre pares*: cada entidad pasa datos a la capa inferior.
La capa 2 suele agregar cabecera *y cola* (trama). Cualquier capa puede *fragmentar* la PDU que recibe;
la par la reensambla. Los nodos intermedios (retransmisores) implementan solo las capas 1 a 3; las
capas 4 a 7 son *extremo a extremo*.

#fig("fig-2-11.png", [Uso de un retransmisor (nodo de red): solo capas 1–3.], fuente: "Stallings, Fig. 2.11, p. 38", ancho: 55%)

=== Normalización dentro de OSI

Cada capa se puede normalizar independientemente y en paralelo. En cada capa se normalizan tres cosas:
*especificación del protocolo* (formato de PDU, semántica de campos, secuencias permitidas),
*definición del servicio* (descripción funcional de qué se ofrece a la capa superior, no cómo) y
*direccionamiento* (las entidades usuarias se identifican por un SAP; ej. NSAP en la capa de red). El
SAP permite *multiplexar* varios usuarios de la capa superior.

=== Primitivas de servicio

#grid(columns: (1.2fr, 1fr), gutter: 10pt,
  tabla(
    columns: (auto, 1fr),
    [*Primitiva*], [*Quién y para qué*],
    [Solicitud], [El usuario invoca un servicio y pasa parámetros.],
    [Indicación], [El proveedor avisa al usuario par que se invocó un servicio (o una acción del proveedor).],
    [Respuesta], [El usuario par completa/confirma lo indicado.],
    [Confirmación], [El proveedor confirma al solicitante que se completó.],
  ),
  fig("fig-2-10.png", [Servicio confirmado y no confirmado.], fuente: "Stallings, Fig. 2.10, p. 36", ancho: 100%),
)

*Servicio confirmado*: solicitud → indicación → respuesta → confirmación. *No confirmado*: solo
solicitud → indicación.

== La arquitectura TCP/IP (2.4)

Nació de ARPANET (DARPA); sus estándares los define la comunidad de Internet (IAB/IETF). Stallings la
presenta en *cinco capas*:

- *Física*: interfaz con el medio, señales, velocidad.
- *Acceso a la red*: intercambio entre el sistema final y la red a la que está conectado (Ethernet, frame relay, etc.).
- *Internet (IP)*: encaminamiento a través de varias redes; está en sistemas finales *y en routers*.
- *Transporte (extremo a extremo)*: TCP (orientado a conexión, fiable) o UDP (datagramas, sin garantías). Solo en sistemas finales.
- *Aplicación*: lógica de las aplicaciones.

#grid(columns: (0.8fr, 1.2fr), gutter: 8pt,
  fig("fig-2-12.png", [Comparación TCP/IP vs OSI.], fuente: "Stallings, Fig. 2.12, p. 41", ancho: 90%),
  fig("fig-2-13.png", [Conceptos de TCP/IP: dirección IP global, puertos (SAP) y routers.], fuente: "Stallings, Fig. 2.13, p. 42", ancho: 100%),
)

*TCP* ofrece una *conexión* (asociación lógica temporal) entre un par de puertos; su PDU es el *segmento*,
con puerto origen/destino, número de secuencia y suma de comprobación. *UDP* no garantiza entrega, orden
ni ausencia de duplicados: casi solo agrega puertos a IP (lo usan SNMP, TFTP, DNS).

*Funcionamiento*: un proceso en el puerto 1 de A envía a un proceso en el puerto 2 de B. TCP arma el
segmento y lo pasa a IP con el destino B; IP agrega su cabecera (dirección de B) formando el *datagrama* y
lo pasa a la capa de acceso a la red con instrucción de enviarlo al *router J* (primer salto), que
agrega su cabecera formando la *trama*. En J se quita la cabecera de red, se mira la cabecera IP y se
reenvía por la subred 2 con una nueva cabecera de acceso. En B se desencapsula hasta el proceso.

#fig("fig-2-14.png", [Unidades de datos en TCP/IP: segmento TCP, datagrama IP y trama (paquete de red).], fuente: "Stallings, Fig. 2.14, p. 43", ancho: 55%)

#tabla(
  columns: (auto, auto, 1fr),
  [*Capa*], [*PDU*], [*Dirección que usa*],
  [Aplicación], [Mensaje / datos], [Nombres (DNS), URL],
  [Transporte], [Segmento (TCP) / datagrama de usuario (UDP)], [Puerto (16 bits)],
  [Internet], [Datagrama IP / paquete], [Dirección IP (32 bits en IPv4)],
  [Acceso a la red], [Trama], [Dirección física (MAC, 48 bits)],
  [Física], [Bits / símbolos], [—],
)

*Aplicaciones clásicas*: *SMTP* (correo: listas, acuses, reenvío; no crea los mensajes), *FTP* (usa dos
conexiones TCP: una de *control* para usuario, contraseña y órdenes y otra de *datos* para el archivo),
*TELNET* (terminal remota virtual). *Interfaces*: una aplicación puede usar cualquier capa: la mayoría
usa TCP, otras UDP, otras IP directamente (ej. ICMP, OSPF) o la red directamente.

#fig("fig-2-15.png", [Algunos protocolos de la familia TCP/IP.], fuente: "Stallings, Fig. 2.15, p. 46", ancho: 50%)

== Ejemplo de protocolo: TFTP (Apéndice 2A)

- Sobre *UDP*; la solicitud va al *puerto 69*; durante la transferencia cada extremo usa un *TID* (identificador de transferencia) como puerto. Sin control de acceso: solo directorios públicos; útil para arranque de equipos sin disco.
- Cinco paquetes (código de 2 bytes): *RRQ* (1, leer), *WRQ* (2, escribir), *DATA* (3, bloques numerados desde 1, de 0 a 512 bytes; < 512 = último), *ACK* (4, confirma un bloque; ACK 0 confirma un WRQ) y *ERROR* (5; códigos 0–7: no definido, archivo no encontrado, acceso violado, disco lleno, operación ilegal, TID desconocido, archivo existe, usuario inexistente).
- *Parada y espera*: cada DATA espera su ACK; ante expiración del temporizador se retransmite; los números de bloque evitan confundir duplicados; un ACK duplicado se ignora.
- *Sintaxis* = formato de paquetes; *semántica* = significado de tipos y códigos de error; *temporización* = orden de intercambio, numeración y temporizadores.

#fig("fig-2-17.png", [Formatos de los paquetes TFTP.], fuente: "Stallings, Fig. 2.17, p. 50", ancho: 55%)

== Internet: orígenes, servicios y arquitectura

#extra[
  *Orígenes.* 1969: *ARPANET* (DARPA), primera red de conmutación de paquetes con 4 nodos. 1974: Cerf y
  Kahn publican el diseño de TCP/IP. *1/1/1983*: ARPANET migra a TCP/IP (nace "la Internet") y aparece BSD
  UNIX con sockets; 1983–84: DNS. 1986: NSFNET como troncal académica. 1991: la *World Wide Web*
  (Berners-Lee, CERN). 1995: fin de NSFNET y comercialización (ISPs). Hoy: miles de millones de
  dispositivos, IPv6, móviles, nube.

  *Servicios básicos* (nivel de aplicación): correo electrónico, Web, transferencia de archivos,
  acceso remoto (TELNET/SSH), DNS, mensajería y voz/video. A nivel de red Internet ofrece un servicio de
  *entrega de datagramas sin conexión y de mejor esfuerzo*; la fiabilidad la pone TCP en los extremos
  (principio *extremo a extremo*).

  *Arquitectura.* Internet es una *red de redes*: miles de redes heterogéneas unidas por *routers*, que
  presentan a los usuarios una única red virtual gracias a IP. En el *borde* están los sistemas finales
  (hosts) y las redes de acceso (DSL, cable, fibra, celular, Wi-Fi); en el *núcleo*, los routers y
  enlaces de los ISP. Los ISP se organizan jerárquicamente (de nivel 1, globales; regionales; de acceso)
  y se interconectan en *IXP* (puntos de intercambio) por acuerdos de tránsito o _peering_. Cada red
  administrada independientemente es un *sistema autónomo (AS)* y entre ellos se usa BGP (Clase 8).
]

== Organismos internacionales de normalización

#tabla(
  columns: (auto, 1fr),
  [*Organismo*], [*Ámbito y aportes*],
  [ISO], [Organización Internacional de Normalización: modelo OSI (ISO 7498), normas de cableado (ISO/IEC 11801).],
  [UIT-T (ex CCITT)], [Sector de normalización de telecomunicaciones de la ONU: recomendaciones series V (módems), X (X.25, X.200), G (transmisión, PCM, SDH), H (multimedia).],
  [IEEE], [Comité 802 de LAN/MAN: 802.1 (puentes, VLAN, STP), 802.3 (Ethernet), 802.11 (Wi-Fi), 802.15 (Bluetooth).],
  [IETF / IAB / IRTF / ISOC], [Comunidad de Internet: el IETF desarrolla los protocolos de TCP/IP en grupos de trabajo y los publica como *RFC*; el IAB supervisa la arquitectura; el IRTF investiga a largo plazo; la Internet Society da el marco institucional.],
  [IANA / ICANN y RIR], [Asignan números (direcciones IP, puertos, AS) y gestionan la raíz del DNS; los registros regionales (LACNIC en América Latina) distribuyen direcciones.],
  [ANSI, EIA/TIA, ETSI, W3C], [ANSI: estándares de EE. UU.; EIA/TIA: cableado estructurado (TIA-568, EIA-232); ETSI: telecomunicaciones europeas (GSM); W3C: estándares de la Web (HTML, XML).],
)

== Guía de cuestiones de repaso (Cap. 2)

#pr("2.1")[Función principal de la capa de acceso a la red.][Intercambiar datos entre el sistema final y la red a la que está conectado: entregarle la dirección destino y pedir servicios (prioridad), aislando a las capas superiores del tipo de red.]
#pr("2.2")[Tareas de la capa de transporte.][Asegurar que los datos lleguen al proceso correcto (puertos/SAP) de forma fiable y en orden: numeración, detección de errores, control de flujo, retransmisión; segmentar y reensamblar.]
#pr("2.3")[¿Qué es un protocolo?][Conjunto de reglas (sintaxis, semántica y temporización) que gobiernan el intercambio de datos entre entidades pares.]
#pr("2.4")[¿Qué es una PDU?][La unidad que intercambian entidades pares: datos de la capa superior + información de control (cabecera, a veces cola) de la capa.]
#pr("2.5")[¿Qué es una arquitectura de protocolos?][Estructura en capas de módulos hardware/software que implementan las funciones de comunicación, cada uno con su protocolo.]
#pr("2.6")[¿Qué es TCP/IP?][La familia de protocolos de Internet (estándares del IAB/IETF), organizada en capas física, acceso a la red, internet, transporte y aplicación.]
#pr("2.7")[Ventajas de una arquitectura en capas.][Divide un problema complejo en partes manejables; cada capa puede cambiar sin afectar a las demás; permite normalizar por partes y combinar productos de distintos fabricantes; reutilización (varias aplicaciones usan el mismo transporte).]
#pr("2.8")[¿Qué es un encaminador?][Un dispositivo que conecta redes y reenvía datos (datagramas IP) de una a otra eligiendo la ruta hacia el destino.]

== Guía de ejercicios (Cap. 2)

#pr("2.1")[Pedir una pizza con capas.][Cliente ↔ pizzero acuerdan el pedido (aplicación); el teléfono transmite la conversación (red); el repartidor entrega la pizza (transporte/acceso). Cada nivel conversa con su par usando el servicio del nivel inferior.]
#pr("2.2")[Primeros ministros con traductores.][(a) Tres capas: ministros (idea/acuerdo), traductores (idioma común: inglés), teléfono (transmisión). (b) Los traductores japonés y alemán no se entienden: se necesita un *retransmisor* (el traductor japonés-alemán en Alemania), análogo a un nodo intermedio que convierte entre "protocolos".]
#pr("2.3")[Desventajas del diseño en capas.][Sobrecarga (cabeceras y procesamiento en cada capa), funciones duplicadas en varias capas (control de errores), información oculta que impide optimizar, posible menor rendimiento.]
#pr("2.4")[Problema de los dos ejércitos.][No existe protocolo que garantice el acuerdo con un canal no fiable: el último mensaje siempre puede perderse y su emisor nunca está seguro. Solo se puede aumentar la probabilidad de éxito (mensajes repetidos).]
#pr("2.5")[¿Hace falta capa 3 en una red de difusión?][Dentro de una única red de difusión no hace falta encaminar (todos reciben todo; basta el direccionamiento de capa 2). Sí hace falta si la red se interconecta con otras.]
#pr("2.6")[Arquitecturas de 8 y 6 capas.][Ejemplo: 8 capas separando enlace en LLC y MAC (como IEEE 802) o separando seguridad; 6 capas fusionando sesión y presentación. Justificar con los principios de la Tabla 2.1.]
#pr("2.7")[Segmentación y agrupamiento.][(a) No: la cabecera N viaja una sola vez (dentro del primer segmento); cada segmento lleva su cabecera N−1 y la capa N−1 par reensambla antes de entregar. (b) Cada PDU N debe conservar su cabecera para que la entidad N receptora pueda separarlas e interpretarlas; la capa N−1 no puede fusionarlas porque no conoce su contenido.]
#pr("2.8")[Problema del "aprendiz de brujo" (TFTP).][Si un DATA se retrasa (no se pierde) y expira el temporizador, se retransmite; el receptor envía dos ACK; cada ACK duplicado provoca el envío del bloque siguiente dos veces, cada uno genera dos ACK… y el tráfico se duplica en cada bloque. Por eso RFC 1350 dice que los ACK duplicados no se confirman/responden.]
#pr("2.9")[¿Qué determina el tiempo de transferencia en TFTP?][Al ser parada y espera, el tiempo de ida y vuelta (RTT): $t approx ("tamaño"\/512) times ("RTT" + "tiempo de transmisión de un bloque")$.]
