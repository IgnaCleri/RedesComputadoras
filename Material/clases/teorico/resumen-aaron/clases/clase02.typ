#import "../lib.typ": *

= Clase 2 (10/8) — Transmisión de datos y teoría de la información

#lectura[
  [STA] Parte II, *Capítulo 3*: 3.1 Conceptos y terminología · 3.2 Transmisión de datos analógicos y
  digitales · 3.3 Dificultades en la transmisión (atenuación, distorsión de retardo, ruido).
  Para los temas del programa que van más allá de la lectura sugerida se usan: 3.4 Capacidad del
  canal (Shannon-Hartley), Apéndice 3A (decibelios), 6.1 (transmisión asíncrona y síncrona),
  5.1–5.2 (codificación y modulación) y 8.1–8.3 (multiplexación). La entropía no está en Stallings
  (se resume de teoría de la información clásica).
]

== Conceptos y terminología (3.1)

- *Medio guiado* (par trenzado, coaxial, fibra): la onda viaja confinada en un camino físico. *No guiado* (inalámbrico): aire, agua, vacío.
- *Enlace directo*: sin dispositivos intermedios salvo amplificadores o repetidores. *Punto a punto*: solo dos dispositivos comparten el medio; *multipunto*: más de dos.
- *Simplex* (un solo sentido), *half-duplex* (ambos sentidos pero no a la vez), *full-duplex* (ambos a la vez). En la terminología UIT-T "simplex" = half-duplex y "dúplex" = full-duplex.

=== Dominio del tiempo

Señal *analógica*: varía suavemente, sin discontinuidades. *Digital*: se mantiene constante un
intervalo y salta a otro nivel. *Periódica*: $s(t+T) = s(t)$ para todo $t$; $T$ es el periodo (el menor que cumple).

$ s(t) = A sin(2 pi f t + phi) $

- $A$: *amplitud de pico* (V). $f$: *frecuencia* (Hz); $T = 1\/f$. $phi$: *fase* (posición relativa dentro del periodo; $2 pi "rad" = 360° = 1$ periodo).
- *Longitud de onda* $lambda$: distancia que ocupa un ciclo. $lambda = v T$, o sea $lambda f = v$. En el vacío $v = c approx 3 times 10^8$ m/s.

#fig("fig-3-3.png", [Efecto de variar $A$, $f$ y $phi$ en $s(t) = A sin(2 pi f t + phi)$.], fuente: "Stallings, Fig. 3.3, p. 62", ancho: 65%)

=== Dominio de la frecuencia

Por análisis de Fourier *toda señal es suma de senoidales* de distintas amplitudes, frecuencias y fases.

- Si todas las componentes son múltiplos de una frecuencia, esta es la *frecuencia fundamental*; el periodo de la señal es el de la fundamental.
- *Espectro*: conjunto de frecuencias que contiene la señal. *Ancho de banda absoluto*: anchura del espectro. *Ancho de banda efectivo* (o simplemente ancho de banda): banda donde se concentra la mayor parte de la energía.
- *Componente continua (DC)*: componente de frecuencia cero; hace que el valor medio sea distinto de cero.

Una onda cuadrada de amplitud $plus.minus A$ y frecuencia $f$:
$ s(t) = A times 4/pi sum_(k "impar", k=1)^infinity sin(2 pi k f t)/k $
tiene ancho de banda infinito, pero la armónica $k$ tiene amplitud $1\/k$: casi toda la energía está en las primeras armónicas.

#fig("fig-3-7.png", [Aproximación de la onda cuadrada sumando armónicas impares ($f$, $3f$, $5f$, $7f$, …).], fuente: "Stallings, Fig. 3.7, p. 67", ancho: 45%)

=== Relación entre velocidad de transmisión y ancho de banda

Representando 0101… con la onda cuadrada, cada bit dura $1\/(2f)$ → velocidad $2f$ bps.

#tabla(
  columns: 4, align: center,
  [*Caso*], [*Componentes que pasan*], [*Ancho de banda*], [*Velocidad*],
  [I], [$f, 3f, 5f$ con $f = 1$ MHz], [$5f - f = 4$ MHz], [2 Mbps],
  [II], [$f, 3f, 5f$ con $f = 2$ MHz], [8 MHz], [4 Mbps],
  [III], [$f, 3f$ con $f = 2$ MHz], [4 MHz], [4 Mbps],
)

