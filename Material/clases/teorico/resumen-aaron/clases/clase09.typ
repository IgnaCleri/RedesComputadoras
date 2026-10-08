#import "../lib.typ": *

= Clase 9 (5/10) — Capa de transporte: TCP, UDP y NAT

#lectura[
  [COM] *Cap. 10* "User Datagram Protocol (UDP)", *Cap. 11* "Reliable Stream Transport Service (TCP)" y
  *Cap. 19* "Network Virtualization: VPNs, NATs, And Overlays" (secciones de NAT).
  Complementarias: [STA] *Cap. 20* "Protocolos de transporte" (de donde salen las figuras y la guía de
  ejercicios) y [KR] Cap. 3.
]

== Servicios de la capa de transporte

IP entrega datagramas *entre equipos*; la capa de transporte los entrega *entre procesos* (aplicaciones) y,
si se pide, de forma fiable. Funciones: *multiplexación/demultiplexación* mediante *puertos* de 16 bits,
detección de errores y, en TCP, conexión, fiabilidad, orden, control de flujo y de congestión. Solo existe
en los *sistemas finales*.

- *Socket* = (dirección IP, puerto). Una *conexión TCP* se identifica por la *4-tupla* (IP origen, puerto origen, IP destino, puerto destino): un servidor en el puerto 80 atiende muchas conexiones a la vez.
- Puertos *bien conocidos* 0–1023 (asignados por IANA a servidores), *registrados* 1024–49151 y *dinámicos/efímeros* 49152–65535 (los elige el cliente).

#tabla(
  columns: (auto, auto, 1fr),
  [*Puerto*], [*Transporte*], [*Servicio*],
  [20/21], [TCP], [FTP datos/control],
  [22 / 23], [TCP], [SSH / TELNET],
  [25], [TCP], [SMTP],
  [53], [UDP y TCP], [DNS],
  [67/68], [UDP], [DHCP/BOOTP servidor/cliente],
  [69], [UDP], [TFTP],
  [80 / 443], [TCP (443 también UDP/QUIC)], [HTTP / HTTPS],
  [110 / 143], [TCP], [POP3 / IMAP],
  [161/162], [UDP], [SNMP / traps],
  [179], [TCP], [BGP],
  [520], [UDP], [RIP],
)

Stallings justifica tener servicios *sin conexión* también en transporte: recolección de datos (sensores),
difusión de datos (anuncios, hora), petición/respuesta (transacciones) y tiempo real (voz), donde
establecer una conexión o retransmitir no conviene.

== UDP (User Datagram Protocol)

#fig("fig-20-14.png", [Cabecera UDP (8 bytes).], fuente: "Stallings, Fig. 20.14, p. 717", ancho: 50%)

- Protocolo "delgado": solo agrega a IP los *puertos* y una *suma de comprobación*. Sin conexión, *no fiable* (los mensajes pueden perderse, duplicarse, retrasarse o desordenarse), sin control de flujo ni de congestión, *preserva los límites de mensaje* (cada envío = un datagrama).
- Cabecera: puerto origen (opcional, 0 si no se espera respuesta) · puerto destino · *longitud* (cabecera + datos, mínimo 8) · suma de comprobación.
- La suma de comprobación cubre cabecera, datos y una *pseudocabecera* (IP origen, IP destino, cero, protocolo = 17, longitud UDP) para verificar que el datagrama llegó al destino correcto. Es *opcional en IPv4* (0 = no calculada) y obligatoria en IPv6. Si falla, el datagrama se descarta sin aviso.
- Si llega a un puerto sin proceso escuchando: se descarta y se envía ICMP "puerto inalcanzable".
- Usos: DNS, DHCP, SNMP, TFTP, RIP, voz y video en tiempo real (RTP), juegos, QUIC. Ventajas: sin retardo de conexión, sin estado, cabecera mínima, el emisor controla el ritmo. La aplicación debe tolerar o resolver pérdidas.

== Fundamentos de la transmisión fiable

