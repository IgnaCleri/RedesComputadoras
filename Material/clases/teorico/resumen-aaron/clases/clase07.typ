#import "../lib.typ": *

= Clase 7 (21/9) — Capa de interred: direccionamiento IP, ICMP, ARP y BOOTP

#lectura[
  [COM] *Cap. 7* "Internet Protocol: Connectionless Datagram Delivery (IPv4, IPv6)". Para el
  direccionamiento (IPv4, IPv6, subredes, VLSM, CIDR) se usa [COM] Cap. 5; para ARP, Cap. 6; para ICMP,
  Cap. 9; para BOOTP, Cap. 22. Complementaria: [KR] Cap. 4. Las figuras son de [STA] Cap. 18, cuyas
  cuestiones y ejercicios se responden al final.
]

== Servicio de IP: entrega de datagramas sin conexión

Internet ofrece la abstracción de *una única red virtual* que une a todos los hosts; la arquitectura
física queda oculta. Tres niveles conceptuales de servicio: *entrega de paquetes sin conexión* (IP),
*transporte fiable* (TCP) y *aplicaciones*. La fiabilidad se construye *encima* de una base no fiable,
que encaja con lo que ofrece cualquier hardware de red.

#clave[
  IP ofrece un servicio *no fiable* (los paquetes pueden perderse, duplicarse, retrasarse o llegar
  desordenados, y IP no lo detecta ni avisa), *sin conexión* (cada datagrama se trata en forma
  independiente y puede seguir otro camino) y de *mejor esfuerzo* (solo descarta si se agotan recursos
  o fallan las redes). IP define (1) el formato del *datagrama*, (2) la función de *reenvío* y (3) las
  reglas de procesamiento, generación de errores y descarte.
]

== El datagrama IPv4

#fig("fig-18-6.png", [Cabecera IPv4 (20 bytes sin opciones).], fuente: "Stallings, Fig. 18.6, p. 610", ancho: 60%)

#tabla(
  columns: (auto, auto, 1fr),
  [*Campo*], [*Bits*], [*Significado*],
  [Versión], [4], [4 para IPv4. Todo software IP la verifica antes de procesar.],
  [HLEN (IHL)], [4], [Longitud de la cabecera en *palabras de 32 bits*: 5 sin opciones (20 bytes), máximo 15 (60 bytes).],
  [Tipo de servicio / DS], [8], [Hoy *DiffServ*: 6 bits de código (DSCP, 64 valores; `xxx000` = antigua precedencia) + 2 bits (usados por ECN). Es una sugerencia, no garantía.],
  [Longitud total], [16], [Datagrama completo (cabecera + datos) en bytes; máximo 65 535. Datos = longitud total − 4 × HLEN.],
  [Identificación], [16], [Número único por datagrama del origen; se copia en todos sus fragmentos.],
  [Indicadores (flags)], [3], [Reservado · *DF* (no fragmentar) · *MF* (más fragmentos).],
  [Desplazamiento], [13], [Posición de los datos del fragmento en el datagrama original, en *unidades de 8 bytes*.],
  [Tiempo de vida (TTL)], [8], [Cada router lo decrementa en 1; al llegar a 0 se descarta y se envía ICMP "tiempo excedido". Evita bucles.],
  [Protocolo], [8], [Qué lleva la carga: 1 = ICMP, 2 = IGMP, 6 = TCP, 17 = UDP, 89 = OSPF.],
  [Suma de comprobación], [16], [Solo de la *cabecera*: complemento a uno de la suma en complemento a uno de las palabras de 16 bits (con el campo en 0). Se recalcula en cada router (cambia el TTL).],
  [Direcciones origen/destino], [32 + 32], [Origen *original* y destino *final*; no cambian en el camino (salvo opciones de ruta en origen o NAT).],
  [Opciones + relleno], [var.], [Registro de ruta (7), ruta estricta (9) o libre (3) en origen, marca de tiempo (4), etc.; relleno hasta múltiplo de 32 bits.],
)

La suma de comprobación cubre solo la cabecera: los routers procesan menos y cada protocolo superior
elige su propia verificación (pero está obligado a tenerla). Los enteros de cabecera viajan en *orden de
red = big endian* (byte más significativo primero).

== Encapsulado, MTU y fragmentación

Cada datagrama viaja en el campo de datos de una trama (Ethernet: tipo 0x0800 para IPv4, 0x86DD para
IPv6). Cada tecnología limita los datos por trama: *MTU* (Ethernet 1500 bytes). *MTU del camino* = mínimo
de las MTU de las redes del camino.

