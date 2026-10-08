#import "../lib.typ": *

= Clase 5 (7/9) — Capa de acceso en redes locales

#lectura[
  [STA] Parte IV, *Capítulo 15*: 15.1 Aplicaciones de las LAN · 15.2 Topologías y medios · 15.3 Arquitectura
  de protocolos (IEEE 802, LLC, MAC) · 15.4 Puentes (funciones, arquitectura, encaminamiento estático,
  árbol de expansión) · 15.5 Conmutadores de capa 2 y 3. Para los temas del programa *802.3* y *802.11*
  se usan 16.2 y 17.3–17.4; *802.1Q* y los detalles de *STP* se completan con los estándares IEEE 802.1Q/802.1D.
]

== Aplicaciones de las LAN (15.1)

- *LAN de computadores personales*: compartir recursos (archivos, impresoras, acceso a Internet); requisito clave: *bajo costo* de conexión por equipo.
- *Redes de respaldo (backend) y SAN*: interconectan pocos sistemas grandes y almacenamiento masivo a alta velocidad, en distancias cortas y con alta fiabilidad. Una *SAN* es una red separada para el almacenamiento: servidores y discos se conectan directamente a la red (no a través de un servidor), lo que facilita copias de respaldo y replicación.
- *Redes ofimáticas de alta velocidad*: imágenes, gráficos y archivos grandes exigen más que 10 Mbps.
- *LAN troncales (backbone)*: en lugar de una sola LAN (poco fiable, se satura, costosa), varias LAN baratas por departamento interconectadas por una LAN troncal de alta capacidad.

== Topologías y medios de transmisión (15.2)

Elementos de una LAN: *topología*, *medio*, *cableado (disposición)* y *técnica de control de acceso al medio*.

#fig("fig-15-2.png", [Topologías LAN: bus, árbol, anillo y estrella.], fuente: "Stallings, Fig. 15.2, p. 485", ancho: 60%)

- *Bus / árbol*: medio *multipunto*; las estaciones se conectan con *tomas (taps)*; la transmisión se propaga en ambos sentidos y la reciben todas; *terminadores* absorben la señal en los extremos. Problemas: indicar a quién va dirigida (→ *tramas* con dirección destino) y regular quién transmite (→ *control de acceso*).
- *Anillo*: repetidores unidos por enlaces punto a punto *unidireccionales* formando un lazo; la trama circula, el destino la copia y el *origen la retira*. Alta velocidad y distancia, pero la falla de un enlace o repetidor cae toda la red.
- *Estrella*: cada estación con dos enlaces (Tx/Rx) a un nodo central. Si el nodo *difunde* (concentrador, _hub_) es lógicamente un bus; si *conmuta* tramas (conmutador, _switch_) cada estación tiene capacidad dedicada. Aprovecha el cableado de los edificios: es la dominante.
- *Elección de medio*: capacidad, fiabilidad, tipo de datos y alcance. UTP Cat 3 es barato pero limitado; la tendencia es UTP Cat 5+ en estrella con conmutadores; fibra para troncales.

== Arquitectura de protocolos IEEE 802 (15.3)

#grid(columns: (1fr, 1fr), gutter: 8pt,
  fig("fig-15-5.png", [Capas IEEE 802 frente a OSI.], fuente: "Stallings, Fig. 15.5, p. 490", ancho: 85%),
  fig("fig-15-6.png", [Protocolos LAN en contexto: encapsulado TCP/IP sobre LLC y MAC.], fuente: "Stallings, Fig. 15.6, p. 491", ancho: 100%),
)

- *Física*: codificación de señal, preámbulo (sincronización), transmisión de bits; *incluye la especificación del medio y la topología*.
- *MAC* (control de acceso al medio): arma tramas con direcciones y CRC, reconoce direcciones y detecta errores (*descarta* tramas erróneas), y *controla el acceso* al medio compartido.
- *LLC* (control del enlace lógico): interfaz con las capas superiores, control de errores y de flujo (opcional). Se separa de MAC porque la lógica de acceso a un medio compartido no existe en los enlaces tradicionales y así se pueden ofrecer varias MAC bajo el mismo LLC.