- *Confirmación positiva con retransmisión*: el receptor confirma (ACK) y el emisor retransmite si vence un *temporizador*. *Números de secuencia* para detectar duplicados y reordenar.
- *Ventana deslizante*: el emisor puede tener hasta $W$ datos sin confirmar; al llegar un ACK la ventana se desplaza. Mantiene la red ocupada en vez de esperar cada ACK (parada y espera).
- Para aprovechar el canal la ventana debe cubrir el *producto ancho de banda × retardo*: $W >= R times "RTT"$. Con ventana $W$, el rendimiento máximo es $W\/"RTT"$.

#ejemplo(titulo: "Rendimiento limitado por la ventana (Comer, ejercicio 11.15)")[
  Ventana máxima de 64 KB (65 535 bytes) con ancho de banda infinito y RTT = 20 ms:
  $65 535 times 8 \/ 0,02 approx 26,2$ Mbps. Con RTT = 40 ms se reduce a la mitad: 13,1 Mbps. No depende
  de IPv4 o IPv6 (la ventana está en bytes de datos). Para un enlace de 1 Gbps con RTT de 60 ms haría falta
  una ventana de $10^9 times 0,06 \/ 8 = 7,5$ MB → opción de *escalado de ventana*.
]

== TCP (Transmission Control Protocol)

Servicio de *flujo de bytes fiable*: orientado a conexión, punto a punto, *full-duplex*, sin límites de
mensaje (la aplicación ve una secuencia de bytes), con buffers, control de flujo y de congestión. Hace pocas
suposiciones sobre la red subyacente. La PDU es el *segmento*.

#fig("fig-20-10.png", [Cabecera TCP (20 bytes sin opciones).], fuente: "Stallings, Fig. 20.10, p. 701", ancho: 55%)

#tabla(
  columns: (auto, auto, 1fr),
  [*Campo*], [*Bits*], [*Significado*],
  [Puertos origen/destino], [16 + 16], [Identifican los procesos extremos.],
  [Número de secuencia], [32], [Número del *primer byte de datos* del segmento (en un SYN, el ISN).],
  [Número de confirmación], [32], [*Próximo byte que se espera* recibir (confirmación *acumulativa*); válido si ACK = 1.],
  [Desplazamiento de datos], [4], [Longitud de la cabecera en palabras de 32 bits (5–15 → 20–60 bytes).],
  [Indicadores], [6 (+3)], [*URG* (puntero urgente válido), *ACK*, *PSH* (entregar ya), *RST* (abortar), *SYN* (sincronizar números al abrir), *FIN* (no hay más datos). Más ECE, CWR para ECN.],
  [Ventana], [16], [*Crédito*: cuántos bytes más acepta el receptor a partir del número de confirmación (control de flujo).],
  [Suma de comprobación], [16], [Cabecera + datos + pseudocabecera (protocolo 6), obligatoria.],
  [Puntero urgente], [16], [Desplazamiento hasta el final de los datos urgentes.],
  [Opciones], [var.], [*MSS* (tamaño máximo de segmento, en el SYN), *escalado de ventana* (×$2^F$, $F <= 14$), *SACK* (confirmación selectiva), *marcas de tiempo*.],
)

Las confirmaciones viajan "a caballito" (_piggyback_) en los segmentos de datos del sentido contrario. *PSH*
fuerza la entrega inmediata; *URG* señala datos urgentes (fuera de banda).

=== Establecimiento de la conexión: acuerdo en tres pasos

Un extremo hace *apertura pasiva* (servidor: LISTEN) y el otro *apertura activa* (cliente).

+ Cliente → `SYN, seq = x` (estado SYN-SENT).
+ Servidor → `SYN + ACK, seq = y, ack = x + 1` (SYN-RECEIVED).
+ Cliente → `ACK, seq = x + 1, ack = y + 1` → ambos en ESTABLISHED.