#clave[
  - Duplicar el ancho de banda duplica la velocidad posible (I → II).
  - Un mismo ancho de banda admite distintas velocidades según cuánta distorsión tolere el receptor (I vs III).
  - Limitar el ancho de banda abarata pero distorsiona → más errores. Con $W$ bps se logra muy buena representación con $2W$ Hz, aunque con menos alcanza si el ruido es bajo.
  - Cuanto mayor la frecuencia central, mayor el ancho de banda potencial.
]

#fig("fig-3-8.png", [Efecto del ancho de banda sobre una señal digital de 2000 bps.], fuente: "Stallings, Fig. 3.8, p. 69", ancho: 38%)

== Datos y señales analógicos y digitales (3.2)

*Dato*: entidad que transporta información. *Señal*: su representación eléctrica o
electromagnética. *Señalización*: propagación física de la señal. *Transmisión*: comunicación de
datos mediante propagación y procesamiento de señales.

- *Voz*: componentes de 100 Hz a 7 kHz (rango dinámico ≈ 25 dB); la telefonía usa *300–3400 Hz*, suficiente para inteligibilidad.
- *Video* (NTSC): 525 líneas a 30 cuadros/s (483 visibles), entrelazado (60 campos/s). Cálculo del ancho de banda: resolución vertical subjetiva 0,7 × 483 ≈ 338; horizontal 4/3 × 338 ≈ 450 elementos por línea; 52,5 µs útiles por línea → 450/2 = 225 ciclos en 52,5 µs → $f_max approx 4,2$ MHz → ancho de banda ≈ 4 MHz.
- *Datos binarios*: código IRA/ASCII de 7 bits (128 caracteres) + bit de paridad (par o impar) que detecta un número impar de bits erróneos.

#fig("fig-3-14.png", [Señalización analógica y digital de datos analógicos y digitales: módem y codec.], fuente: "Stallings, Fig. 3.14, p. 75", ancho: 55%)

#tabla(
  columns: (auto, 1fr, 1fr),
  [], [*Señal analógica*], [*Señal digital*],
  [*Datos analógicos*], [Mismo espectro (teléfono) o desplazados a otra banda (modulación)], [Codificados por un *codec* (ej. PCM)],
  [*Datos digitales*], [Codificados por un *módem* (modulan una portadora)], [Dos niveles de tensión o un código de línea con propiedades deseadas],
)

*Transmisión analógica*: ignora el contenido; usa *amplificadores*, que también amplifican el ruido
→ el ruido se *acumula*. Tolerable para voz, no para datos. *Transmisión digital*: depende del
contenido; usa *repetidores* que recuperan los bits y regeneran una señal limpia → el ruido *no se
acumula*. Ventajas de lo digital: tecnología LSI/VLSI barata, integridad de datos, mejor uso de la
capacidad (TDM), seguridad (cifrado) e integración de voz, video y datos.

Señalización digital: más barata y menos sensible al ruido, pero sufre más la atenuación (las altas
frecuencias se atenúan y los pulsos se redondean).

== Dificultades en la transmisión (3.3)

=== Atenuación y distorsión de atenuación

La energía decae con la distancia; en medios guiados *exponencialmente* → se expresa en *dB/km*. Tres
consideraciones: (1) la señal debe llegar con energía suficiente para detectarse, (2) debe superar
suficientemente al ruido, (3) la atenuación *crece con la frecuencia*. (1) y (2) se resuelven con
amplificadores/repetidores; (3) distorsiona señales analógicas y se combate con *ecualización*
(bobinas de carga, amplificadores que refuerzan altas frecuencias). Atenuación relativa a 1 kHz:
$ N_f = -10 log_10 (P_f / P_1000) quad ["dB"] $

=== Distorsión de retardo

La velocidad de propagación en medios guiados varía con la frecuencia (mayor cerca del centro de la
banda): las componentes llegan en distintos instantes → parte de un bit se corre a los vecinos →
*interferencia entre símbolos (ISI)*. Es el factor que limita la velocidad máxima; también se
compensa con ecualización.

#fig("fig-3-15.png", [Atenuación y retardo relativos en un canal de voz, con y sin ecualización.], fuente: "Stallings, Fig. 3.15, p. 79", ancho: 35%)

=== Ruido

Señales no deseadas que se suman entre emisor y receptor; es *el principal limitante* de las prestaciones.

