#import "../lib.typ": *

= Clase 4 (31/8) — Capa física: medios de transmisión

#lectura[
  [STA] Parte II, *Capítulo 4*: 4.1 Medios guiados (par trenzado, coaxial, fibra óptica) · 4.2 Transmisión
  inalámbrica (antenas, microondas terrestres y satelitales, radio, infrarrojos) · 4.3 Propagación
  inalámbrica (superficial, aérea, en línea de vista). Se agrega 4.4 (pérdidas en línea de vista), que
  es necesaria para los ejercicios, y un resumen de *unidades de medida*.
]

En medios *guiados* lo que más limita es el propio medio; en *no guiados* importa más el ancho de banda
de la señal emitida por la antena y la *direccionalidad* (a baja frecuencia las señales son
omnidireccionales; a alta se pueden concentrar en haces). Factores que determinan distancia y
velocidad: *ancho de banda*, *dificultades* (atenuación: par > coaxial > fibra), *interferencias* (de
bandas próximas o cables vecinos) y *número de receptores* (cada conexión en un medio compartido
atenúa y distorsiona).

#fig("fig-4-1.png", [Espectro electromagnético para telecomunicaciones.], fuente: "Stallings, Fig. 4.1, p. 97", ancho: 75%)

== Medios guiados (4.1)

#tabla(
  columns: (auto, auto, auto, auto, auto),
  align: center,
  [*Medio*], [*Rango de frecuencia*], [*Atenuación típica*], [*Retardo*], [*Separación de repetidores*],
  [Par trenzado (con carga)], [0–3,5 kHz], [0,2 dB/km a 1 kHz], [50 µs/km], [2 km],
  [Pares trenzados (multipar)], [0–1 MHz], [3 dB/km a 1 kHz], [5 µs/km], [2 km],
  [Cable coaxial], [0–500 MHz], [7 dB/km a 10 MHz], [4 µs/km], [1–9 km],
  [Fibra óptica], [180–370 THz], [0,2–0,5 dB/km], [5 µs/km], [40 km],
)
#text(size: 8.5pt)[Tabla 4.1 de Stallings (p. 98), características de transmisión punto a punto.]

#fig("fig-4-2.png", [Medios guiados: (a) par trenzado, (b) cable coaxial, (c) fibra óptica.], fuente: "Stallings, Fig. 4.2, p. 98", ancho: 45%)

=== Par trenzado

- Dos conductores de cobre aislados (0,4–0,9 mm) trenzados en espiral; el *trenzado reduce la diafonía* entre pares vecinos (pasos de torsión distintos) y las interferencias de baja frecuencia.
- Es el medio más barato y más usado: bucle de abonado telefónico, cableado de edificios, LAN (10 Mbps a 1 Gbps en distancias cortas).
- Analógico: amplificadores cada 5–6 km; digital: repetidores cada 2–3 km. Atenuación muy dependiente de la frecuencia, sensible a interferencias y ruido impulsivo (capta 50/60 Hz de líneas de potencia).
- *UTP* (sin apantallar): barato y fácil de instalar. *STP* (apantallado con malla): mejor a altas velocidades, más caro y rígido. Variantes: FTP (papel metálico), SSTP (cada par apantallado).
- Categorías (EIA-568-A y posteriores): Cat 3 = 16 MHz (voz, hasta 16 Mbps), Cat 4 = 20 MHz, *Cat 5 = 100 MHz* (100 Mbps), Cat 5e = 100 MHz mejorado, Cat 6 = 200–250 MHz, Cat 7 = 600 MHz. El tipo 5 tiene más trenzas por unidad de longitud (0,6–0,85 cm vs 7,5–10 cm).
- *NEXT* (diafonía cercana al extremo): la señal transmitida se acopla a un par receptor en el mismo extremo; cuanto mayor el valor en dB, mejor (Cat 5 a 16 MHz: 44 dB vs Cat 3: 23 dB).

=== Cable coaxial

- Conductor interno y malla/cilindro externo concéntricos con dieléctrico; 1–2,5 cm de diámetro. Opera en un rango de frecuencias mucho mayor y es mucho *menos sensible a interferencias y diafonía* por su apantallamiento.
- Aplicaciones: distribución de TV (CATV), telefonía de larga distancia (> 10 000 canales de voz con FDM, hoy desplazado por fibra), enlaces cortos entre equipos, LAN antiguas (10BASE5/10BASE2).
- Limitaciones: atenuación, ruido térmico e intermodulación (con FDM). Analógico hasta ≈ 500 MHz con amplificadores cada pocos km; digital con repetidores ≈ cada 1 km.