El SYN y el FIN consumen un número de secuencia. Los *números iniciales (ISN)* se eligen al azar/por reloj
para no confundir segmentos de conexiones anteriores. El diálogo en *tres* pasos (en vez de dos) permite
rechazar un *SYN duplicado y obsoleto*: si B recibe un SYN viejo y responde, A, que no lo reconoce, envía
RST.

#grid(columns: (1fr, 1fr), gutter: 8pt,
  fig("fig-20-9.png", [Diálogo en tres pasos: funcionamiento normal y con SYN obsoletos.], fuente: "Stallings, Fig. 20.9, p. 697", ancho: 90%),
  fig("fig-20-8.png", [Diagrama de estados de la entidad TCP.], fuente: "Stallings, Fig. 20.8, p. 696", ancho: 100%),
)

=== Cierre y reinicio

Cada sentido se cierra por separado (*semicierre*): `FIN` → `ACK` en un sentido y luego en el otro (4
segmentos, o 3 si el FIN y el ACK van juntos). Quien cierra primero pasa por FIN-WAIT-1, FIN-WAIT-2 y
*TIME-WAIT*, donde espera *2 × MSL* (tiempo máximo de vida del segmento) para (a) poder reenviar el último ACK
si se perdió y (b) que mueran los segmentos viejos antes de reutilizar la misma 4-tupla. El otro pasa por
CLOSE-WAIT y LAST-ACK. *RST* aborta la conexión de inmediato (puerto cerrado, error, conexión inexistente).

=== Control de flujo (esquema de créditos)

El receptor anuncia en *Ventana* cuántos bytes puede aceptar: el emisor puede enviar los bytes desde el
número de confirmación hasta *confirmación + ventana − 1*. A diferencia de las ventanas de HDLC, *confirmar y
dar crédito están desacoplados*: el receptor puede confirmar sin abrir la ventana (ventana 0 detiene al
emisor, que sondea periódicamente con el *temporizador de persistencia*).

#fig("fig-20-1.png", [Ejemplo del mecanismo de asignación de créditos de TCP.], fuente: "Stallings, Fig. 20.1, p. 685", ancho: 55%)

*Síndrome de la ventana tonta* (SWS): si el receptor anuncia ventanas muy chicas o el emisor manda
segmentos muy chicos, se envían muchos segmentos con mucha cabecera y poco dato. Soluciones: el *receptor*
no anuncia aumentos hasta poder abrir al menos $min("MSS", "buffer"\/2)$ (y puede retrasar los ACK); el
*emisor* usa el *algoritmo de Nagle*: con datos sin confirmar, acumula los datos nuevos hasta tener un
segmento completo o recibir el ACK.

=== Temporizador de retransmisión

El RTO debe adaptarse al RTT medido:

- *Promediado exponencial* (RFC 793): $"SRTT"(K+1) = alpha dot "SRTT"(K) + (1 - alpha) dot "RTT"(K+1)$, con $alpha approx 0,8$–$0,9$, y $"RTO" = min("UBOUND", max("LBOUND", beta dot "SRTT"))$, $beta approx 1,3$–$2$.
- *Algoritmo de Jacobson* (estima también la variación):
  $ "SERR" = "RTT" - "SRTT" quad "SRTT" <- "SRTT" + g dot "SERR" quad "SDEV" <- "SDEV" + h (|"SERR"| - "SDEV") $
  $ "RTO" = "SRTT" + f dot "SDEV", quad g = 1\/8, h = 1\/4, f = 4 $
- *Algoritmo de Karn*: no usar el RTT de segmentos retransmitidos (no se sabe a qué transmisión corresponde el ACK) y, ante una retransmisión, *duplicar el RTO* (retroceso exponencial binario) y mantenerlo hasta recibir el ACK de un segmento no retransmitido.
- *Retransmisión rápida*: 3 ACK duplicados indican un segmento perdido → se retransmite sin esperar el temporizador. *SACK* informa qué bloques llegaron fuera de orden.

=== Control de congestión