- *Térmico* (blanco): agitación de electrones, uniforme en frecuencia, no se puede eliminar. Densidad $N_0 = k T$ (W/Hz), con $k = 1,38 times 10^(-23)$ J/K y $T$ en kelvin. En un ancho de banda $B$:
  $ N = k T B quad <==> quad N_"dBW" = -228,6 + 10 log T + 10 log B $
- *Intermodulación*: no linealidades al compartir el medio señales de $f_1$ y $f_2$ → aparecen $f_1 + f_2$, $f_1 - f_2$, múltiplos.
- *Diafonía* (_crosstalk_): acoplamiento no deseado entre líneas cercanas (pares, antenas). Del orden del ruido térmico o menor.
- *Impulsivo*: picos cortos e irregulares de gran amplitud (tormentas, fallas). Poco dañino para voz, *principal fuente de errores en datos*: un pico de 0,01 s a 56 kbps arruina ≈ 560 bits.

#ejemplo[
  $T = 290$ K: $N_0 = 1,38 times 10^(-23) times 290 = 4 times 10^(-21)$ W/Hz $= -204$ dBW/Hz. \
  Receptor con $T = 294$ K y $B = 10$ MHz: $N = -228,6 + 24,7 + 70 = -133,9$ dBW.
]

#fig("fig-3-16.png", [Efecto del ruido sobre una señal digital: aparecen bits erróneos.], fuente: "Stallings, Fig. 3.16, p. 83", ancho: 50%)

== Capacidad del canal (3.4)

Capacidad = velocidad máxima de datos en un canal bajo condiciones dadas. Intervienen: velocidad de
datos (bps), ancho de banda (Hz), ruido y tasa de errores.

=== Nyquist (canal sin ruido)

Con ancho de banda $B$ la máxima velocidad de *señalización* es $2B$ (la limita la ISI). Con $M$ niveles:
$ C = 2 B log_2 M $
Ejemplo: $B = 3100$ Hz → binario $C = 6200$ bps; con $M = 8$, $C = 18 600$ bps. Más niveles → más
velocidad, pero el receptor debe distinguir entre $M$ señales: el ruido limita $M$.

=== Shannon-Hartley (canal con ruido blanco)

$ "SNR"_"dB" = 10 log_10 ("potencia de señal" / "potencia de ruido") quad quad C = B log_2 (1 + "SNR") $

- $C$ es la *capacidad libre de errores*: si la velocidad real es menor que $C$ existe una codificación que permite transmitir sin errores (el teorema no dice cuál).
- Es un *límite teórico*: supone solo ruido térmico, sin ruido impulsivo ni distorsiones.
- Subir la potencia aumenta la intermodulación; subir $B$ mete más ruido blanco ($N = k T B$) y baja la SNR.
- Para usarla, la SNR va *en veces*, no en dB: $"SNR" = 10^("SNR"_"dB"\/10)$.

#ejemplo[
  Canal entre 3 y 4 MHz con $"SNR"_"dB" = 24$ dB: $B = 1$ MHz, $"SNR" = 10^(2,4) = 251$,
  $C = 10^6 log_2(252) approx 8$ Mbps. Niveles necesarios por Nyquist: $8 times 10^6 = 2 times 10^6 log_2 M$ → $M = 16$.
]

=== El cociente $E_b \/ N_0$

Energía por bit $E_b = S T_b = S\/R$ sobre densidad de ruido $N_0 = k T$; no depende del ancho de banda
(a diferencia de la SNR). La tasa de error por bit es función decreciente de $E_b\/N_0$.
$ E_b / N_0 = S / (k T R) quad quad (E_b / N_0)_"dB" = S_"dBW" - 10 log R + 228,6 - 10 log T $
$ E_b / N_0 = S / N dot B_T / R quad quad E_b / N_0 = B / C (2^(C\/B) - 1) $

#ejemplo[
  BPSK necesita $E_b\/N_0 = 8,4$ dB para BER $= 10^(-4)$. Con $T = 290$ K y $R = 2400$ bps:
  $8,4 = S - 33,8 + 228,6 - 24,6$ → $S = -161,8$ dBW. \
  Para eficiencia espectral $C\/B = 6$ bps/Hz: $E_b\/N_0 = (1\/6)(2^6 - 1) = 10,5 = 10,21$ dB.
]