- *IPv4*: fragmenta *cualquier router* que lo necesite (y los fragmentos pueden volver a fragmentarse). Cada fragmento tiene la misma estructura que un datagrama: se copia la cabecera y se ajustan longitud total, MF y desplazamiento. Los datos de cada fragmento (salvo el último) deben ser *múltiplo de 8 bytes*.
- *Reensamblado solo en el destino final* (los routers no guardan estado). Se agrupan por (origen, identificación); con el desplazamiento y el bit MF del último se sabe cuándo están todos. Hay un *temporizador de reensamblado*: si expira se descartan todos los fragmentos. *Perder un fragmento = perder el datagrama.*
- Si DF = 1 y hace falta fragmentar → se descarta y se envía ICMP "fragmentación necesaria".
- Opciones: las que procesan los routers (rutas en origen) se copian en todos los fragmentos; las del destino (registro de ruta) solo en el primero (bit de copia del código de opción).
- *IPv6*: los routers *no fragmentan*; el *origen* averigua la MTU del camino (*PMTUD*: envía, recibe ICMPv6 "paquete demasiado grande" y achica) y fragmenta con una *cabecera de extensión de fragmento*.

#fig("fig-18-5.png", [Ejemplo de fragmentación de un datagrama de 404 bytes de datos.], fuente: "Stallings, Fig. 18.5, p. 607", ancho: 50%)

#ejemplo(titulo: "Fragmentación paso a paso (ejercicio 18.5 de Stallings)")[
  Datagrama de 4480 bytes (20 de cabecera + 4460 de datos) que pasa por una red con MTU 1500. Datos por
  fragmento: $1500 - 20 = 1480$ (múltiplo de 8: 185 × 8). Se necesitan $ceil(4460 \/ 1480) = 4$ fragmentos.
  #tabla(columns: 5, align: center,
    [*Fragmento*], [*Datos*], [*Longitud total*], [*MF*], [*Desplazamiento*],
    [1], [1480], [1500], [1], [0],
    [2], [1480], [1500], [1], [185],
    [3], [1480], [1500], [1], [370],
    [4], [20], [40], [0], [555],
  )
  Desplazamiento = byte de inicio / 8 (0, 1480, 2960, 4440 bytes).
]

== Direccionamiento IPv4

Una dirección IP identifica una *conexión a una red* (interfaz), no un equipo: un router con $n$ interfaces
tiene $n$ direcciones. Conceptualmente es un par (prefijo de red, sufijo de host). Notación *decimal con
puntos*: 4 octetos (`128.10.2.30`).

=== Direccionamiento con clases (histórico)

#fig("fig-18-7.png", [Formatos de dirección IPv4 con clases.], fuente: "Stallings, Fig. 18.7, p. 612", ancho: 55%)

#tabla(
  columns: (auto, auto, auto, auto, 1fr),
  [*Clase*], [*Bits iniciales*], [*Rango primer octeto*], [*Red / host*], [*Máscara por defecto*],
  [A], [0], [1–126 (127 = loopback)], [8 / 24], [255.0.0.0 (/8)],
  [B], [10], [128–191], [16 / 16], [255.255.0.0 (/16)],
  [C], [110], [192–223], [24 / 8], [255.255.255.0 (/24)],
  [D], [1110], [224–239], [multidifusión], [—],
  [E], [1111], [240–255], [reservada], [—],
)

=== Subredes y máscaras

Una organización divide la parte local (host) en *subred + host*; afuera se ve una sola red. La *máscara de
subred* tiene 1 en los bits de red+subred y 0 en los de host; se escribe en decimal (255.255.255.192) o en
*notación barra* (/26). Para un prefijo de longitud $n$:

$ "direcciones del bloque" = 2^(32 - n) quad quad "hosts utilizables" = 2^(32 - n) - 2 $

(se reservan la *dirección de red*, host todo 0, y la de *difusión dirigida*, host todo 1; un /31 se usa en
enlaces punto a punto y un /32 es un host).

#ejemplo(titulo: "Calcular red, difusión y rango de hosts")[
  Host `192.168.10.77/26`. Máscara 255.255.255.192 → tamaño de bloque $256 - 192 = 64$ en el último
  octeto. 77 cae en el bloque que empieza en 64: *red* `192.168.10.64`, *difusión* `192.168.10.127`,
  hosts `.65` a `.126` (62 hosts). En binario: dirección AND máscara = red.
]