La ventana efectiva es $"awnd" = min("crédito", "cwnd")$, donde *cwnd* (ventana de congestión) la
controla el emisor según las pérdidas que observa (una pérdida se interpreta como congestión).

- *Arranque lento*: al abrir, cwnd = 1 segmento y *+1 por cada ACK* → se *duplica cada RTT* (crecimiento exponencial) hasta el umbral *ssthresh*.
- *Evitación de congestión*: por encima de ssthresh, *+1 segmento por RTT* (crecimiento lineal, aditivo).
- Ante *expiración del temporizador*: ssthresh = cwnd/2, cwnd = 1 y de nuevo arranque lento (*disminución multiplicativa*). Esto es *AIMD*.
- *Recuperación rápida* (TCP Reno): con 3 ACK duplicados, ssthresh = cwnd/2 y cwnd = ssthresh (+3), sin volver a 1.
- En los routers, *RED* (descarte aleatorio temprano) evita la sincronización de muchas conexiones que produce el descarte por cola llena; *ECN* marca en vez de descartar.

#fig("fig-20-13.png", [Arranque lento y evitación de congestión: tras la expiración en el RTT 4, cwnd vuelve a 1 y crece linealmente sobre el umbral.], fuente: "Stallings, Fig. 20.13, p. 716", ancho: 50%)

#ejemplo(titulo: "Traza de cwnd")[
  ssthresh inicial = 16 segmentos. RTT 0: cwnd = 1; RTT 1: 2; RTT 2: 4; RTT 3: 8; RTT 4: 16 (alcanza el
  umbral) → RTT 5: 17; RTT 6: 18; … Si en cwnd = 20 vence el temporizador: ssthresh = 10, cwnd = 1, y
  vuelve a crecer 1, 2, 4, 8, 10, 11, 12, … Con 3 ACK duplicados (Reno) en cambio: ssthresh = 10 y cwnd = 10.
]

#tabla(
  columns: (auto, 1fr, 1fr),
  [], [*UDP*], [*TCP*],
  [Conexión], [No], [Sí (tres pasos, cierre con FIN)],
  [Fiabilidad y orden], [No], [Sí: ACK acumulativos, retransmisión, números de secuencia],
  [Unidad], [Mensajes (preserva límites)], [Flujo de bytes],
  [Control de flujo / congestión], [No], [Ventana anunciada / cwnd],
  [Cabecera], [8 bytes], [20–60 bytes],
  [Usos], [DNS, DHCP, SNMP, TFTP, VoIP, video], [HTTP, SMTP, FTP, SSH, BGP],
)

== NAT y PAT (traducción de direcciones de red)

#ejemplo(titulo: "Idea")[
  Un dispositivo NAT se ubica entre la red de un sitio (con *direcciones privadas*, no encaminables) e
  Internet. Para los hosts del sitio es el *router por defecto*; para el ISP es *un único host* con una
  dirección global. En la salida *reemplaza la IP origen* (privada → global) y guarda la asociación en una
  *tabla de traducción*; en la entrada busca en la tabla y *reemplaza la IP destino* (global → privada). Es
  *transparente*: los hosts usan software TCP/IP estándar.
]

- *NAT estática* (1:1): cada privada tiene una pública fija; permite servidores internos accesibles desde afuera.
- *NAT dinámica*: se asigna una pública de un *grupo (pool)* mientras dura la comunicación.
- *NAPT / PAT* (_Port Address Translation_, "NAT con sobrecarga"): muchas privadas comparten *una* pública distinguiendo por *puerto*. Es la forma más usada (routers hogareños, Wi-Fi). La tabla guarda: *IP interna, puerto interno, IP externa, puerto externo, puerto NAT y protocolo* (TCP, UDP o ICMP). El *puerto NAT* se elige único para evitar conflictos cuando dos hosts internos usan el mismo puerto origen.