=== Fibra óptica

- *Núcleo* (8–100 µm, vidrio o plástico) + *revestimiento* (índice de refracción menor: confina la luz por *reflexión total interna*) + *cubierta* protectora.
- Ventajas: *mayor capacidad* (cientos de Gbps en decenas de km), *menor tamaño y peso*, *menor atenuación* y casi constante en un gran rango, *aislamiento electromagnético* (inmune a interferencias, no irradia, difícil de pinchar) y *mayor separación entre repetidores* (decenas a cientos de km).
- Aplicaciones: larga distancia, troncales metropolitanas, acceso rural, bucle de abonado (FTTH) y LAN (100 Mbps–10 Gbps).
- Modos: *multimodo de índice discreto* (muchos caminos de distinta longitud → dispersión modal, corta distancia), *multimodo de índice gradual* (el índice disminuye hacia afuera, los rayos se curvan y llegan casi a la vez; LAN) y *monomodo* (núcleo del orden de $lambda$, un solo camino; larga distancia).
- Fuentes: *LED* (barato, más vida útil, rango de temperatura amplio) e *ILD* (láser: más eficiente y rápido).
- Ventanas de transmisión: 850 nm (multimodo, LAN), 1300 nm (monomodo), 1550 nm (banda C, WDM) y 1590 nm (banda L). Las pérdidas son menores a mayor longitud de onda.

#fig("fig-4-4.png", [Modos de propagación en fibra óptica.], fuente: "Stallings, Fig. 4.4, p. 107", ancho: 55%)

#ejemplo[
  $lambda = 1550$ nm en el vacío → $f = c\/lambda = 3 times 10^8 \/ 1550 times 10^(-9) = 193,4$ THz. En
  una fibra con $v = 2,04 times 10^8$ m/s la longitud de onda real es $v\/f = 1055$ nm: la frecuencia no
  cambia, la longitud de onda sí (las tablas dan $lambda$ en el vacío).
]

#fig("fig-4-3.png", [Atenuación de los medios guiados típicos en función de la frecuencia.], fuente: "Stallings, Fig. 4.3, p. 100", ancho: 60%)

== Transmisión inalámbrica (4.2)

Tres rangos: *microondas* 1–40 GHz (haces muy direccionales, punto a punto y satélite), *ondas de radio*
30 MHz–1 GHz (omnidireccionales) e *infrarrojos* $3 times 10^11$–$2 times 10^14$ Hz (local, dentro de una habitación).

=== Antenas

Conductor (o conjunto) que *radia* energía electromagnética al transmitir y la *capta* al recibir; las
características son las mismas en ambos sentidos (*reciprocidad*). *Diagrama de radiación*: potencia
radiada según la dirección. *Antena isotrópica*: punto ideal que radia igual en todas las direcciones
(diagrama esférico). *Parabólica*: la fuente en el foco produce un haz paralelo al eje; cuanto mayor el
diámetro, más direccional.

*Ganancia*: medida de *direccionalidad* (no amplifica: concentra en una dirección lo que quita de las
otras), relativa a la isotrópica (dBi). Se relaciona con el *área efectiva* $A_e$:
$ G = (4 pi A_e)/lambda^2 = (4 pi f^2 A_e)/c^2 $
Isotrópica: $A_e = lambda^2\/(4 pi)$, $G = 1$. Parabólica de área física $A$: $A_e = 0,56 A$, $G = 7A\/lambda^2$.

#ejemplo[
  Parabólica de 2 m de diámetro a 12 GHz: $A = pi r^2 = pi$ m², $lambda = 0,025$ m,
  $G = 7 pi \/ 0,025^2 = 35 186$ → $G_"dB" = 45,46$ dB.
]

=== Microondas terrestres

Parábolas de ≈ 3 m alineadas en *línea de vista*, en torres altas; enlaces encadenados para cubrir
distancias. Usos: larga distancia (alternativa a coaxial/fibra, con menos repetidores pero antenas
alineadas), enlaces cortos entre edificios, _bypass_, celulares. Bandas típicas 4–6 GHz y 11 GHz (larga
distancia), 12 GHz (CATV), 22 GHz (entre edificios). La pérdida crece con el cuadrado de la distancia
(no exponencialmente como en cables), por eso los repetidores pueden estar a 10–100 km:
$ L = 10 log ((4 pi d)/lambda)^2 "dB" $
La *lluvia* atenúa mucho por encima de 10 GHz; las *interferencias* obligan a regular las bandas.

