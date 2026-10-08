#import "../lib.typ": *

= Clase 8 (28/9) — Encaminamiento interno y externo

#lectura[
  [COM] *Cap. 12* "Routing Architecture: Cores, Peers, And Algorithms", *Cap. 13* "Routing Among
  Autonomous Systems (BGP)" y *Cap. 14* "Routing Within An Autonomous System (RIP, RIPng, OSPF, IS-IS)".
  Complementaria: [KR] Cap. 5. *EIGRP* (propietario de Cisco) y el *enrutamiento entre VLAN* no están en
  Comer y se resumen de la documentación general. Figuras de [STA] Cap. 19 (sección 19.2), cuyas cuestiones
  sobre encaminamiento se responden al final.
]

== Reenvío vs encaminamiento

- *Reenvío (forwarding)*: acción local de cada router o host: mirar la dirección destino del datagrama, buscar en la *tabla de reenvío* y enviarlo al *siguiente salto*. *Entrega directa*: el destino está en una red a la que el equipo se conecta (se usa ARP y se envía la trama al destino). *Entrega indirecta*: se envía al router siguiente.
- La tabla tiene entradas (prefijo/máscara, siguiente salto, interfaz). Se elige la coincidencia con el *prefijo más largo*; si no hay ninguna se usa la *ruta por defecto* (`0.0.0.0/0`). El siguiente salto *no* va en el datagrama: solo determina la MAC destino de la trama.
- *Encaminamiento (routing)*: proceso, normalmente distribuido, que *construye* las tablas. Puede ser *estático* (rutas configuradas a mano: simple, sin sobrecarga, pero no se adapta a fallas; ideal para redes pequeñas o "stub" con una sola salida) o *dinámico* (protocolos que intercambian información y recalculan ante cambios).

#clave[
  Los hosts y la mayoría de los routers tienen *información parcial*: conocen sus redes y usan rutas por
  defecto hacia lo lejano. El diseño debe garantizar *reenvío globalmente consistente*: que todas las
  redes sean alcanzables y que no haya bucles. Históricamente Internet usó una *arquitectura de núcleo*
  (routers núcleo con información completa y el resto con rutas por defecto hacia ellos); hoy hay *redes
  troncales de ISP pares* (peers) interconectadas en muchos puntos.
]

== Algoritmos de encaminamiento

=== Vector distancia (Bellman-Ford distribuido)

Cada router mantiene una lista (destino, distancia, siguiente salto) y la *envía periódicamente a sus
vecinos*. Al recibir el vector del vecino $V$ (a costo $c(V)$), para cada destino $D$:
$ d(D) = min_V (c(V) + d_V (D)) $
y actualiza si la nueva distancia es menor, o si la ruta actual ya pasaba por $V$ (hay que creerle al
siguiente salto aunque empeore).

- Simple de implementar, poca memoria; pero cada router solo conoce lo que dicen sus vecinos ("encaminamiento por rumor"), los mensajes crecen con el número de redes y la *convergencia es lenta*.
- *Problema de la cuenta al infinito*: si cae una red, dos routers pueden anunciarse mutuamente una ruta vieja y subir la distancia de a poco (bucle temporal). Soluciones:
  - *Horizonte dividido* (_split horizon_): no anunciar una ruta por la interfaz por donde se aprendió.
  - *Envenenamiento en reversa* (_poison reverse_): anunciarla por esa interfaz pero con distancia infinita.
  - *Retención* (_hold down_): tras saber que una red es inalcanzable, ignorar nuevas rutas hacia ella durante un tiempo (60 s en RIP).
  - *Actualizaciones desencadenadas* (_triggered updates_): avisar de inmediato ante un cambio, sin esperar el periodo.
  - Un *infinito pequeño* (16 en RIP) acota la cuenta.

#ejemplo(titulo: "Actualización por vector distancia")[
  Enlaces: A–B (1), A–C (4), B–C (2), B–D (5), C–D (1). Tabla inicial de A: B 1 (B), C 4 (C).
  A recibe de B el vector {A 1, C 2, D 5}: vía B, C = 1 + 2 = 3 < 4 → *actualiza* C 3 (B); D = 1 + 5 = 6 →
  *agrega* D 6 (B). Cuando B aprende que D está a 3 (vía C) y lo anuncia, A pasa a D 4 (B). Así, con
  intercambios sucesivos, todos convergen a las distancias mínimas.
]

=== Estado de enlace (SPF, Dijkstra)

Cada router: (1) descubre a sus vecinos y prueba sus enlaces (mensajes *hello*); (2) *inunda* toda la red
con un *anuncio de estado de enlace* (LSA: "estoy conectado a X con costo c") numerado; (3) con todos los
anuncios arma el *mapa completo* (grafo) y (4) ejecuta *Dijkstra* (camino más corto primero, SPF) con él
mismo como raíz, obteniendo el árbol de caminos mínimos y de ahí su tabla.