*Subredes de longitud fija*: todas las subredes con la misma máscara. Tomar $s$ bits de host da $2^s$
subredes (Comer muestra la regla antigua $2^s - 2$, que excluía la subred toda 0 y toda 1). Ejemplo:
`172.16.0.0/16` en 8 subredes → 3 bits → /19 (bloques de 32 en el tercer octeto: 172.16.0.0, .32.0, .64.0, …),
8190 hosts cada una.

=== VLSM (máscaras de longitud variable)

Cada subred elige su propia máscara según su tamaño, para aprovechar mejor el espacio. Hay que asignar con
cuidado para que no se *solapen* (ambigüedad). Procedimiento: ordenar las subredes de *mayor a menor*,
asignar a cada una el bloque potencia de 2 más chico que alcance (hosts + 2) alineado a su tamaño, y
seguir con la siguiente dirección libre.

#ejemplo(titulo: "Diseño VLSM")[
  Con `192.168.1.0/24`: LAN A 100 hosts, LAN B 50, LAN C 20 y dos enlaces punto a punto.
  #tabla(columns: 5, align: center,
    [*Subred*], [*Necesita*], [*Prefijo*], [*Red*], [*Hosts / difusión*],
    [A], [100 + 2], [/25 (128)], [192.168.1.0], [.1–.126 / .127],
    [B], [50 + 2], [/26 (64)], [192.168.1.128], [.129–.190 / .191],
    [C], [20 + 2], [/27 (32)], [192.168.1.192], [.193–.222 / .223],
    [Enlace 1], [2 + 2], [/30 (4)], [192.168.1.224], [.225–.226 / .227],
    [Enlace 2], [2 + 2], [/30 (4)], [192.168.1.228], [.229–.230 / .231],
  )
  Queda libre `192.168.1.232/29` y siguientes para crecer.
]

=== CIDR (direccionamiento sin clases)

Desde 1993, para frenar el agotamiento de direcciones: el prefijo puede tener *cualquier longitud*; se
eliminan las clases (salvo la D) y la máscara se conoce globalmente. Notación `dirección/n`. Cada ISP recibe
un bloque y lo reparte en sub-bloques potencia de 2 alineados.

- *Agregación / superredes*: varias redes contiguas se anuncian como un único prefijo. Ej.: `200.10.0.0/24` … `200.10.3.0/24` → `200.10.0.0/22`. Reduce el tamaño de las tablas de los routers.
- *Coincidencia del prefijo más largo*: si varias entradas coinciden con el destino, se usa la de prefijo más largo (más específica).
- Ejemplo de Comer: `128.211.168.0/21` = 2048 direcciones (128.211.168.0 a 128.211.175.255).

=== Direcciones especiales y privadas

#tabla(
  columns: (auto, 1fr),
  [*Dirección*], [*Uso*],
  [`0.0.0.0`], [Origen provisorio al arrancar (aún sin IP). También "ruta por defecto" 0.0.0.0/0.],
  [`255.255.255.255`], [Difusión limitada a la red local (no la reenvían los routers).],
  [red + host todo 1], [Difusión dirigida a una red/subred (muchos routers la bloquean).],
  [red + host todo 0], [Identifica a la red.],
  [`127.0.0.0/8`], [Loopback (127.0.0.1): nunca sale del equipo.],
  [`224.0.0.0/4`], [Multidifusión (ex clase D).],
  [`10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`], [*Privadas* (RFC 1918): no se encaminan en Internet; requieren NAT (Clase 9).],
  [`169.254.0.0/16`], [Enlace local (autoconfiguración cuando no hay DHCP).],
)

#fig("fig-18-8.png", [Ejemplo de uso de subredes: una red de clase B dividida en tres LAN.], fuente: "Stallings, Fig. 18.8, p. 613", ancho: 50%)

== IPv6

Motivo principal: el *agotamiento de IPv4*; además simplificar la cabecera, mejorar opciones, flujos (QoS) y seguridad.

#fig("fig-18-11.png", [Cabecera base IPv6 (40 bytes fijos).], fuente: "Stallings, Fig. 18.11, p. 621", ancho: 55%)