=== Microondas por satélite

El satélite es un repetidor: recibe en una banda (*enlace ascendente*), amplifica y retransmite en otra
(*descendente*) mediante *transpondedores*. Debe ser *geoestacionario*: a ≈ 35 863 km sobre el Ecuador.
Separación mínima 4° (banda 4/6 GHz) o 3° (12/14 GHz). Rango óptimo 1–10 GHz (debajo, ruido natural;
encima, absorción atmosférica). Bandas: 4/6 GHz (descendente 3,7–4,2; ascendente 5,925–6,425), 12/14 GHz
y 20/30 GHz. Usa frecuencias distintas en cada sentido porque no puede transmitir y recibir en la misma
banda sin interferirse. *Retardo* ≈ 0,25 s estación-satélite-estación, problemático para voz y para el
control de flujo/errores; es naturalmente *multidifusión* (TV, DBS, VSAT).

#fig("fig-4-6.png", [Configuraciones satelitales: enlace punto a punto y difusión.], fuente: "Stallings, Fig. 4.6, p. 114", ancho: 40%)

=== Ondas de radio e infrarrojos

*Radio* (30 MHz–1 GHz: FM, TV VHF/UHF): omnidireccional, sin parábolas ni alineación; la ionosfera es
transparente por encima de 30 MHz; menos sensible a la lluvia; mismo modelo de pérdida que las
microondas pero menor atenuación relativa (mayor $lambda$). Problema principal: *interferencia por
multitrayectoria* (reflexiones en tierra, agua, edificios). *Infrarrojos*: luz no coherente modulada,
transceptores alineados o por reflexión (techo); *no atraviesan paredes* (seguridad, sin interferencias
entre salas) y no requieren licencia.

== Propagación inalámbrica (4.3)

#fig("fig-4-8.png", [Modos de propagación: superficial, aérea (ionosférica) y en línea de vista.], fuente: "Stallings, Fig. 4.8, p. 119", ancho: 45%)

- *Superficial (ground wave)*, hasta ≈ 2 MHz: sigue la curvatura terrestre (corrientes inducidas en el suelo y difracción); llega más allá del horizonte. Ej.: radio AM.
- *Aérea (sky wave)*, ≈ 2–30 MHz: se *refracta* en la ionosfera y vuelve a tierra en saltos; miles de km. Ej.: radioaficionados, onda corta internacional.
- *Línea de vista (LOS)*, > 30 MHz: las antenas deben verse (efectivamente: la atmósfera curva un poco las ondas hacia la tierra).

*Refracción*: cambio de dirección al cambiar la velocidad entre medios de distinta densidad (la onda se
desvía hacia el más denso). Índice de refracción $n = sin theta_i \/ sin theta_r = v_1\/v_2$ (ley de Snell:
$n_1 sin theta_1 = n_2 sin theta_2$). En la atmósfera el índice baja con la altura → las ondas se curvan hacia la tierra.

#tabla(
  columns: (auto, auto, auto, 1fr),
  [*Banda*], [*Frecuencias*], [*Propagación*], [*Uso típico*],
  [ELF / VF], [30–300 Hz / 0,3–3 kHz], [Superficial], [Líneas de potencia / bucle telefónico],
  [VLF / LF], [3–30 / 30–300 kHz], [Superficial], [Navegación, comunicaciones submarinas],
  [MF], [300–3000 kHz], [Superficial y aérea nocturna], [Radio AM, marítima],
  [HF], [3–30 MHz], [Aérea], [Radioaficionados, onda corta, militar],
  [VHF], [30–300 MHz], [LOS], [TV VHF, FM, aviación],
  [UHF], [0,3–3 GHz], [LOS], [TV UHF, celular, radar, microondas],
  [SHF], [3–30 GHz], [LOS (lluvia > 10 GHz)], [Satélite, microondas terrestres],
  [EHF], [30–300 GHz], [LOS (vapor de agua, oxígeno)], [Experimental, bucles inalámbricos],
)
#text(size: 8.5pt)[Resumen de la Tabla 4.7 de Stallings (p. 118).]

=== Distancia en línea de vista

$ d_"óptica" = 3,57 sqrt(h) quad quad d_"radio" = 3,57 sqrt(K h), K = 4\/3 quad quad d_max = 3,57 (sqrt(K h_1) + sqrt(K h_2)) $
con $d$ en km y $h$ en metros.

