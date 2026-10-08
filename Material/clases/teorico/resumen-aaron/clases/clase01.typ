#import "../lib.typ": *

= Clase 1 (3/8) — Introducción a los sistemas de comunicaciones

#lectura[
  [STA] Parte I, *Capítulo 1*: 1.1 Un modelo para las comunicaciones · 1.2 Comunicaciones de datos ·
  1.3 Redes de transmisión de datos (WAN, LAN, inalámbricas, MAN) · 1.4 Un ejemplo de configuración.
  El capítulo no tiene cuestiones de repaso propias; al final hay preguntas de autoevaluación.
]

El libro divide el campo en tres áreas: *comunicaciones* (cómo transmitir señales de forma
eficaz y segura: codificación, medios, interfaces, control de enlace, multiplexación),
*redes* (tecnología y arquitectura para interconectar dispositivos: LAN y WAN) y *protocolos*
(Capítulo 2). Desde los años 70–80 se borraron las fronteras entre procesamiento y
comunicación de datos, entre transmitir datos, voz o video y entre LAN, MAN y WAN.

== Modelo de un sistema de comunicación (1.1)

#fig("fig-1-1.png", [Modelo simplificado para las comunicaciones: (a) diagrama de bloques, (b) ejemplo con módems y red telefónica.], fuente: "Stallings, Fig. 1.1, p. 11", ancho: 75%)

#tabla(
  columns: (auto, 1fr),
  [*Elemento*], [*Función*],
  [Fuente], [Genera los datos a transmitir (teléfono, PC).],
  [Transmisor], [Transforma y codifica la información en señales electromagnéticas aptas para el sistema de transmisión (ej.: un módem convierte bits en una señal analógica para la red telefónica).],
  [Sistema de transmisión], [Desde una simple línea hasta una red compleja que une fuente y destino.],
  [Receptor], [Toma la señal del medio y la convierte en algo que el destino pueda manejar (el módem receptor recupera la cadena de bits).],
  [Destino], [Toma los datos del receptor.],
)

=== Tareas de un sistema de comunicación (Tabla 1.1)

El modelo es simple pero esconde mucha complejidad. Las tareas clave son:

- *Utilización del sistema de transmisión*: compartir eficazmente el medio entre muchos usuarios → *multiplexación*; evitar saturación → *control de congestión*.
- *Implementación de la interfaz* con el medio y *generación de la señal*: la señal debe (1) poder propagarse por el medio y (2) ser interpretable como datos en el receptor.
- *Sincronización*: el receptor debe saber cuándo empieza y termina la señal y cuánto dura cada elemento.
- *Gestión del intercambio*: convenciones de cooperación (quién transmite y cuándo, formato y cantidad de datos, qué hacer ante errores).
- *Detección y corrección de errores* (las señales siempre se distorsionan) y *control de flujo* (que la fuente no sature al destino).
- *Direccionamiento* (identificar al destino en un medio compartido) y *encaminamiento* (elegir una ruta cuando hay varias).
- *Recuperación*: distinto de corregir errores; retomar una transacción interrumpida o volver al estado previo.
- *Formato de mensajes* (acuerdo sobre la representación, ej. código de caracteres), *seguridad* (confidencialidad, integridad, autenticidad) y *gestión de red* (configurar, monitorizar, reaccionar ante fallos, planificar crecimiento).

== Comunicaciones de datos (1.2)

#fig("fig-1-2.png", [Modelo simplificado para las comunicaciones de datos, con las señales en cada punto.], fuente: "Stallings, Fig. 1.2, p. 14", ancho: 85%)

Ejemplo del correo electrónico: el mensaje $m$ se guarda como bits $g$; llega al transmisor
como niveles de tensión $g(t)$; el transmisor genera la señal $s(t)$; el medio la degrada y llega
$r(t) != s(t)$; el receptor estima los bits $g'(t)$, el destino arma el bloque $g'$ (detectando y
pidiendo corrección de errores) y presenta $m'$, que normalmente es *copia exacta* de $m$.

En una llamada telefónica, en cambio, la onda sonora se convierte en señal eléctrica con las mismas
frecuencias ($g(t) = s(t)$), no hay corrección y $m'$ *no* es réplica exacta de $m$, aunque sí
comprensible.