*Servicios LLC* (basado en HDLC; usuarios identificados por *LSAP*): *tipo 1* no orientado a conexión sin
confirmación (datagramas, PDU UI; el más usado porque TCP ya da fiabilidad), *tipo 2* orientado a
conexión (SABME/UA/DM/DISC, control de flujo y errores como HDLC ABM con números de 7 bits) y *tipo 3* no
orientado a conexión con confirmación (PDU AC con número de secuencia de 1 bit). PDU LLC: DSAP (7 bits +
I/G) · SSAP (7 bits + C/R) · control · información.

#fig("fig-15-7.png", [PDU LLC dentro de la trama MAC genérica.], fuente: "Stallings, Fig. 15.7, p. 494", ancho: 60%)

*Trama MAC genérica*: control MAC · dirección MAC destino · dirección MAC origen · PDU LLC · CRC (FCS).
La MAC *detecta* errores y descarta; la *recuperación* (retransmisión) es opcional en LLC o queda para TCP.

== Métodos de acceso al medio

*¿Dónde?* *Centralizado* (un controlador concede el acceso: prioridades y capacidad garantizada, lógica
simple en las estaciones, pero punto único de falla y cuello de botella) o *distribuido*. *¿Cómo?*
*Síncrono* (capacidad fija por conexión, como TDM/FDM: no sirve para tráfico impredecible) o *asíncrono*:

- *Rotación circular* (_round robin_): cada estación tiene su turno (sondeo centralizado o paso de testigo distribuido, como Token Ring 802.5). Eficiente si muchas estaciones tienen datos.
- *Reserva*: ranuras de tiempo reservadas para tráfico continuo (voz, transferencias largas).
- *Contención*: sin turnos, todas compiten; distribuidas, simples y eficientes con carga baja o media; se degradan con carga alta. Adecuadas para tráfico *a ráfagas*.

=== De ALOHA a CSMA/CD (Stallings 16.2)

- *ALOHA puro*: transmitir cuando se quiera, esperar confirmación un tiempo = 2 × retardo máximo de propagación; si no llega, retransmitir. Utilización máxima ≈ *18 %*.
- *ALOHA ranurado*: solo se transmite al comienzo de ranuras de duración = tiempo de trama (requiere reloj común); utilización máxima ≈ *37 %*.
- *CSMA*: *escuchar antes de transmitir* (detección de portadora). Útil cuando el retardo de propagación es pequeño frente al tiempo de transmisión de la trama. Si está ocupado:
  - *No persistente*: esperar un tiempo aleatorio y volver a escuchar (desperdicia tiempo libre).
  - *1-persistente*: seguir escuchando y transmitir apenas se libere (colisión segura si hay dos esperando).
  - *p-persistente*: con el medio libre transmitir con probabilidad $p$ o esperar una unidad de tiempo con $1-p$. Para evitar inestabilidad $n p < 1$; con carga baja se espera en promedio $1\/p$ iteraciones.
- *CSMA/CD* (Ethernet): 1-persistente + *escuchar mientras se transmite*. Al detectar colisión se envía una breve *señal de interferencia (jam)*, se deja de transmitir y se espera un tiempo aleatorio (*backoff*) antes de reintentar.

#grid(columns: (1fr, 1fr), gutter: 8pt,
  fig("fig-16-1.png", [Persistencia y espera en CSMA.], fuente: "Stallings, Fig. 16.1, p. 518", ancho: 100%),
  fig("fig-16-2.png", [Funcionamiento de CSMA/CD en un bus.], fuente: "Stallings, Fig. 16.2, p. 520", ancho: 70%),
)