- *Cabecera base fija de 40 bytes* (alineada a 64 bits): versión (6) · *clase de tráfico* (8, igual que DS) · *etiqueta de flujo* (20, identifica un flujo para tratamiento especial; 0 = sin flujo) · *longitud de la carga útil* (16, sin la cabecera base) · *cabecera siguiente* (8) · *límite de saltos* (8, = TTL) · origen y destino de *128 bits*.
- Se eliminaron: HLEN, suma de comprobación de cabecera (la hacen enlace y transporte), campos de fragmentación (pasan a una extensión) y opciones (pasan a extensiones).
- *Cabeceras de extensión* encadenadas por el campo *cabecera siguiente* (que en la última indica el protocolo de la carga: 6 TCP, 17 UDP, 58 ICMPv6). Orden recomendado: opciones *salto a salto* (0, la procesa cada router, por eso va primera) · opciones de destino (60, para los destinos de la ruta) · *encaminamiento* (43) · *fragmento* (44) · *autenticación* (51) · *ESP* (50, cifrado) · opciones de destino final (60).

#fig("fig-18-10.png", [Paquete IPv6 con cabeceras de extensión.], fuente: "Stallings, Fig. 18.10, p. 620", ancho: 45%)

*Direcciones IPv6* (128 bits): notación *hexadecimal con dos puntos* en 8 grupos de 16 bits; se omiten ceros
a la izquierda de cada grupo y *una* secuencia de grupos en cero se reemplaza por `::` (ej.
`FF05:0:0:0:0:0:0:B3` = `FF05::B3`). Prefijos con barra igual que CIDR.

- *Unidifusión* (un interfaz): global `2000::/3` = prefijo global de encaminamiento + ID de subred (en total normalmente /64) + *ID de interfaz de 64 bits* (de la MAC por *EUI-64*: se inserta `FFFE` en el medio y se invierte el bit U/L, o aleatorio); *enlace local* `FE80::/10` (siempre presente, no se encamina); únicas locales `FC00::/7` (equivalentes a las privadas); loopback `::1`; no especificada `::`.
- *Multidifusión* `FF00::/8` (reemplaza a la difusión, que *no existe* en IPv6): todos los nodos `FF02::1`, todos los routers `FF02::2`.
- *Anycast* (cualquiera de un grupo): se entrega al miembro *más cercano* según el encaminamiento.
- Transición: direcciones IPv4 embebidas (`::FFFF:a.b.c.d`), doble pila, túneles y traducción (NAT64).

#tabla(
  columns: (auto, 1fr, 1fr),
  [], [*IPv4*], [*IPv6*],
  [Dirección], [32 bits, decimal con puntos], [128 bits, hexadecimal con `:`],
  [Cabecera], [20–60 bytes, con opciones y suma de comprobación], [40 bytes fijos + extensiones, sin suma],
  [Fragmentación], [Origen y routers], [Solo el origen (PMTUD)],
  [Difusión], [Sí], [No (multidifusión)],
  [Resolución de direcciones], [ARP], [NDP (ICMPv6)],
  [Configuración], [Manual o DHCP], [SLAAC (autoconfiguración sin estado) o DHCPv6],
)

== ICMP (protocolo de mensajes de control de Internet)

Parte obligatoria de IP para *informar errores* y enviar *información de control*. Los mensajes viajan
*dentro de un datagrama IP* (protocolo 1; ICMPv6 = cabecera siguiente 58) y siempre van al *origen original*
(el único conocido). ICMP *informa*, no corrige. Formato: *tipo* (8 bits) · *código* (8) · *suma de
comprobación* (16) · resto según el tipo; los de error incluyen la cabecera IP y los primeros 8 bytes de
datos del datagrama que lo causó. No se generan errores sobre errores ICMP, fragmentos no iniciales ni
difusiones.

#tabla(
  columns: (auto, 1fr),
  [*Tipo (ICMPv4)*], [*Mensaje*],
  [0 / 8], [Respuesta / solicitud de eco (*ping*).],
  [3], [Destino inalcanzable: código 0 red, 1 host, 2 protocolo, 3 *puerto*, 4 *fragmentación necesaria y DF activado* (usado en PMTUD).],
  [5], [Redirección: el router avisa al host que use otro primer salto mejor en la misma red.],
  [11], [Tiempo excedido: código 0 TTL = 0 en tránsito (usado por *traceroute*), 1 tiempo de reensamblado agotado.],
  [12], [Problema de parámetro en la cabecera.],
  [13/14, 17/18], [Marca de tiempo, máscara de dirección (obsoletos).],
)

*traceroute* envía datagramas con TTL = 1, 2, 3, …; cada router donde el TTL llega a 0 responde "tiempo
excedido" y revela su dirección; el destino responde "puerto inalcanzable" (o eco). En ICMPv6 se agregan
"paquete demasiado grande" (2) y los mensajes de *descubrimiento de vecinos* (NDP: solicitud/anuncio de
router 133/134, solicitud/anuncio de vecino 135/136, redirección 137).