== Redes de transmisión de datos (1.3)

Conectar cada par de dispositivos con un enlace punto a punto no es práctico si (a) están muy
lejos o (b) son muchos dispositivos que se conectan entre sí en distintos momentos. La solución es
conectarlos a una *red de comunicación*.

#tabla(
  columns: (auto, 1fr, 1fr),
  [], [*WAN (área amplia)*], [*LAN (área local)*],
  [Cobertura], [Extensa; atraviesa rutas públicas], [Edificio o grupo de edificios cercanos],
  [Propiedad], [Al menos en parte, circuitos de un proveedor de telecomunicaciones], [De la misma organización dueña de los equipos (inversión y gestión propias)],
  [Velocidad], [Menor], [Mucho mayor internamente],
  [Estructura], [Nodos de conmutación interconectados que solo conmutan, no miran el contenido], [LAN conmutadas (Ethernet, ATM, Fibre Channel) e inalámbricas],
)

*Tecnologías WAN:*

- *Conmutación de circuitos*: se establece un *camino dedicado* (secuencia de enlaces, con un canal lógico reservado en cada uno) antes de transmitir; luego los datos pasan sin retardos en los nodos. Ejemplo: red telefónica.
- *Conmutación de paquetes*: no hay reserva previa; los datos van en *paquetes* que cada nodo recibe completos, almacena brevemente y reenvía (_store-and-forward_). Pensada para comunicaciones terminal-computador y computador-computador.
- *Frame relay*: conmutación de paquetes "aligerada": como los enlaces modernos tienen muy baja tasa de error, elimina casi todo el control de errores por salto → hasta 2 Mbps (vs. 64 kbps de X.25).
- *ATM* (_cell relay_): paquetes de longitud *fija* (celdas de 53 bytes); aún menos procesamiento → 10–100 Mbps y Gbps. Es a la vez evolución de frame relay y generalización de la conmutación de circuitos (múltiples canales virtuales con velocidad definida dinámicamente).

*Redes inalámbricas*: movilidad y facilidad de instalación; LAN inalámbricas (Cap. 17) y WAN celulares (Cap. 14).

*MAN (metropolitanas)*: punto intermedio; alta capacidad a bajo costo en un área metropolitana (Ethernet metropolitana, inalámbricas).

== Un ejemplo de configuración (1.4)

#fig("fig-1-3.png", [Una configuración de red típica.], fuente: "Stallings, Fig. 1.3, p. 18", ancho: 55%)

- Usuario residencial → *ISP* mediante módem telefónico (56 kbps), *DSL* (alta velocidad sobre el par telefónico) o *cable módem*.
- El ISP se conecta a Internet con un enlace de alta velocidad (ej. *SONET*). Internet = *encaminadores (routers)* interconectados que llevan paquetes de origen a destino.
- LAN de una organización: un *conmutador Ethernet*, salida a Internet a través de un *cortafuegos* (_firewall_), y un router hacia una *WAN privada* (ATM o frame relay).

== Preguntas de autoevaluación

#pr("1.")[¿Qué diferencia hay entre detección/corrección de errores y recuperación?][Corregir errores actúa sobre bits alterados en tránsito; la recuperación restablece un intercambio interrumpido (retomar la transferencia o volver al estado previo).]
#pr("2.")[¿Por qué $m'$ es copia exacta de $m$ en el correo pero no en la voz?][En datos se detectan errores y se pide retransmisión; en voz analógica la señal se reconvierte sin corrección, y la distorsión del medio llega al oyente (aunque sigue siendo inteligible).]
#pr("3.")[Diferencia esencial entre conmutación de circuitos y de paquetes.][Circuitos: recursos reservados de antemano durante toda la conexión (capacidad garantizada pero desperdiciada si no se usa). Paquetes: sin reserva; cada paquete se almacena y reenvía, compartiendo dinámicamente los enlaces (retardos variables).]
#pr("4.")[¿Por qué frame relay y ATM son más rápidos que X.25?][Porque eliminan el control de errores salto a salto (innecesario con enlaces de baja tasa de error) y, en ATM, las celdas de tamaño fijo simplifican aún más la conmutación.]