#clave[
  - El tiempo para detectar una colisión es como mucho *2 veces el retardo de propagación extremo a extremo* ($2 tau$).
  - Por eso la trama debe durar al menos $2 tau$: *longitud mínima* $L_min = 2 tau R = 2 d R \/ v$. En 802.3 (10/100 Mbps) la ranura es de *512 bits = 64 bytes*.
  - *Backoff exponencial binario*: tras la colisión $n$ se elige al azar $k in [0, 2^m - 1]$ ranuras con $m = min(n, 10)$; tras 16 intentos fallidos se descarta la trama y se informa error. Efecto "último en llegar, primero en salir".
  - Parámetro $a = tau \/ T_"trama"$ (propagación / transmisión): cuanto menor, mejor rendimiento de CSMA/CD.
]

== IEEE 802.3 (Ethernet)

#fig("fig-16-3.png", [Formato de la trama IEEE 802.3.], fuente: "Stallings, Fig. 16.3, p. 522", ancho: 70%)

- *Preámbulo* (7 bytes 10101010…, sincronización) y *SFD* (10101011) · *DA* y *SA* (6 bytes cada una) · *Longitud/Tipo* (≤ 1500 = longitud 802.3; ≥ 0x0600 = tipo Ethernet II, ej. 0x0800 IPv4, 0x0806 ARP, 0x86DD IPv6, 0x8100 VLAN) · *Datos* 46–1500 bytes (+ *relleno* si hace falta) · *FCS* CRC-32.
- Trama mínima 64 bytes y máxima 1518 bytes (sin preámbulo/SFD); MTU de Ethernet = 1500 bytes. Entre tramas hay un intervalo de 96 bits (IFG).
- *Dirección MAC* de 48 bits: 24 bits de fabricante (OUI) + 24 de la interfaz. Bit I/G (individual/grupo) y U/L (universal/local). Difusión = FF:FF:FF:FF:FF:FF.
- *Full-duplex*: con un conmutador cada enlace es su propio *dominio de colisión*; no hay colisiones y CSMA/CD no se usa (100 Mbps full-duplex ≈ 200 Mbps agregados).

#tabla(
  columns: (auto, auto, 1fr),
  [*Estándar*], [*Medio*], [*Notas*],
  [10BASE5 / 10BASE2], [Coaxial grueso / fino, bus], [Manchester; segmentos de 500 m / 185 m; hasta 4 repetidores (2,5 km).],
  [10BASE-T / 10BASE-F], [UTP Cat 3 / fibra, estrella], [100 m por enlace UTP; 500 m–2 km en fibra.],
  [100BASE-TX / FX], [2 pares UTP Cat 5 o STP / 2 fibras], [4B/5B + MLT-3 (TX) o NRZI (FX); 100 m en cobre.],
  [100BASE-T4], [4 pares UTP Cat 3], [8B6T; 3 pares por sentido a 33,3 Mbps.],
  [1000BASE-SX / LX], [Fibra multimodo / monomodo], [8B/10B; 275–550 m / hasta 5 km.],
  [1000BASE-CX / T], [Cobre apantallado / 4 pares UTP Cat 5], [CX < 25 m; T hasta 100 m con 4D-PAM5. Half-duplex con *extensión de portadora* (4096 bits) y *ráfagas de tramas*.],
  [10GBASE-…], [Fibra (y luego cobre Cat 6a)], [Solo full-duplex; 300 m a 40 km. Compite en MAN/WAN.],
)

Notación: _velocidad_ BASE _medio/segmento_ (en centenas de metros o T = par trenzado, F/X = fibra).

== IEEE 802.11 (LAN inalámbricas)

#fig("fig-17-4.png", [Arquitectura IEEE 802.11: BSS, ESS, sistema de distribución, AP y portal.], fuente: "Stallings, Fig. 17.4, p. 568", ancho: 50%)