#fig("fig-18-9.png", [Formatos de mensajes ICMP.], fuente: "Stallings, Fig. 18.9, p. 615", ancho: 60%)

== ARP (protocolo de resolución de direcciones)

Para enviar un datagrama por una red física hace falta la *dirección de hardware* del siguiente salto
(el destino si está en la misma red, o el router). ARP traduce *IPv4 → MAC* dinámicamente, sin base de
datos central.

+ El emisor busca en su *caché ARP*. Si no está, *difunde* una *solicitud ARP* (trama a FF:FF:FF:FF:FF:FF, tipo Ethernet 0x0806) con su IP y MAC y la *IP buscada*.
+ Todos la reciben; solo el dueño de esa IP responde con una *respuesta ARP unidifusión* con su MAC.
+ Ambos guardan la asociación en caché (con tiempo de expiración, típicamente minutos). Los que reciben la solicitud pueden actualizar la entrada del emisor si ya la tenían.

Mensaje ARP: tipo de hardware (1 = Ethernet), tipo de protocolo (0x0800), longitudes (6 y 4), operación (1
solicitud, 2 respuesta), MAC e IP del emisor, MAC e IP del destino. Variantes: *ARP gratuito* (anunciar la
propia IP / detectar duplicados), *proxy ARP* (un router responde por hosts de otra red), *RARP* (MAC → IP,
reemplazado por BOOTP/DHCP). ARP no tiene autenticación: es vulnerable a *envenenamiento de caché*. En IPv6
lo reemplaza *NDP*.

== BOOTP (protocolo de arranque)

Permite que un equipo *sin dirección* obtenga su configuración al iniciar. Reemplazó a RARP y es la base de
DHCP (Clase 10).

- Usa *UDP*: el servidor escucha en el *puerto 67* y el cliente en el *68*. El cliente difunde (destino `255.255.255.255`, origen `0.0.0.0`) una solicitud con su MAC; el servidor responde con *su dirección IP*, la IP del servidor, el router por defecto, máscara y el *nombre del archivo de arranque* (que luego se descarga con TFTP).
- Asignación *estática*: el servidor tiene una tabla MAC → IP configurada a mano (DHCP agrega asignación dinámica con *arrendamientos*).
- Si cliente y servidor están en redes distintas, un *agente de retransmisión* (relay) en el router reenvía la solicitud. Retransmite con temporizador aleatorio si no hay respuesta (UDP no es fiable).

== Guía de cuestiones de repaso (Stallings Cap. 18)

#pr("18.1")[Razones para fragmentar y reensamblar.][Las redes tienen distintas MTU; tramas cortas detectan y corrigen errores con menos retransmisión, permiten un acceso más equitativo al medio y requieren menos memoria en los nodos; las aplicaciones pueden querer enviar bloques grandes.]
#pr("18.2")[Requisitos de la interconexión de redes.][Enlace entre redes, encaminamiento y entrega entre procesos de distintas redes, contabilidad y estado, sin modificar las redes existentes; acomodar distintos direccionamientos, tamaños de paquete, mecanismos de acceso, temporizadores, recuperación de errores, informes de estado, encaminamiento, servicios con y sin conexión.]
#pr("18.3")[Reensamblar solo en el destino.][Pros: los routers no guardan estado ni memoria, los fragmentos pueden tomar caminos distintos y es simple. Contras: los fragmentos pequeños viajan por todas las redes (más sobrecarga) y perder uno obliga a retransmitir todo el datagrama.]
#pr("18.4")[Tres indicadores IPv4.][Reservado (0), DF = no fragmentar (si hace falta, se descarta y se avisa por ICMP) y MF = más fragmentos (1 en todos menos el último).]
#pr("18.5")[Cálculo de la suma de comprobación.][Se pone el campo en 0, se suman en complemento a uno todas las palabras de 16 bits de la cabecera y se guarda el complemento a uno del resultado. El receptor suma todo (incluido el campo): debe dar todo 1.]
#pr("18.6")[Clase de tráfico vs etiqueta de flujo.][La clase de tráfico marca la prioridad o clase de servicio de *cada paquete* (DiffServ); la etiqueta de flujo identifica una *secuencia de paquetes* relacionados que los routers pueden tratar de forma especial (reservas, mismo camino).]
#pr("18.7")[Tres tipos de direcciones IPv6.][Unidifusión (un interfaz), anycast (un grupo de interfaces; se entrega al más cercano) y multidifusión (todos los del grupo).]
#pr("18.8")[Propósito de las cabeceras IPv6.][Base (direcciones y datos esenciales), salto a salto (opciones para cada router, ej. jumbogramas, alerta de router), encaminamiento (lista de nodos a visitar), fragmento (identificación, desplazamiento, M), autenticación (integridad y autenticidad), ESP (confidencialidad) y opciones de destino (para el destino).]