- Cada router calcula *localmente* con la misma información → converge rápido y sin bucles de cuenta al infinito; los mensajes no dependen del número de redes sino de los enlaces de cada router.
- Requiere más memoria y CPU; adecuado para redes grandes o de topología cambiante.

#ejemplo(titulo: "Dijkstra desde A (mismo grafo)")[
  #tabla(columns: 5, align: center,
    [*Paso*], [*Conjunto definitivo*], [*B*], [*C*], [*D*],
    [0], [{A}], [*1 (A)*], [4 (A)], [∞],
    [1], [{A, B}], [—], [*3 (B)*], [6 (B)],
    [2], [{A, B, C}], [—], [—], [*4 (C)*],
    [3], [{A, B, C, D}], [—], [—], [—],
  )
  En cada paso se agrega el nodo no definitivo de menor distancia y se relajan sus vecinos. Tabla de A:
  B, C y D por el siguiente salto *B* (costos 1, 3 y 4).
]

#grid(columns: (1fr, 1fr), gutter: 8pt,
  fig("fig-19-8.png", [Grafo dirigido de un sistema autónomo (costos en cada arco).], fuente: "Stallings, Fig. 19.8, p. 653", ancho: 100%),
  fig("fig-19-9.png", [Árbol SPF calculado por el router R6.], fuente: "Stallings, Fig. 19.9, p. 654", ancho: 100%),
)

=== Vector de caminos

Variante del vector distancia que anuncia el *camino completo* (lista de sistemas autónomos) en vez de una
distancia: permite detectar bucles (si aparezco en el camino, lo descarto) y aplicar *políticas*. Lo usa BGP.

== Sistemas autónomos: IGP y EGP

Un *sistema autónomo (AS)* es un conjunto de redes y routers bajo una *única autoridad administrativa*
(ej. un ISP o una gran empresa), identificado por un número de AS (ASN). Dentro de un AS se usa un *protocolo
de pasarela interior (IGP)* que busca caminos óptimos (RIP, OSPF, IS-IS, EIGRP); entre AS, un *protocolo de
pasarela exterior (EGP)* orientado a *alcanzabilidad y políticas* (BGP). Un AS debe *anunciar* sus redes a
los demás para ser alcanzable.

#fig("fig-19-5.png", [Protocolos de encaminamiento interior y exterior entre dos sistemas autónomos.], fuente: "Stallings, Fig. 19.5, p. 643", ancho: 55%)

== RIP (Routing Information Protocol)

- *Vector distancia* con métrica = *número de saltos* (una red directamente conectada = 1); *16 = infinito* → solo sirve para redes de diámetro ≤ 15.
- Mensajes sobre *UDP puerto 520*: *solicitud* y *respuesta*. Cada router *activo* difunde su tabla cada *30 s*; un router *pasivo* (host) solo escucha. Una ruta expira si no se renueva en *180 s*; luego se anuncia con métrica 16 antes de borrarla.
- Usa horizonte dividido, envenenamiento en reversa, retención (60 s) y actualizaciones desencadenadas.
- *RIPv1*: con clases, sin máscara, por difusión. *RIPv2*: incluye *máscara de subred* (soporta VLSM/CIDR), siguiente salto, autenticación y usa la multidifusión `224.0.0.9`. *RIPng* (IPv6): UDP 521, mismas reglas.
- Desventajas: convergencia lenta, bucles transitorios, la métrica de saltos ignora velocidad y carga, mucha sobrecarga en redes grandes.

== OSPF (Open Shortest Path First)

- *Estado de enlace*, estándar abierto del IETF; viaja *directamente sobre IP* (protocolo *89*), multidifusión `224.0.0.5` (todos los routers OSPF) y `224.0.0.6` (DR).
- *Métrica configurable* por interfaz (en Cisco, costo = $10^8 \/$ ancho de banda); admite *rutas de igual costo* (balanceo de carga) y máscaras variables (sin clases). Mensajes autenticados.
- *Áreas*: el AS se divide en áreas jerárquicas conectadas al *área troncal 0*. La topología de un área queda oculta a las otras (se resumen rutas) → menos anuncios y cálculos. Tipos de router: interno, *de borde de área (ABR)*, de troncal y *de borde de AS (ASBR)*.
- En redes de difusión se elige un *router designado (DR)* y uno de respaldo (BDR) para que no todos intercambien con todos: cada router forma adyacencia con el DR.
- Mensajes: *Hello* (descubrir y mantener vecinos, cada 10 s), *descripción de base de datos*, *solicitud de estado de enlace*, *actualización de estado de enlace* (lleva los LSA) y *confirmación*. *OSPFv2* para IPv4, *OSPFv3* para IPv6.
- *IS-IS*: protocolo de estado de enlace de OSI, muy usado por grandes ISP; no depende de IP.