- *BSS* (conjunto básico de servicios): estaciones con el mismo MAC que compiten por el mismo medio (una "celda"). Aislado = red *ad hoc* (IBSS); con *punto de acceso (AP)* = modo *infraestructura*.
- *AP*: estación que da acceso al *sistema de distribución (DS)* (normalmente la LAN cableada); actúa como *puente* entre 802.11 y 802.3. *ESS*: varios BSS unidos por un DS, que ante LLC parece una sola LAN. *Portal*: integración con una LAN 802.x cableada.
- *Servicios* (9): de estación — autenticación, fin de autenticación, privacidad, entrega de MSDU; del DS — asociación, reasociación, disociación, distribución, integración. Movilidad: sin transición, *transición BSS* (soportada con reasociación) y transición ESS (no garantiza continuidad).

*MAC 802.11 (DFWMAC)*:

- *Entrega fiable*: cada trama de datos se confirma con un *ACK* (intercambio atómico); opcionalmente *RTS/CTS* (4 tramas) para reservar el medio y resolver el problema del *terminal oculto*.
- *DCF* (función de coordinación distribuida): *CSMA/CA*, sin detección de colisiones (en radio no se puede escuchar mientras se transmite: la señal propia tapa la recibida). Si el medio está libre durante un *IFS* se transmite; si está ocupado se espera a que se libere, un IFS más y un *backoff* aleatorio (exponencial binario) que se congela si el medio se ocupa.
- Prioridades por espaciado: *SIFS* (el más corto: ACK, CTS, respuesta a sondeo, fragmentos siguientes) < *PIFS* (coordinador puntual) < *DIFS* (tráfico asíncrono normal).
- *PCF* (opcional): sondeo centralizado desde el AP para tráfico sensible al retardo, dentro de una *supertrama* que reserva luego un periodo de contención.
- *Trama*: control de trama · duración/ID · hasta *4 direcciones* (origen, destino, transmisor y receptor: AP de entrada y salida) · control de secuencia · cuerpo (0–2312 bytes) · CRC-32. Tipos: control (RTS, CTS, ACK, PS-Poll, CF-End), gestión (baliza, asociación, autenticación) y datos.

#grid(columns: (1fr, 1fr), gutter: 8pt,
  fig("fig-17-6.png", [Lógica de acceso al medio en 802.11 (DCF).], fuente: "Stallings, Fig. 17.6, p. 575", ancho: 85%),
  fig("fig-17-7.png", [Temporización de IFS y uso de la supertrama PCF.], fuente: "Stallings, Fig. 17.7, p. 576", ancho: 100%),
)

#extra[
  Versiones de la capa física: 802.11b (2,4 GHz, 11 Mbps), 802.11a (5 GHz, OFDM, 54 Mbps), 802.11g (2,4 GHz,
  54 Mbps), 802.11n/Wi-Fi 4 (MIMO, hasta 600 Mbps), 802.11ac/Wi-Fi 5 (5 GHz, Gbps), 802.11ax/Wi-Fi 6
  (OFDMA). En 2,4 GHz solo los canales 1, 6 y 11 no se solapan.
]

== Dispositivos de interconexión

#tabla(
  columns: (auto, auto, 2.2fr, 1fr),
  [*Dispositivo*], [*Capa*], [*Función*], [*Dominios*],
  [NIC (tarjeta de red)], [1–2], [Interfaz con el medio: codifica la señal, implementa MAC (arma tramas, CRC, CSMA/CD o CSMA/CA) y tiene la *dirección MAC* grabada.], [—],
  [Repetidor], [1], [Regenera la señal bit a bit para extender un segmento; no aísla colisiones.], [1 colisión, 1 difusión],
  [Concentrador (hub)], [1], [Repetidor multipuerto: lo que entra por un puerto sale por todos. Estrella física, bus lógico; capacidad total compartida. Enlaces UTP ≤ 100 m.], [1 colisión, 1 difusión],
  [Puente (bridge)], [2], [Une LAN que usan la misma MAC; filtra por dirección MAC, almacena y reenvía; aprende direcciones. Por software, de a una trama.], [1 colisión por puerto, 1 difusión],
  [Conmutador (switch) capa 2], [2], [Puente multipuerto por hardware con caminos en paralelo; full-duplex; _store-and-forward_ o _cut-through_.], [1 colisión por puerto, 1 difusión (o una por VLAN)],
  [Punto de acceso (AP)], [2], [Puente entre el BSS inalámbrico y el DS cableado; gestiona asociación y autenticación.], [—],
  [Router / conmutador capa 3], [3], [Reenvía datagramas IP entre redes; separa dominios de difusión.], [1 difusión por interfaz],
)