== Teoría de la información: entropía

#extra[
  *Información propia* de un símbolo de probabilidad $p_i$: $I_i = -log_2 p_i$ bits (lo improbable
  informa más). *Entropía* de una fuente sin memoria = información media por símbolo:
  $ H = - sum_(i=1)^N p_i log_2 p_i quad ["bits/símbolo"], quad 0 <= H <= log_2 N $
  El máximo $log_2 N$ se alcanza con símbolos equiprobables. Si la fuente emite $r$ símbolos/s, la
  *tasa de información* es $R = r H$ bps. El *teorema de codificación de fuente* dice que no se puede
  codificar con menos de $H$ bits/símbolo en promedio (compresión), y el *teorema de canal* de Shannon
  dice que si $R < C$ se puede transmitir con error arbitrariamente pequeño y si $R > C$ no.

  Ejemplo: 4 símbolos con $p = 1\/2, 1\/4, 1\/8, 1\/8$:
  $H = 0,5 dot 1 + 0,25 dot 2 + 2 dot 0,125 dot 3 = 1,75$ bits/símbolo (vs. 2 bits con código fijo).
  Una fuente binaria con $p = 0,5$ tiene $H = 1$; con $p = 0,9$, $H approx 0,47$.
]

== Decibelios y unidades de potencia (Apéndice 3A)

$ G_"dB" = 10 log_10 (P_"sal" / P_"ent") quad quad L_"dB" = 10 log_10 (P_"ent" / P_"sal") quad quad G_"dB" = 20 log_10 (V_"sal" / V_"ent") $

- Las ganancias y pérdidas en cascada se *suman/restan*. 3 dB ≈ ×2; 10 dB = ×10; −3 dB = mitad.
- Unidades absolutas: $P_"dBW" = 10 log(P\/1 "W")$; $P_"dBm" = 10 log(P\/1 "mW")$ → $0 "dBW" = 30 "dBm"$; $"dBmV" = 20 log(V\/1 "mV")$ (TV por cable, 75 Ω).

#ejemplo[
  4 mW → línea de −12 dB → amplificador +35 dB → línea −10 dB: neto +13 dB →
  $P_"sal" = 4 times 10^(1,3) = 79,8$ mW. Una caída de 10 mW a 5 mW es una pérdida de 3 dB
  (igual que de 1000 W a 500 W: el dB es relativo).
]

== Transmisión asíncrona y síncrona (Stallings 6.1)

El receptor debe muestrear cada bit en su centro; si su reloj difiere del emisor, el error se acumula
(1 % de desfase → error tras ≈ 50 bits).

#grid(columns: (1fr, 1fr), gutter: 10pt,
  [
    *Asíncrona* (carácter a carácter): línea en reposo = 1; *bit de comienzo* = 0; 5–8 bits de datos
    (primero el menos significativo); paridad opcional; *elemento de parada* = 1 de 1, 1,5 o 2 bits.
    El receptor se resincroniza en cada carácter → tolera ≈ 5 % de desfase con 8 bits.
    Simple y barata pero con *sobrecarga* ≥ 20 % (8 datos + 1 inicio + 1 parada → 2/10).
    Errores de *delimitación de trama* si un bit se lee mal como inicio.
  ],
  [
    *Síncrona* (bloques): bloques largos sin bits de inicio/parada; los relojes se sincronizan por una
    línea de reloj aparte o *embebiendo el reloj en la señal* (Manchester). La *trama* lleva
    preámbulo o *delimitador* (_flag_), campos de control, datos y delimitador final. HDLC usa 48 bits de
    control: con 1000 caracteres la sobrecarga es $48\/8048 = 0,6$ %.
  ],
)

#fig("fig-6-1.png", [Transmisión asíncrona: formato de carácter, cadena y efecto de un error de temporización.], fuente: "Stallings, Fig. 6.1, p. 180", ancho: 55%)

== Codificación digital (datos digitales → señal digital)

#fig("fig-5-2.png", [Códigos de línea: NRZ-L, NRZI, AMI bipolar, pseudoternario, Manchester y Manchester diferencial.], fuente: "Stallings, Fig. 5.2, p. 138", ancho: 40%)