== EIGRP (Enhanced Interior Gateway Routing Protocol)

#extra[
  Protocolo de Cisco (hoy publicado como RFC 7868), *vector distancia avanzado* (a veces llamado
  "híbrido"). Usa protocolo IP *88* y multidifusión `224.0.0.10`. Características:
  - *Métrica compuesta*: por defecto ancho de banda mínimo del camino y retardo acumulado (opcionalmente carga y fiabilidad).
  - Algoritmo *DUAL*: mantiene una *tabla de topología* con lo que anuncian los vecinos; el mejor camino es el *sucesor* y un camino alternativo libre de bucles es el *sucesor factible* (cumple la *condición de factibilidad*: la distancia anunciada por el vecino es menor que la distancia factible actual). Si el sucesor cae y hay sucesor factible, la conmutación es *inmediata*; si no, consulta a los vecinos.
  - *Actualizaciones parciales y desencadenadas* (no periódicas), *Hello* para mantener vecinos, soporta VLSM/CIDR, balanceo con costos distintos.
  - Distancia administrativa (Cisco) para elegir entre protocolos: conectada 0, estática 1, EIGRP 90, OSPF 110, RIP 120.
]

== BGP (Border Gateway Protocol)

- *EGP de Internet* (versión 4). *Vector de caminos*: anuncia prefijos alcanzables junto con el *AS_PATH* (secuencia de AS a atravesar) → detecta bucles y permite políticas.
- Se ejecuta sobre *TCP puerto 179* (fiable: no necesita retransmitir ni enviar tablas completas periódicamente; solo cambios incrementales). *eBGP* entre routers de distintos AS; *iBGP* para distribuir lo aprendido dentro del AS.
- Funciones: *adquisición de vecinos* (acordar intercambiar información), *alcanzabilidad de vecinos* (comprobar que siguen activos) y *alcanzabilidad de redes* (anunciar y retirar prefijos).
- Mensajes (cabecera común de 19 bytes): *OPEN* (iniciar sesión, ASN, tiempo de retención), *UPDATE* (anunciar rutas con atributos y retirar rutas), *NOTIFICATION* (error, cierra la sesión), *KEEPALIVE* (mantener la sesión y confirmar el OPEN; típicamente cada un tercio del tiempo de retención) y *ROUTE-REFRESH*.
- Atributos de camino: AS_PATH, NEXT_HOP, ORIGIN, LOCAL_PREF (preferencia dentro del AS), MED (sugerencia al vecino), comunidades.
- *Políticas*: en el núcleo de Internet la elección no es por camino más corto sino por *economía*: cada ISP decide qué anunciar y a quién (*tránsito* pago vs *peering* sin costo, en IXP o enlaces privados). No hay un registro central autoritativo: anuncios falsos pueden "secuestrar" prefijos.

#tabla(
  columns: (auto, auto, auto, auto, auto),
  [], [*RIP*], [*OSPF*], [*EIGRP*], [*BGP*],
  [Tipo], [IGP vector distancia], [IGP estado de enlace], [IGP vector distancia avanzado], [EGP vector de caminos],
  [Métrica], [Saltos (máx. 15)], [Costo (ancho de banda)], [Ancho de banda + retardo], [Atributos / política],
  [Transporte], [UDP 520], [IP 89], [IP 88], [TCP 179],
  [Actualizaciones], [Periódicas, 30 s], [Por cambio (LSA) + refresco], [Parciales por cambio], [Incrementales],
  [Convergencia], [Lenta], [Rápida], [Muy rápida], [Lenta, estable],
  [Escala], [Redes pequeñas], [Grandes, con áreas], [Grandes (Cisco)], [Internet],
)

== Routers y enrutamiento entre VLAN

Un *router* tiene una interfaz (y una dirección IP) en cada red que interconecta, reenvía datagramas IP según
su tabla y *separa dominios de difusión*. Cada VLAN (Clase 5) es una subred IP distinta, por lo que el
tráfico entre VLAN requiere encaminamiento:

- *Una interfaz física del router por VLAN*: simple, pero no escala (un puerto de router y de switch por VLAN).
- *Router-on-a-stick*: un único enlace *troncal 802.1Q* entre el switch y el router, dividido en *subinterfaces* (una por VLAN, con su etiqueta e IP, que será el *gateway por defecto* de los hosts de esa VLAN). El tráfico entre VLAN sube y baja por el mismo enlace (cuello de botella).
- *Switch de capa 3*: una *interfaz virtual (SVI)* por VLAN con su IP; el switch reenvía entre VLAN por hardware a velocidad de línea. Es la solución habitual en el núcleo de las redes de campus.