#ejemplo[
  Antena de 100 m y otra a nivel del suelo: $d = 3,57 sqrt(133) = 41$ km. Si la receptora está a 10 m,
  la transmisora necesita $sqrt(K h_1) = 41\/3,57 - sqrt(13","3) = 7,84$ → $h_1 = 7,84^2 \/ 1,33 = 46,2$ m
  (se ahorran 54 m de torre elevando la receptora).
]

#fig("fig-4-9.png", [Horizonte óptico y de radio.], fuente: "Stallings, Fig. 4.9, p. 121", ancho: 45%)

== Dificultades de la transmisión en línea de vista (4.4) y tipos de interferencia

*Pérdida en el espacio libre* (la señal se reparte en un área cada vez mayor; principal pérdida en
satélites). Para antenas isotrópicas:
$ L_"dB" = 10 log P_t/P_r = 20 log ((4 pi d)/lambda) = 20 log f + 20 log d - 147,56 "dB" quad (f "en Hz", d "en m") $
$ L_"dB" = 20 log f_"MHz" + 20 log d_"km" + 32,44 "dB" $
Con ganancias de antena:
$ P_t / P_r = ((4 pi)^2 d^2)/(G_r G_t lambda^2) = (lambda d)^2/(A_r A_t) = (c d)^2/(f^2 A_r A_t) $
$ L_"dB" = 20 log lambda + 20 log d - 10 log(A_t A_r) = -20 log f + 20 log d - 10 log(A_t A_r) + 169,54 "dB" $

#clave[
  Duplicar la distancia o la frecuencia agrega *6 dB* de pérdida (isotrópica). Pero con antenas de *área
  fija*, aumentar la frecuencia *reduce* la pérdida: la ganancia de las antenas crece con $f^2$.
  Balance de enlace: $P_r = P_t + G_t + G_r - L_"isotrópica"$ (todo en dB).
]

#ejemplo[
  Satélite geoestacionario a 4 GHz: $lambda = 0,075$ m, $L = -20 log 0,075 + 20 log(35","863 times 10^6) + 21,98 = 195,6$ dB.
  Con antenas de 44 dB y 48 dB: $L = 103,6$ dB. Si se transmiten 250 W (24 dBW) se reciben $24 - 103,6 = -79,6$ dBW.
]

#fig("fig-4-10.png", [Pérdida en el espacio libre en función de la distancia y la frecuencia.], fuente: "Stallings, Fig. 4.10, p. 123", ancho: 45%)

*Tipos de dificultades e interferencias en propagación inalámbrica:*

- *Absorción atmosférica*: vapor de agua (pico en 22 GHz) y oxígeno (pico en 60 GHz); lluvia y niebla dispersan (_scattering_) la señal.
- *Multitrayectoria*: reflexiones en obstáculos → llegan varias copias con distinto retardo que se suman o cancelan (*desvanecimiento*), *ISI* y "fantasmas" en TV. Grave en comunicaciones móviles.
- *Refracción* anómala: condiciones meteorológicas pueden desviar el haz y que no llegue a la antena.
- *Reflexión* (superficies grandes), *difracción* (bordes de obstáculos, permite recibir sin línea de vista) y *dispersión* (objetos menores que $lambda$: follaje, señales).
- *Interferencia* de otras fuentes: *cocanal* (mismo canal, otra celda o red), *de canal adyacente* (bandas próximas mal filtradas), *intermodulación* y *EMI/RFI* (motores, hornos de microondas en 2,4 GHz). Por eso el espectro se *regula* y se asignan bandas; en bandas libres (ISM) no hay protección legal.

#fig("fig-4-11.png", [Interferencias por multitrayectoria en microondas fijas y en radio móvil.], fuente: "Stallings, Fig. 4.11, p. 125", ancho: 45%)

== Unidades de medida