#fig("fig-15-13.png", [Bus compartido, concentrador y conmutador: en el conmutador B→A y C→D transmiten a la vez (20 Mbps totales).], fuente: "Stallings, Fig. 15.13, p. 506", ancho: 45%)

*Conmutador capa 2*: no requiere cambios en las estaciones; cada dispositivo tiene capacidad dedicada;
escala fácilmente. *Store-and-forward*: recibe la trama completa y verifica el CRC antes de reenviar (más
retardo, integridad completa). *Cut-through*: reenvía en cuanto lee la dirección destino (mínimo retardo,
pero propaga tramas erróneas). Diferencias con el puente: hardware vs software, varias tramas en paralelo,
puede operar en _cut-through_.

== Puentes (15.4)

Se usan entre LAN con *idénticas capas física y MAC* (ej. todas 802.3). Razones para varias LAN unidas por
puentes: *fiabilidad* (una falla no tumba todo), *prestaciones* (separar tráfico local), *seguridad* y
*geografía*.

- *Funciones*: leer todas las tramas de A y aceptar las dirigidas a estaciones de B; retransmitirlas en B con la MAC de B; idem de B a A.
- *No modifica* contenido ni formato ni agrega cabecera: copia la trama bit a bit. Necesita *memoria temporal* (picos de tráfico) y capacidad de *direccionamiento y encaminamiento*. Para las estaciones, todo parece una única LAN.
- Arquitectura *IEEE 802.1D*: el puente opera en la capa MAC; *no tiene LLC* (el diálogo LLC es entre las estaciones finales). Si las LAN están lejos, dos puentes pueden unirse por un enlace o una WAN encapsulando la trama.

#fig("fig-15-9.png", [Conexión de dos LAN mediante un puente: arquitectura y encapsulado.], fuente: "Stallings, Fig. 15.9, p. 499", ancho: 60%)

*Encaminamiento estático*: se elige una ruta (mínimo número de saltos) para cada par de LAN; una matriz
central da el primer puente de cada ruta y de cada fila se derivan las tablas de cada puente (una por
cada LAN conectada). Simple, pero inadecuado si hay fallas o cambios.

#fig("fig-15-10.png", [Configuración de puentes y LAN con rutas alternativas.], fuente: "Stallings, Fig. 15.10, p. 500", ancho: 50%)

=== Técnica del árbol de expansión (spanning tree)

Los puentes construyen y actualizan *solos* su tabla de reenvío. Tres mecanismos:

+ *Reenvío de tramas*: una *base de datos de reenvío* por puerto. Al recibir por el puerto $x$: si el destino está asociado a otro puerto $y$ no bloqueado, reenviar por $y$; si está asociado al mismo $x$, descartar (filtrar); si es desconocido, *inundar* por todos los puertos salvo $x$.
+ *Aprendizaje de direcciones*: la *dirección origen* de cada trama recibida por el puerto $x$ indica que esa estación está "del lado" de $x$; cada entrada tiene un *temporizador* (envejecimiento, típicamente 300 s) que se reinicia al verla de nuevo.
+ *Evitar bucles*: con caminos redundantes las tramas circulan sin fin, se duplican y las tablas aprenden mal (en la Fig. 15.11 ambos puentes terminan creyendo que A está del lado de la LAN Y). Se calcula un *árbol de expansión* (subgrafo sin ciclos que conecta todas las LAN) bloqueando algunos puertos.