#ejemplo(titulo: "Tabla NAPT (Comer, Fig. 19.7) — G es la IP pública del NAT")[
  #tabla(columns: 6, align: center,
    [*IP interna*], [*Puerto int.*], [*IP externa*], [*Puerto ext.*], [*Puerto NAT*], [*Tipo*],
    [192.168.0.5], [38023], [128.10.19.20], [80], [41003], [tcp],
    [192.168.0.1], [41007], [128.10.19.20], [80], [41010], [tcp],
    [192.168.0.6], [56600], [207.200.75.200], [80], [41012], [tcp],
    [192.168.0.3], [38023], [128.210.1.5], [80], [41007], [tcp],
  )
  Salida: `(192.168.0.5, 38023) → (128.10.19.20, 80)` se envía como `(G, 41003) → (128.10.19.20, 80)`.
  Respuesta: llega a `(G, 41003)`; el NAT busca la entrada (IP externa, puerto NAT, tipo) y la reenvía a
  `(192.168.0.5, 38023)`. Dos hosts usan el puerto 38023 sin conflicto porque reciben puertos NAT distintos.
]

*Creación de entradas*: (1) *manual* (mapeos permanentes: "reenvío de puertos" para alojar servidores),
(2) por *datagramas salientes* (lo habitual: automático, pero nadie de afuera puede iniciar la
comunicación) o (3) por *consultas DNS entrantes*. Variantes: NAT simétrica, de cono completo, restringida
por dirección o por puerto (afectan qué tráfico entrante se acepta por un puerto ya abierto).

*Complicaciones*:

- Hay que *recalcular sumas de comprobación* de IP y de TCP/UDP (la pseudocabecera incluye las direcciones).
- *ICMP*: los mensajes de error contienen la cabecera del datagrama original, que también debe traducirse (y recalcular sus sumas); el eco usa el identificador como "puerto".
- *Aplicaciones que envían direcciones o puertos como datos* (FTP activo con PORT, SIP) no funcionan salvo que el NAT tenga una pasarela de aplicación (ALG) que reescriba el contenido (y ajuste números de secuencia si cambia la longitud); alternativa: FTP *pasivo*.
- *Fragmentación*: solo el primer fragmento lleva los puertos; NAPT debe reensamblar o descartar fragmentos.
- Rompe el principio extremo a extremo y dificulta servidores internos y P2P (técnicas de atravesamiento: STUN, TURN). Ventajas: ahorra direcciones IPv4, oculta la red interna (cierta seguridad), permite cambiar de ISP sin renumerar. Puede haber dos niveles (NAT del cliente y *CGNAT* del ISP, `100.64.0.0/10`).

#extra[
  El mismo capítulo de Comer presenta las *VPN*: redes privadas virtuales que unen sitios (o un host
  remoto) a través de Internet mediante *túneles* (encapsulado IP en IP) con *cifrado*, de modo que el
  tráfico entre sitios viaja confidencialmente y puede usar direcciones privadas; y las *redes
  superpuestas* (_overlays_), que construyen una topología virtual sobre Internet.
]

== Guía de cuestiones de repaso (Stallings Cap. 20)