#tabla(
  columns: (auto, 1fr),
  [*Magnitud*], [*Unidad y relaciones útiles*],
  [Frecuencia / periodo], [Hz = ciclos/s; $T = 1\/f$; k = $10^3$, M = $10^6$, G = $10^9$, T = $10^12$.],
  [Longitud de onda], [$lambda = c\/f$; 300 MHz ↔ 1 m; 3 GHz ↔ 10 cm; 1550 nm ↔ 193 THz.],
  [Velocidad de datos], [bps (bits/s); en comunicaciones k = 1000 (no 1024). 1 byte = 8 bits.],
  [Velocidad de modulación], [baudios = símbolos/s; $R = D log_2 M$.],
  [Ganancia / pérdida], [dB = $10 log(P_2\/P_1)$ = $20 log(V_2\/V_1)$; atenuación de cables en dB/km o dB/100 m.],
  [Potencia absoluta], [dBW (ref. 1 W), dBm (ref. 1 mW): $"dBm" = "dBW" + 30$; 1 W = 30 dBm; 1 mW = 0 dBm; 100 mW = 20 dBm.],
  [Tensión absoluta], [dBmV (ref. 1 mV, 75 Ω), dBµV.],
  [Ganancia de antena], [dBi (respecto de la isotrópica); dBd (respecto del dipolo, dBi = dBd + 2,15).],
  [Densidad de ruido], [W/Hz o dBW/Hz; $N_0 = k T$ = −204 dBW/Hz a 290 K.],
  [Retardo de propagación], [$t = d\/v$; en cobre/fibra $v approx 2 times 10^8$ m/s (5 µs/km).],
)

== Guía de cuestiones de repaso (Cap. 4)

#pr("4.1")[¿Por qué dos cables en un par trenzado?][Uno es el camino de ida y otro el de retorno del circuito; al trenzarlos las interferencias inducidas en ambos se cancelan (modo diferencial).]
#pr("4.2")[Limitaciones del par trenzado.][Menor ancho de banda, velocidad y distancia; atenuación fuertemente creciente con la frecuencia; sensible a interferencias, diafonía y ruido impulsivo.]
#pr("4.3")[UTP vs STP.][STP tiene una malla metálica que reduce interferencias y permite más velocidad; UTP es más barato, flexible y fácil de instalar.]
#pr("4.4")[Componentes de la fibra.][Núcleo (vidrio o plástico por donde viaja la luz), revestimiento (menor índice de refracción, confina la luz) y cubierta (protección mecánica y contra humedad).]
#pr("4.5")[Ventajas y desventajas de las microondas.][Ventajas: gran ancho de banda, menos repetidores que el cable, sin tendido físico. Desventajas: línea de vista y alineación, atenuación por lluvia sobre 10 GHz, interferencias y necesidad de licencias.]
#pr("4.6")[¿Qué es DBS?][Difusión directa por satélite: la señal de TV va del satélite directamente a las antenas pequeñas de los hogares.]
#pr("4.7")[¿Por qué frecuencias ascendentes y descendentes distintas?][Para que la señal que retransmite el satélite (potente) no interfiera con la que recibe (muy débil): no puede transmitir y recibir en la misma banda en forma continua.]
#pr("4.8")[Radio vs microondas.][Radio (30 MHz–1 GHz) es omnidireccional, sin alineación, menos afectada por la lluvia; microondas son direccionales, punto a punto, con antenas parabólicas alineadas.]
#pr("4.9")[Dos funciones de una antena.][Radiar energía electromagnética (transmitir) y captarla (recibir).]
#pr("4.10")[¿Qué es una antena isotrópica?][Una antena ideal (un punto) que radia igual potencia en todas las direcciones; referencia para la ganancia.]
#pr("4.11")[Ventaja de la parabólica.][Concentra la energía en un haz muy direccional (alta ganancia) y en recepción concentra en el foco la señal que llega paralela al eje.]
#pr("4.12")[Factores que determinan la ganancia.][El área efectiva (tamaño y forma) y la frecuencia/longitud de onda: $G = 4 pi A_e \/ lambda^2$.]
#pr("4.13")[Principal causa de pérdida en satélite.][La pérdida en el espacio libre (dispersión con la distancia).]
#pr("4.14")[¿Qué es la refracción?][El cambio de dirección de una onda al pasar entre medios en los que su velocidad es distinta.]
#pr("4.15")[Difracción vs dispersión.][Difracción: la onda se curva al pasar por el borde de un obstáculo grande comparado con $lambda$ (aparecen fuentes secundarias). Dispersión (_scattering_): la onda choca con objetos pequeños comparados con $lambda$ y se reparte en muchas direcciones más débiles.]

== Guía de ejercicios (Cap. 4)