#fig("fig-15-11.png", [Bucle de puentes: tramas duplicadas y aprendizaje erróneo.], fuente: "Stallings, Fig. 15.11, p. 503", ancho: 40%)

== Spanning Tree Protocol (IEEE 802.1D)

Cada puente tiene un *Bridge ID* = prioridad (2 bytes, por defecto 32768) + dirección MAC, y cada puerto un
*costo* (según velocidad: 10 Mbps = 100, 100 Mbps = 19, 1 Gbps = 4, 10 Gbps = 2). Los puentes intercambian
*BPDU* (_Bridge Protocol Data Units_, a la dirección multicast 01:80:C2:00:00:00) cada 2 s (_hello_).

+ *Elección del puente raíz*: el de *menor Bridge ID* (menor prioridad; a igualdad, menor MAC). Todos sus puertos quedan *designados* (reenvían).
+ *Puerto raíz* en cada puente no raíz: el de *menor costo acumulado hasta la raíz* (desempate: menor Bridge ID del vecino, luego menor ID de puerto).
+ *Puerto designado* en cada segmento/LAN: el del puente con menor costo a la raíz hacia ese segmento (desempate por Bridge ID); ese puente reenvía el tráfico del segmento.
+ Todo puerto que no es raíz ni designado queda *bloqueado* (no reenvía datos pero sigue escuchando BPDU).

Estados de puerto: *bloqueo* → *escucha* (15 s, _forward delay_) → *aprendizaje* (15 s) → *envío*; también
*deshabilitado*. Si no llegan BPDU durante _max age_ (20 s) se recalcula el árbol: la convergencia de 802.1D
tarda 30–50 s. *RSTP* (802.1w) converge en pocos segundos (puertos alternativos y de respaldo, negociación
propuesta/acuerdo); *MSTP* (802.1s) calcula un árbol por grupo de VLAN.

#ejemplo(titulo: "Procedimiento para resolver un ejercicio de STP")[
  (1) Raíz = menor (prioridad, MAC). (2) Para cada otro puente, sumar costos de los enlaces hasta la raíz por
  cada puerto y marcar como *raíz* el de menor costo. (3) En cada enlace/LAN, el extremo más cercano a la raíz
  es *designado* (en la raíz, todos). (4) Los puertos restantes se *bloquean*: habrá exactamente uno bloqueado
  por cada ciclo del grafo. En la Fig. 15.10, con costos iguales, basta bloquear uno de los puentes 101, 104 o
  107 para romper el ciclo A–B–E.
]

== VLAN y protocolo de troncal IEEE 802.1Q

Una *VLAN* es un *dominio de difusión lógico*: agrupa puertos (o direcciones) de uno o varios conmutadores
independientemente de su ubicación física. Ventajas: limita la difusión, segmenta por seguridad o
departamento, flexibilidad sin recablear. Tráfico entre VLAN distintas *requiere un router* o conmutador
de capa 3 (Clase 8).

- *Puerto de acceso*: pertenece a una sola VLAN; las tramas viajan *sin etiqueta*.
- *Puerto troncal (trunk)*: transporta varias VLAN entre conmutadores (o hacia un router) *etiquetando* cada trama.
- *Etiqueta 802.1Q* (4 bytes, insertada entre la dirección origen y Longitud/Tipo): *TPID* = 0x8100 (16 bits) · *PCP* (3 bits, prioridad 802.1p para QoS) · *DEI/CFI* (1 bit) · *VID* (12 bits → 4096 valores; 1–4094 utilizables; 1 = VLAN por defecto). La trama máxima pasa a 1522 bytes y se recalcula el FCS.
- *VLAN nativa*: la que viaja sin etiqueta por el troncal (por defecto la 1); debe coincidir en ambos extremos.
- Q-in-Q (802.1ad) apila dos etiquetas (proveedores).