== Guía de ejercicios (Stallings Cap. 18 y Comer Cap. 7)

#pr("18.1")[¿Quién usa identificador, DF y TTL?][Identificador: lo asigna el IP de origen y lo usan routers (al fragmentar) y destino (reensamblado). DF: lo pone el origen y lo respetan los routers. TTL: lo pone el origen y lo decrementa cada router; el destino no lo necesita entregar.]
#pr("18.2")[Información suplementaria de la cabecera IP.][20 bytes mínimo (hasta 60 con opciones) por datagrama, más la de cada fragmento.]
#pr("18.3")[¿Cuándo usar ruta en el origen?][Pruebas y depuración (forzar un camino), seguridad (evitar redes no confiables), política o costo, o cuando los routers no conocen una ruta.]
#pr("18.4")[Algoritmo de reensamblado.][Buffer del tamaño máximo con una *lista de agujeros* (inicio, fin), inicialmente uno de 0 a ∞. Cada fragmento llena parte de un agujero y lo parte en hasta dos; el último fragmento (MF = 0) fija el final. Termina cuando la lista queda vacía. La lista puede guardarse dentro de los propios agujeros del buffer.]
#pr("18.5")[Fragmentar 4480 bytes con MTU 1500.][Ver ejemplo resuelto: longitudes 1500, 1500, 1500, 40; MF 1, 1, 1, 0; desplazamientos 0, 185, 370, 555.]
#pr("18.6")[Recalcular la suma sin empezar de cero.][Actualización incremental: si una palabra cambia de $m$ a $m'$, nueva suma `HC' = ~(~HC + ~m + m')` en complemento a uno (RFC 1624); al bajar el TTL en 1 basta sumar 0x0100 al campo con acarreo circular.]
#pr("18.7")[Opciones en fragmentos.][Se copian en todos las que afectan el reenvío (rutas estricta y libre, seguridad); solo en el primero las de registro de ruta y marca de tiempo (basta una copia y los fragmentos pueden ir por caminos distintos).]
#pr("18.8")[1500 bits de datos + 160 TCP + 160 IP por dos redes (24 bits de cabecera), destino con paquete máximo de 800 bits.][Datos IP por fragmento ≤ 800 − 24 − 160 = 616 bits: los 1660 bits de carga se dividen en 3 fragmentos. Bits entregados = 1660 + 3 × 160 + 3 × 24 = *2212 bits*.]
#pr("18.10")[¿Relación entre interconexión y encaminamiento interno?][Conviene que sean independientes (IP no debe depender de cómo encamina internamente cada red), aunque compartir información de estado puede mejorar las decisiones.]
#pr("18.11")[Comparar cabeceras IPv4 e IPv6.][Versión = versión; tipo de servicio → clase de tráfico; longitud total → longitud de carga útil; identificación, flags y desplazamiento → cabecera de fragmento; TTL → límite de saltos; protocolo → cabecera siguiente; suma de comprobación → eliminada; direcciones de 32 → 128 bits; opciones → extensiones; nuevo: etiqueta de flujo.]
#pr("18.12")[Orden de las extensiones.][Salto a salto primero porque la examinan todos los routers; encaminamiento antes de fragmento porque los nodos intermedios la necesitan y la parte no fragmentable debe ir en cada fragmento; autenticación y ESP después porque cubren lo que sigue y se verifican en el destino.]
#pr("C7.1")[Ventaja/desventaja de que la suma cubra solo la cabecera.][Menos procesamiento en routers; pero los protocolos superiores deben verificar sus datos o un error en la carga pasa inadvertido.]
#pr("C7.10")[MTU mínima para un datagrama con 1 byte de datos.][IPv4: 21 bytes (20 + 1). IPv6: 41 bytes (40 + 1), aunque IPv6 exige MTU ≥ 1280.]
#pr("C7.12")[Trama Ethernet con un datagrama mínimo.][El datagrama mínimo (20 bytes) se rellena a 46 bytes de datos → trama de 64 bytes (más 8 de preámbulo/SFD).]