- *NRZ-L*: nivel fijo por bit; sin transiciones en rachas largas → pierde sincronismo y tiene componente DC.
- *NRZI*: 1 = transición al comienzo del bit, 0 = sin transición (codificación diferencial).
- *AMI bipolar*: 0 = sin pulso, 1 = pulso alternando polaridad (sin DC, detecta errores). *Pseudoternario*: al revés.
- *Manchester*: transición en la *mitad de cada bit* (Stallings e IEEE 802.3: 0 = alto→bajo, 1 = bajo→alto; los apuntes de clase usan la convención opuesta de G. E. Thomas, 0 = subida). El reloj viaja con los datos, no hay DC; necesita el doble de ancho de banda. Lo usa Ethernet de 10 Mbps.
- *Manchester diferencial*: siempre transición a mitad de bit; 0 = transición al comienzo, 1 = sin transición.

*Velocidad de modulación* $D$ (baudios) = elementos de señal por segundo. Si cada elemento lleva
$L = log_2 M$ bits: $D = R \/ L$. Ejemplo: módem de 9600 bps con 16 estados (4 bits) → 2400 baudios.
En Manchester $D = 2R$.

== Modulación (datos digitales → señal analógica, Stallings 5.2)

Se varía un parámetro de una *portadora* $A cos(2 pi f_c t)$; la señal ocupa una banda centrada en $f_c$.

#fig("fig-5-7.png", [Modulación de datos digitales: ASK, BFSK y BPSK.], fuente: "Stallings, Fig. 5.7, p. 147", ancho: 50%)

- *ASK*: 1 = portadora presente, 0 = ausencia. Sensible a cambios de ganancia, ineficaz (≤ 1200 bps en línea telefónica). Se usa en fibra óptica (luz/no luz).
- *FSK*: dos frecuencias $f_1$, $f_2$ alrededor de $f_c$. Menos sensible a errores que ASK. *MFSK*: $M$ frecuencias $f_i = f_c + (2i - 1 - M) f_d$; cada tono dura $T_s = L T$ y ocupa $W_d = 2 M f_d$.
- *PSK*: la fase codifica el bit. BPSK: $s(t) = A d(t) cos(2 pi f_c t)$ con $d = plus.minus 1$. *DPSK*: 1 = invertir la fase respecto del anterior (no necesita referencia de fase). *QPSK*: 4 fases ($plus.minus pi\/4$, $plus.minus 3pi\/4$) → 2 bits por símbolo.
- *QAM*: combinación de ASK y PSK: dos portadoras en cuadratura (cos y sen) moduladas en amplitud independientemente: $s(t) = d_1(t) cos 2 pi f_c t + d_2(t) sin 2 pi f_c t$. 4-QAM ≡ QPSK; 16-QAM lleva 4 bits por símbolo.

#tabla(
  columns: (auto, 1fr), align: (left, center),
  [*Esquema*], [*Ancho de banda de transmisión* ($0 < r < 1$ depende del filtrado)],
  [ASK, PSK], [$B_T = (1 + r) R$],
  [FSK], [$B_T = 2 Delta F + (1 + r) R$, con $Delta F = f_2 - f_c = f_c - f_1$],
  [MPSK], [$B_T = ((1 + r)/(log_2 M)) R$],
  [MFSK], [$B_T = ((1 + r) M)/(log_2 M) R$],
  [Digital NRZ], [$B_T = 0,5 (1 + r) D$],
)

La *eficiencia espectral* es $R\/B_T$: multinivel PSK/QAM la mejora (a costa de mayor BER para igual
$E_b\/N_0$); en MFSK ocurre lo contrario. BPSK/DPSK son ≈ 3 dB mejores que ASK/BFSK.

*Datos analógicos sobre portadora analógica* (Stallings 5.4): AM $s(t) = [1 + n_a x(t)] cos 2 pi f_c t$
ocupa $2B$ (dos bandas laterales; SSB usa una); FM y PM ocupan más ancho de banda (regla de Carson
$B_T = 2(beta + 1) B$) pero son más robustas frente al ruido. Datos analógicos → señal digital: PCM
(muestreo a $2 f_max$ por Nyquist; voz: 8000 muestras/s × 8 bits = 64 kbps).

== Multiplexación (Stallings 8.1–8.3)

Varias fuentes comparten un enlace de mayor capacidad (más barato por bps). Un *multiplexor* combina
$n$ entradas y un *demultiplexor* las separa.