#pr("4.1")[Avión con 10⁴ kg de disquetes de 1,4 MB y 30 g, 5000 km a 1000 km/h.][$10^4\/0,03 = 333 333$ disquetes × $1,4 times 10^6 times 8$ bits $= 3,73 times 10^12$ bits en 5 h = 18 000 s → ≈ 207 Mbps.]
#pr("4.2")[Línea con 20 dB de pérdida, 0,5 W de entrada y 4,5 µW de ruido.][Señal de salida 0,5 W × 0,01 = 5 mW; SNR = 5 mW / 4,5 µW = 1111 → 30,5 dB.]
#pr("4.3")[Fuente de 100 W, se necesita 1 W.][Se toleran 20 dB de pérdida: $d = 20 "dB" \/ alpha$, leyendo $alpha$ (dB/km) de la Fig. 4.3 para cada medio y frecuencia; la fibra (≈ 0,2 dB/km a 1550 nm) alcanza ≈ 100 km.]
#pr("4.4")[¿Para qué conectar a tierra la malla del coaxial?][Funciona como blindaje: drena las interferencias externas y evita que el cable irradie; da una referencia de potencial común.]
#pr("4.5")[Duplicar frecuencia o distancia → −6 dB.][$L = 20 log(4 pi f d \/ c)$: duplicar $f$ o $d$ suma $20 log 2 = 6,02$ dB.]
#pr("4.6")[Antena de media onda a 30 Hz.][$lambda = c\/f = 10^7$ m → $lambda\/2 = 5000$ km.]
#pr("4.7")[Voz a 300 Hz.][(a) $lambda = 10^6$ m → antena de 500 km. (b) Antena de 1 m = $lambda\/2$ → $lambda = 2$ m → $f = 150$ MHz.]
#pr("4.8")[Empaste de 2,5 mm como antena de media onda.][$lambda = 5$ mm → $f = 60$ GHz.]
#pr("4.9")[¿Duplicar la frecuencia o el área efectiva de ambas antenas?][Con $P_r\/P_t = f^2 A_r A_t \/ (c d)^2$: duplicar $f$ → ×4 (6 dB); duplicar ambas áreas → ×4 (6 dB). Igual mejora; haciendo las dos, 12 dB.]
#pr("4.10")[Tabla radio vs cable.][Radio (−6 dB a 1 km, +6 dB cada vez que se duplica $d$): −6, −12, −18, −24, −30 dB. Cable (−3 dB/km, lineal): −3, −6, −12, −24, −48 dB.]
#pr("4.11")[Propiedad de la parábola.][Con $y^2 = 2 p x$ (foco en $(p\/2, 0)$): derivando, la pendiente de la tangente en $P$ es $p\/y_1 = tan beta$. Con la fórmula de la tangente de la diferencia entre la pendiente de $P F$ y la de $M$ se obtiene $tan alpha = p\/y_1$, luego $alpha = beta$ y el rayo reflejado es paralelo al eje.]
#pr("4.12")[Ecuación de pérdida con km y MHz.][$L_"dB" = 20 log f_"MHz" + 20 log d_"km" + 32,44$.]
#pr("4.13")[Transmisor de 50 W.][(a) 17 dBW = 47 dBm. (b) 900 MHz, 100 m: $L = 59,1 - 20 + 32,44 = 71,5$ dB → $P_r = -24,5$ dBm. (c) 10 km: +40 dB → −64,5 dBm. (d) $G_r = 2$ (+3 dB) → −61,5 dBm.]
#pr("4.14")[0,1 W a 2 GHz, parábolas de 1,2 m, 24 km.][(a) $lambda = 0,15$ m, $A = 1,131$ m², $G = 7A\/lambda^2 = 352$ → 25,5 dB. (b) PIRE = 0,1 × 352 = 35,2 W (45,5 dBm). (c) $L = 20 log 2000 + 20 log 24 + 32,44 = 126,1$ dB → $P_r = 20 + 25,5 + 25,5 - 126,1 = -55,1$ dBm.]
#pr("4.15")[Deducir $d = 3,57 sqrt(h)$.][Triángulo rectángulo con la tangente: $(R + h)^2 = R^2 + d^2$ → $d approx sqrt(2 R h)$; con $R = 6370$ km y $h$ en metros: $d = sqrt(12","74 h) = 3,57 sqrt(h)$ km.]
#pr("4.16")[Antena de TV para 80 km.][Radio: $h = (80\/3,57)^2\/(4\/3) = 377$ m (óptico: 502 m).]
#pr("4.17")[Luz del aire al agua a 30° del horizonte.][Ángulo de incidencia 60° respecto de la normal: $sin theta_2 = 1,0003 sin 60° \/ 1,333 = 0,65$ → $theta_2 = 40,5°$ de la normal, o sea 49,5° respecto del horizonte.]