#pr("20.1")[Elementos de dirección de un usuario TS destino.][Dirección del host (IP) e identificador del usuario dentro del host (puerto); y el protocolo de transporte (TCP/UDP).]
#pr("20.2")[Cuatro formas de conocer la dirección del destino.][Conocerla de antemano (configuración), usar una dirección *bien conocida* (puerto estándar), consultar un *servidor de nombres/directorio* (DNS, portmapper) o que el destino se cree a pedido (un proceso generado al recibir la solicitud que informa su dirección).]
#pr("20.3")[Multiplexación en transporte.][Varios usuarios de transporte (puertos) comparten una misma conexión/servicio de red (multiplexación hacia arriba), o una conexión de transporte usa varias conexiones de red (hacia abajo) para más rendimiento.]
#pr("20.4")[Esquema de créditos de TCP.][Cada ACK lleva el número del próximo byte esperado ($A$) y un crédito ($W$): el emisor puede enviar los bytes $A$ a $A + W - 1$. Cada byte está numerado.]
#pr("20.5")[Diferencia con la ventana deslizante de HDLC.][En TCP confirmación y crédito están desacoplados (se puede confirmar sin conceder más crédito, o conceder más sin nuevos datos) y la ventana es variable y en bytes; en HDLC la confirmación de una trama implica automáticamente que la ventana se desplaza (tamaño fijo, en tramas).]
#pr("20.6")[Diálogos en dos y tres pasos.][Dos pasos: SYN y respuesta SYN; falla si llegan SYN o datos obsoletos de conexiones viejas. Tres pasos: cada lado confirma explícitamente el SYN (y número inicial) del otro, con lo que se detectan y rechazan SYN duplicados.]
#pr("20.7")[Beneficio del diálogo en tres pasos.][Ambos extremos acuerdan los números de secuencia iniciales y se evita abrir conexiones a partir de segmentos duplicados retrasados.]
#pr("20.8")[Urgente y forzado (push).][Push: la aplicación pide que los datos se envíen y entreguen ya, sin esperar a llenar buffers. Urgente: marca datos que el receptor debe procesar con prioridad (puntero urgente), p. ej. una interrupción.]
#pr("20.9")[Opciones de implementación de TCP.][Aspectos que el estándar deja al implementador: criterio de envío (cuándo armar un segmento), de entrega, de aceptación (en orden o en ventana), de retransmisión (primero solo, en lote o individual) y de confirmación (inmediata o acumulada/retardada).]
#pr("20.10")[¿Cómo trata TCP la congestión?][Con la ventana de congestión: arranque lento, evitación de congestión (crecimiento lineal), reducción multiplicativa ante pérdidas, retroceso exponencial del RTO y estimación dinámica del RTT (Jacobson, Karn).]
#pr("20.11")[¿Qué aporta UDP sobre IP?][Puertos para entregar a procesos y una suma de comprobación que cubre los datos.]

== Guía de ejercicios (Stallings Cap. 20 y Comer Caps. 10, 11 y 19)