#fig("fig-8-2.png", [FDM y TDM: reparto del canal en frecuencia o en tiempo.], fuente: "Stallings, Fig. 8.2, p. 252", ancho: 28%)

- *FDM*: cada señal se modula con una *subportadora* distinta; canales separados por *bandas de guarda*. La señal compuesta es analógica; $B >= sum B_i$. Problemas: diafonía e intermodulación. Ejemplos: radio, TV por cable (canales de 6 MHz), jerarquía telefónica (grupo = 12 canales de 4 kHz = 48 kHz en 60–108 kHz; supergrupo = 60; grupo maestro = 600). *WDM*: FDM en fibra con varias longitudes de onda (DWDM: espaciado ≤ 200 GHz).
- *TDM síncrona*: el tiempo se divide en *tramas* con *ranuras* *preasignadas* a cada fuente (aunque no tenga datos). Velocidad del enlace $>=$ suma de las entradas. Entrelazado de bits o de caracteres. "Síncrona" porque las ranuras son fijas. Ejemplo: DS-1/T1 = 24 canales × 8 bits + 1 bit de trama = 193 bits × 8000 tramas/s = 1,544 Mbps.
- *TDM estadística* (asíncrona, inteligente): asigna ranuras *dinámicamente* solo a quien tiene datos; cada dato lleva dirección; el enlace puede tener menos capacidad que la suma de las entradas; requiere memoria temporal (buffers) y hay retardo variable.

== Guía de cuestiones de repaso (Cap. 3)

#pr("3.1")[¿Diferencia entre medio guiado y no guiado?][Guiado: la onda viaja confinada (par, coaxial, fibra). No guiado: se emite con una antena al aire/agua/vacío sin confinarla.]
#pr("3.2")[¿Diferencia entre señal analógica y digital?][Analógica: varía continuamente; digital: niveles constantes por intervalos con saltos discretos.]
#pr("3.3")[Tres características de una señal periódica.][Amplitud, frecuencia (o periodo) y fase.]
#pr("3.4")[¿Cuántos radianes hay en 360°?][$2 pi$.]
#pr("3.5")[Relación entre longitud de onda y frecuencia.][$lambda = v\/f$ (en el vacío $lambda f = c$).]
#pr("3.6")[Relación entre espectro y ancho de banda.][El espectro es el rango de frecuencias que contiene la señal; el ancho de banda (absoluto) es su anchura; el efectivo es la banda que concentra la mayor parte de la energía.]
#pr("3.7")[¿Qué es la atenuación?][Pérdida de energía de la señal con la distancia (exponencial en medios guiados, en dB/km), creciente con la frecuencia.]
#pr("3.8")[Defina capacidad de un canal.][Máxima velocidad (bps) a la que se pueden transmitir datos por el canal en condiciones dadas.]
#pr("3.9")[Factores que afectan la capacidad.][Ancho de banda, ruido (SNR), tasa de errores tolerable y número de niveles de señal.]

== Guía de ejercicios (Cap. 3)