#tabla(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  align: center,
  [Destino (6)], [Origen (6)], [*TPID 0x8100 (2)*], [*PCP·DEI·VID (2)*], [Tipo/Long. (2)], [Datos 42–1500], [FCS (4)],
)
#text(size: 8.5pt)[Trama Ethernet con etiqueta 802.1Q (tamaños en bytes; con etiqueta el mínimo de datos baja a 42).]

== Conmutadores de capa 2 y capa 3 (15.5)

Problemas de una red grande solo con conmutadores de capa 2: *espacio de direcciones plano* → *sobrecarga
de difusión* (una trama de difusión llega a todos; un equipo defectuoso puede provocar una *tormenta de
difusión*) y *falta de caminos múltiples* (STP deja un solo camino activo). Solución: dividir en *subredes*
unidas por routers; para no perder velocidad, *conmutadores de capa 3* que reenvían IP por hardware:
*paquete a paquete* (como un router, ≈ 10× más rápido) o *basados en flujo* (identifican flujos por
origen/destino o etiqueta de flujo IPv6 y les asignan un camino predefinido).

#fig("fig-15-14.png", [Configuración típica: conmutadores de capa 2 en el acceso, de capa 3 en el núcleo, router hacia la WAN.], fuente: "Stallings, Fig. 15.14, p. 509", ancho: 50%)

== Guía de cuestiones de repaso (Cap. 15)

#pr("15.1")[Requisitos de redes de salas de computadores vs LAN de PC.][Salas (backend): alta velocidad, interfaces rápidas, acceso distribuido, distancias cortas, pocos equipos caros, alta fiabilidad. LAN de PC: bajo costo por conexión, muchos equipos, velocidad moderada.]
#pr("15.2")[Backend vs SAN vs troncal.][Backend: interconecta grandes sistemas y almacenamiento. SAN: red dedicada al almacenamiento compartido, con dispositivos conectados directamente a la red. Troncal: LAN de alta capacidad que interconecta LAN departamentales.]
#pr("15.3")[¿Qué es la topología?][La forma en que se interconectan las estaciones de la red.]
#pr("15.4")[Cuatro topologías.][Bus (medio lineal multipunto con terminadores), árbol (bus ramificado desde una raíz), anillo (repetidores en lazo unidireccional; la trama vuelve al origen que la retira) y estrella (nodo central que difunde o conmuta).]
#pr("15.5")[Propósito del comité IEEE 802.][Desarrollar los estándares de LAN/MAN para las capas física y de enlace (LLC y MAC), adoptados luego por ISO.]
#pr("15.6")[¿Por qué hay distintos estándares LAN?][Porque distintas aplicaciones requieren distintos compromisos de costo, velocidad, distancia y medio (y evoluciona la tecnología): 802.3, 802.5, 802.11, etc.]
#pr("15.7")[Servicios LLC.][No orientado a conexión sin confirmación (datagramas), orientado a conexión (control de flujo y errores) y no orientado a conexión con confirmación (datagramas confirmados).]
#pr("15.8")[Modos de operación LLC.][Tipo 1 (PDU UI, sin confirmación), tipo 2 (conexión estilo HDLC ABM: SABME, UA, I, S, DISC) y tipo 3 (PDU AC confirmadas con secuencia de 1 bit).]
#pr("15.9")[Funciones MAC.][Ensamblar/desensamblar tramas con direcciones y CRC, reconocer direcciones, detectar errores y controlar el acceso al medio.]
#pr("15.10")[Funciones de un puente.][Leer las tramas de una LAN, aceptar las destinadas a la otra, almacenarlas y retransmitirlas con la MAC de la otra LAN; aprender direcciones y encaminar entre varias LAN.]
#pr("15.11")[¿Qué es un árbol de expansión?][Un subgrafo que conecta todas las LAN (nodos) usando algunos puentes (aristas) sin formar ciclos; garantiza un único camino entre dos LAN.]
#pr("15.12")[Concentrador vs conmutador.][El hub repite la señal a todos los puertos (medio compartido, colisiones, capacidad total compartida); el switch reenvía cada trama solo al puerto destino, varias en paralelo y en full-duplex.]
#pr("15.13")[Store-and-forward vs cut-through.][El primero recibe la trama entera y verifica el CRC antes de reenviar (más retardo, no propaga errores); el segundo reenvía al leer la dirección destino (menor retardo, puede propagar tramas erróneas).]