#pr("20.1")[Una sola conexión de control para todas las conexiones.][Ahorra recursos y simplifica la señalización, pero agrega un punto único de falla, demoras si esa conexión se congestiona y complejidad para asociar las señales a cada conexión de usuario.]
#pr("20.2")[Control de flujo por contrapresión.][Depende del control de flujo de la capa inferior: es tosco (frena todas las conexiones que comparten el camino) y lento, y no sirve si la red no lo provee.]
#pr("20.3")[Crédito de 7 segmentos, transmisión 1, propagación 3, entrega 2.][El cuello de botella es la entrega al usuario: el receptor libera crédito a un segmento cada 2 unidades de tiempo, así que el rendimiento máximo es 0,5 segmentos por unidad de tiempo (el crédito de 7 alcanza para cubrir los 1 + 3 + 2 + 3 de demora de ida y vuelta).]
#pr("20.5")[¿Hacen falta números de secuencia con red fiable y ordenada?][Estrictamente no para ordenar, pero se pierde la posibilidad de confirmar y conceder créditos con referencia precisa y de detectar duplicados si la red falla o se reinicia.]
#pr("20.9")[Paquete de 128 bytes, vida máxima 30 s, secuencia de 8 bits.][No pueden emitirse más de 256 paquetes en 30 s sin reutilizar números: $256 times 128 times 8 \/ 30 approx 8,7$ kbps por conexión.]
#pr("20.10")[¿Bloqueo con diálogo en dos pasos?][Sí: si se pierde o se duplica un SYN, un lado puede quedar esperando datos que el otro cree que no corresponde enviar (o aceptar una conexión obsoleta); el diálogo en tres pasos lo evita.]
#pr("20.12")[Créditos perdidos o desordenados.][Como el crédito es absoluto (rango $A$ a $A + W - 1$) y no incremental, un ACK posterior lo reemplaza; un crédito viejo que llega tarde no debe achicar la ventana (se ignoran ACK con número menor al último recibido).]
#pr("20.14")[¿Por qué esperar en TIME-WAIT?][Porque el último ACK puede perderse y el otro extremo retransmitirá su FIN; además hay que dejar morir los segmentos viejos de la conexión antes de reutilizar la misma 4-tupla.]
#pr("20.15")[¿Por qué el escalado de ventana se limita a 14?][La ventana máxima es $2^16 times 2^14 = 2^30$ bytes, menor que la mitad del espacio de secuencia de 32 bits ($2^31$), necesario para distinguir datos nuevos de viejos.]
#pr("20.16")[Convergencia de SRTT con $alpha = 0,85$.][$"SRTT"(n) = alpha^n "SRTT"(0) + (1 - alpha^n) "RTT"$. (a) $1 + 2 times 0,85^19 approx 1,09$ s. (b) $3 - 2 times 0,85^19 approx 2,91$ s: tras 19 muestras aún no converge del todo.]
#pr("20.17–18")[Síndrome de la ventana tonta.][Los segmentos de 50 y 150 octetos se perpetúan: el emisor llena cada hueco de ventana con segmentos chicos y el rendimiento cae. Receptor: no anunciar aumentos menores que $min("MSS", "buffer"\/2)$ ("mentir" anunciando 0). Emisor: Nagle, enviar solo segmentos completos o cuando todo lo anterior esté confirmado.]
#pr("20.19")[SRTT en función de SERR.][$"SRTT"(K+1) = "SRTT"(K) + g dot "SERR"(K+1)$: la estimación se corrige una fracción $g$ del error de predicción.]
#pr("20.20")[RTT necesarios para enviar N segmentos con arranque lento.][La ventana se duplica cada RTT (1, 2, 4, …): en $k$ RTT se envían $2^k - 1$ segmentos → unos $log_2 N$ RTT.]
#pr("20.21")[1 Gbps, RTT 60 ms, segmentos de 576 bytes.][(a) Ventana = $10^9 times 0,06 \/ 8 = 7,5$ MB ≈ 13 021 segmentos. Tras una expiración: ssthresh ≈ 6510, arranque lento ≈ 13 RTT y luego +1 por RTT ≈ 6510 RTT → ≈ 6523 RTT ≈ 391 s. (b) Con 16 KB (≈ 28 segmentos): ≈ 4 + 14 = 18 RTT ≈ 1,1 s.]
#pr("C10.2")[¿Por qué la suma de UDP está separada de la de IP?][IP solo protege su cabecera (la recalculan los routers); UDP protege extremo a extremo los datos y la pseudocabecera. Una única suma para todo obligaría a los routers a recorrer los datos.]
#pr("C10.5")[Puertos UDP preasignados.][Ventaja: los clientes saben dónde encontrar el servicio sin consultar. Desventaja: se gasta el espacio de puertos y fija la ubicación de cada servicio.]
#pr("C11.4")[¿Por qué un ACK perdido no fuerza retransmisión?][Las confirmaciones son acumulativas: un ACK posterior confirma también lo anterior antes de que venza el temporizador.]
#pr("C11.9")[Un carácter por segmento.][Datos útiles: 1 de 41 bytes con IPv4 (20 + 20 + 1) ≈ 2,4 %; 1 de 61 con IPv6 ≈ 1,6 % (sin contar la trama).]
#pr("C11.10")[ISN = 1 siempre.][Tras una caída y reinicio, la nueva conexión con la misma 4-tupla usaría los mismos números que la anterior: segmentos viejos o el otro extremo podrían interpretarse como parte de la conexión vieja aún abierta.]
#pr("NAT")[¿Por qué falla FTP activo a través de NAT?][Porque el cliente envía su IP privada y un puerto dentro de los datos (orden PORT) y el servidor intenta conectarse a esa dirección; el NAT debe reescribir el contenido (ALG) o usarse FTP pasivo, donde el cliente inicia ambas conexiones.]