#pr("3.1")[Configuración multipunto; centralizado vs descentralizado.][(a) El medio es compartido: si transmiten dos a la vez, las señales se superponen y se pierden. (b) Centralizado: simple y con control de prioridades, pero punto único de falla y cuello de botella; descentralizado: robusto, pero lógica más compleja en cada estación.]
#pr("3.2")[Fundamental de 1000 Hz, ¿periodo?][$T = 1\/1000 = 1$ ms.]
#pr("3.3")[Simplificar.][(a) $sin(2 pi f t - pi) + sin(2 pi f t + pi) = -2 sin(2 pi f t)$. (b) $sin 2 pi f t + sin(2 pi f t - pi) = 0$.]
#pr("3.4")[Longitud de onda de las notas ($v = 330$ m/s).][$lambda = 330\/f$: DO 1,25 m · RE 1,11 · MI 1,00 · FA 0,94 · SOL 0,83 · LA 0,75 · SI 0,67 · DO 0,625 m. Las frecuencias crecen y $lambda$ decrece; el DO agudo tiene el doble de frecuencia (octava).]
#pr("3.6")[$(1 + 0,1 cos 5t) cos 100t$.][$= cos 100t + 0,05 cos 105t + 0,05 cos 95t$: amplitudes 1; 0,05; 0,05, frecuencias angulares 100, 105 y 95 rad/s ($f = omega\/2 pi$), fase 0.]
#pr("3.7")[Periodo de $(10 cos t)^2$.][$= 50 + 50 cos 2t$ → $T = pi$.]
#pr("3.8")[¿Es periódica $f_1 + f_2$?][Solo si $T_1\/T_2$ es racional; entonces $T = $ mínimo común múltiplo de $T_1$ y $T_2$.]
#pr("3.9")[¿Y si se dejan solo las armónicas altas?][Se pierde la fundamental: quedan picos/oscilaciones en las transiciones y una señal casi nula en los tramos planos; ya no se parece a la cuadrada.]
#pr("3.10")[Pulso con infinitas frecuencias: implicaciones.][Ningún sistema real transmite ancho de banda infinito: la señal llega distorsionada (redondeada, con ISI) y hay que elegir un ancho de banda que permita al receptor decidir con baja tasa de error.]
#pr("3.11")[TTS de 6 bits con ≈ 100 caracteres.][Con caracteres de cambio (_shift_ letras/cifras, mayúsculas/minúsculas) que cambian la interpretación de los siguientes códigos: 2 × 64 combinaciones.]
#pr("3.12")[Video con 5 MHz.][Horizontal: $5 times 10^6 times 52,5 times 10^(-6) = 262,5$ ciclos → 525 elementos por línea (antes 450, +17 %). Vertical: el ancho de banda crece en 5/4,2 ≈ 1,19 → ≈ 19 % más líneas manteniendo 450 elementos por línea.]
#pr("3.13")[TV digitalizada.][(a) $R = 480 times 500 times log_2 32 times 30 = 36$ Mbps. (b) $C = 4,5 times 10^6 log_2(1 + 10^(3,5)) = 52,3$ Mbps. (c) Para color, repartir los bits por punto (menos niveles de luminancia, submuestrear color) o bajar resolución o cuadros/s.]
#pr("3.14")[$T = 10 000$ K, $B = 10$ MHz.][$N = -228,6 + 40 + 70 = -118,6$ dBW.]
#pr("3.15")[Teletipo: $B = 300$ Hz, SNR = 3 dB.][SNR ≈ 2 → $C = 300 log_2 3 approx 475$ bps.]
#pr("3.16")[9600 bps con palabras de 4 y 8 bits por elemento.][Nyquist $B = C\/(2 log_2 M)$: (a) $M = 16$ → 1200 Hz; (b) $M = 256$ → 600 Hz.]
#pr("3.17")[$B = 10$ kHz a 50 °C.][$T = 323$ K: $N = k T B = 4,46 times 10^(-17)$ W $= -163,5$ dBW (los 1000 W no influyen).]
#pr("3.18")[Relacionar Nyquist y Shannon.][Igualando $2B log_2 M = B log_2(1 + "SNR")$ → $M = sqrt(1 + "SNR")$: la SNR fija cuántos niveles se pueden distinguir.]
#pr("3.19")[$C = 20$ Mbps, $B = 3$ MHz.][$"SNR" = 2^(20\/3) - 1 approx 100,6 approx 20$ dB.]
#pr("3.20")[Onda cuadrada $T = 1$ ms por filtro de 8 kHz.][Pasan las armónicas de 1, 3, 5 y 7 kHz. Con amplitud $plus.minus 1$: $P = sum (4\/(pi k))^2\/2 = 0,95$ W. Ruido $N = N_0 B = 0,1 times 10^(-6) times 8000 = 8 times 10^(-4)$ W → SNR ≈ 1187 ≈ 30,7 dB.]
#pr("3.21")[$S = -151$ dBW, $T = 1500$ K, $R = 2400$ bps.][$E_b\/N_0 = -151 - 33,8 + 228,6 - 31,8 = 12,0$ dB.]
#pr("3.22")[Tabla de dB.][Pérdidas ($10^(-n\/10)$): 0,79 · 0,63 · 0,50 · 0,40 · 0,32 · 0,25 · 0,20 · 0,16 · 0,13 · 0,10. Ganancias ($10^(n\/10)$): 1,26 · 1,58 · 2,0 · 2,5 · 3,16 · 3,98 · 5,0 · 6,3 · 7,9 · 10.]
#pr("3.23")[30 dB de ganancia en tensión.][$V_"sal"\/V_"ent" = 10^(30\/20) = 31,6$.]
#pr("3.24")[20 W en dBW.][$10 log 20 = 13$ dBW.]