== Guía de ejercicios (Caps. 15 y 16)

#pr("15.1")[¿HDLC en lugar de LLC?][No directamente: HDLC supone un enlace con estación primaria/secundaria y no contempla acceso múltiple sin nodo primario ni la multiplexación por SAP; LLC adapta HDLC a medios compartidos apoyándose en la MAC.]
#pr("15.2")[Teletipo asíncrono en una LAN.][Cada carácter iría en una trama con enorme sobrecarga y competiría por el medio cada vez. Solución: un concentrador/servidor de terminales que agrupe caracteres en tramas (por tiempo o por fin de línea).]
#pr("15.3")[Tiempo de transferencia de 10⁶ caracteres.][(a) $8 times 10^6 \/ 64 000 = 125$ s. (b) Por paquete: $t = (P + 80)\/B + 88\/B + 2 d\/v$; número de paquetes $= 8 times 10^6 \/ P$; total = n.º × $t$ y rendimiento = $8 times 10^6\/"total"$. (c) Anillo: sumar el retardo de $N$ repetidores (un bit cada uno) y la propagación por $2D$.]
#pr("15.4")[Bus de 1 km a 10 Mbps, trama de 10 000 bits.][(a) Transmisión 1 ms + propagación media (≈ 1/3 de la longitud: 333 m → 1,7 µs) ≈ 1,002 ms. (b) Se detecta la interferencia tras el retardo de propagación entre ambas, como máximo 1000 m / 200 m/µs = 5 µs = 50 bits.]
#pr("15.5")[Igual a 100 Mbps.][Transmisión 0,1 ms; detección ≤ 5 µs = 500 bits: la relación $a$ empeora 10 veces.]
#pr("15.6")[Longitud equivalente de un bit de retardo por repetidor.][$v\/R$: (a) 1 Mbps → 200 m; (b) 40 Mbps → 5 m.]
#pr("15.8")[Fiabilidad de anillos.][(a) $P_A = 1 - (1 - P_l)^300 (1 - P_r)^300$. (b) B falla del todo si fallan los tres anillos o el puente central, etc.: plantear con probabilidades de cada anillo $P_"anillo" = 1 - (1 - P_l)^100 (1 - P_r)^100$. Con $10^(-2)$, $P_A approx 0,998$: un anillo grande es casi seguro que falle; segmentar con puentes mejora la disponibilidad.]
#pr("15.10")[Matriz y tablas de la Fig. 15.10.][Para cada par (LAN origen, LAN destino) anotar el primer puente de la ruta de menos saltos; la tabla de cada puente, por cada LAN a la que se conecta, asocia las estaciones destino con la LAN de salida.]
#pr("16.1")[Fracción de ranuras desperdiciadas.][Una ranura se desperdicia si intentan 2 o más: $1 - (1-p)^N - N p (1-p)^(N-1)$ (si se cuentan también las vacías, sumar $(1-p)^N$).]
#pr("16.2")[CSMA p-persistente sin competencia.][El número de iteraciones es geométrico con éxito $p$: media $1\/p$; como transmite en la última, espera $T (1\/p - 1)$.]