#ejemplo(titulo: "Router-on-a-stick (configuración típica estilo Cisco)")[
  ```
  interface g0/0.10
   encapsulation dot1Q 10
   ip address 192.168.10.1 255.255.255.0
  interface g0/0.20
   encapsulation dot1Q 20
   ip address 192.168.20.1 255.255.255.0
  ```
  En el switch, el puerto hacia el router se configura como troncal y los hosts de la VLAN 10 usan
  192.168.10.1 como puerta de enlace.
]

== Guía de cuestiones de repaso (Stallings Cap. 19, encaminamiento)

#pr("19.5")[¿Qué es un sistema autónomo?][Un conjunto de routers y redes bajo una misma administración que usan un protocolo de encaminamiento común internamente y presentan una política coherente hacia afuera.]
#pr("19.6")[Protocolo de encaminador interior vs exterior.][El interior (IRP/IGP) intercambia información detallada dentro de un AS para hallar caminos óptimos; el exterior (ERP/EGP) intercambia información resumida de alcanzabilidad entre AS, con políticas en vez de métricas comparables.]
#pr("19.7")[Tres estrategias de encaminamiento.][Vector distancia (cada nodo envía a sus vecinos su vector de distancias; RIP), estado de enlace (cada nodo inunda el estado de sus enlaces y calcula SPF con el mapa completo; OSPF) y vector de caminos (se anuncian destinos con el camino de AS, sin métrica; BGP).]
#pr("19.8")[Tres funciones de BGP.][Adquisición de vecinos (OPEN/KEEPALIVE), detección de vecino alcanzable (KEEPALIVE periódicos) y detección de red alcanzable (UPDATE con prefijos y caminos).]
#pr("19.1–19.4")[Multidifusión e IGMP.][Corresponden a multidifusión (no está en el temario de esta clase): IGMP permite que los hosts informen a su router local de qué grupos multicast quieren recibir.]

== Guía de ejercicios (Stallings Cap. 19 y Comer Caps. 12–14)

#pr("19.4")[¿Por qué IGMP usa TTL = 1?][Porque las consultas e informes IGMP son locales a la red: no deben ser reenviados por los routers.]
#pr("19.5")[Balanceo de carga OSPF y TCP.][Los segmentos de una conexión pueden ir por caminos de distinto retardo y llegar desordenados: el receptor genera ACK duplicados, el emisor puede retransmitir innecesariamente y reducir su ventana, y la estimación del RTT varía más. Por eso se suele balancear por flujo y no por paquete.]
#pr("19.7")[Ráfaga máxima de un cubo de testigos.][Durante $S$ se gasta lo acumulado más lo que llega: $B + R S = M S$ → $S = B\/(M - R)$. Con $B = 250$ kB, $R = 2$ MB/s, $M = 25$ MB/s: $S = 250 times 10^3 \/ 23 times 10^6 approx 10,9$ ms.]
#pr("C12.1")[Un router va a reenviar un datagrama por la misma interfaz por la que llegó.][Lo reenvía, pero además envía un *ICMP de redirección* al origen indicándole un primer salto mejor (que el origen podría usar directamente).]
#pr("C12.7")[Dos routers anuncian el mismo costo $k$ a una red.][Si las métricas son costos administrativos (no saltos), el mismo valor puede corresponder a cantidades distintas de saltos reales; también influye cuántos saltos hay hasta cada router anunciante.]
#pr("C13.5")[¿Pueden dos AS formar un bucle con BGP?][No con anuncios correctos: el AS_PATH incluye el propio ASN y un router descarta rutas que lo contienen. Solo políticas o configuraciones erróneas (o manipulación de atributos) podrían causarlo.]
#pr("C13.10")[Omitir la red N en los anuncios a B, ¿la protege?][No: B puede alcanzarla por otro camino (otro AS que sí la anuncie, ruta por defecto). Ocultar rutas no es un mecanismo de seguridad; hacen falta filtros o cortafuegos.]
#pr("C14.5")[¿Cuándo el horizonte dividido evita la convergencia lenta?][En bucles de dos routers (topologías sin ciclos más largos); no basta cuando hay ciclos de tres o más routers.]
#pr("C14.8")[¿Cuándo la métrica de saltos da mejores rutas que el retardo?][Cuando los enlaces son homogéneos o el retardo es muy variable: el retardo medido oscila con la carga y provoca inestabilidad (rutas que cambian continuamente).]
