// Template https://github.com/juanm04/barcala
#import "@preview/barcala:0.3.0": apendice, informe, nomenclatura
#import "@preview/lilaq:0.5.0" as lq // Paquete para gráficos, puede ser omitido
#import "@preview/physica:0.9.7": * // Paquete para matemática y física, puede ser omitido
#import "@preview/zero:0.5.0" // Paquete para números lindos y unidades de medida, puede ser omitido

// Cambiar a false cuando el informe esté listo para presentar
#let drafting = false
#set page(
  foreground: if drafting {
    rotate(-0.955317rad, text(
      weight: "bold",
      size: 80pt,
      fill: rgb("#00000040"),
      "BORRADOR",
    ))
  },
)

// Los emails de la carátula se renderizan como `raw` inline, que no corta en las
// comas y se desborda del margen. Agregamos un espacio de ancho cero tras cada
// coma para habilitar el salto de línea.
#show raw.where(block: false): it => {
  show ",": ",\u{200B}"
  it
}

#show: informe.with(
  unidad-academica: image("assets/FCEFyN.png"),
  institucion: image("assets/UNC.jpg"),
  asignatura: "Redes de Computadoras",
  trabajo: "Trabajo Práctico Nº 5",
  equipo: "WireGuardians",
  autores: (
    (
      nombre: "Viberti, Benjamin",
      email: "b.viberti@mi.unc.edu.ar",
    ),
    (
      nombre: "Espinoza Sutta, Aaron Alejandro",
      email: "aaron.espinoza_4500@mi.unc.edu.ar",
    ),
    (
      nombre: "Cleri, Juan Ignacio",
      email: "ignacio.cleri@mi.unc.edu.ar",
    ),
    (
      nombre: "Pineda, Juan Ignacio",
      email: "juan.ignacio.pineda@mi.unc.edu.ar",
    ),
    (
      nombre: "Grafión, Atilio Leonel",
      email: "atilio.grafion@mi.unc.edu.ar",
    ),
    (
      nombre: "Badenes, Tomás",
      email: "tomasbadenes@mi.unc.edu.ar",
    ),
    (
      nombre: "Oviedo, Ignacio Nicolas",
      email: "ignacio.oviedo.239@mi.unc.edu.ar",
    ),
    (
      nombre: "Mendez, Jorge Nicolas",
      email: "jorge.mendez@mi.unc.edu.ar",
    ),
  ),
  
  titulo: [Preguntas de repaso --- Capítulo 20],
  resumen: [*_Objetivo_ --- Resolver las preguntas de repaso del Capítulo 20 de @stallings2004, sobre protocolos de transporte: direccionamiento, multiplexación, control de flujo por créditos, establecimiento de conexión y los protocolos TCP y UDP.*],
  
  fecha: datetime.today().display("[year]-[month]-[day]"),
)

// Enlaces de colores
#show cite: set text(blue)
#show link: set text(blue)
#show ref: set text(blue)

// Bloques de matemática con números para citar
#set math.equation(numbering: "(1)")
#show ref: it => {
  if it.element != none and it.element.func() == math.equation {
    // Sobreescribir las referencias a ecuaciones
    link(it.element.location(), numbering(
      it.element.numbering,
      ..counter(math.equation).at(it.element.location()),
    ))
  } else {
    // Otras referencias quedan igual
    it
  }
}

// Configuración de `zero`
#import zero: num, zi
#zero.set-num(
  decimal-separator: ",",
)
#zero.set-group(
  size: 3,
  separator: ".",
  threshold: (integer: 5, fractional: calc.inf),
)
#zero.set-unit(
  fraction: "inline",
)

// #nomenclatura(
//   ($f$, [Frecuencia [#zi.hertz()]]),
//   ($C$, [Capacidad del canal [#zi.bit-per-second()]]),
// )

// Customización por sobre el template
#set par(
  spacing: 1.2em,
)

// Numerar las preguntas como en el libro (20.1, 20.2, ...)
#counter(heading).update(19)

= Preguntas de repaso --- Capítulo 20

== ¿Qué elementos de direccionamiento son necesarios para especificar un usuario de servicio de transporte (TS) destino?

Para identificar al usuario destino se necesita la siguiente información:

- Identificación del usuario.
- Identificación de la entidad de transporte.
- Dirección de la estación.
- Número de la red.

En la práctica la dirección se expresa como el par (estación, puerto), llamado _socket_ en TCP, donde el puerto identifica a un usuario TS particular dentro de la estación.

Normalmente hay una única entidad de transporte por estación, por lo que no hace falta identificarla. Si hubiera más de una (por ejemplo TCP y UDP), la dirección debe indicar además el tipo de protocolo de transporte.

== Describa cuatro estrategias por las que un usuario TS emisor pueda averiguar la dirección de un usuario TS receptor.

Hay dos estrategias estáticas y dos dinámicas:

Estáticas:
+ *El usuario conoce previamente la dirección que desea utilizar*: es una configuración del sistema. Sirve para procesos que interesan sólo a unos pocos usuarios y que no deben ser conocidos por todos.
+ *Direcciones conocidas*: a algunos servicios de uso común se les asignan direcciones fijas conocidas por todos, por ejemplo un servidor FTP o SMTP.

Dinámicas:
+ *Servidor de nombres*: el usuario solicita mediante un nombre genérico o global la dirección de un usuario. El servidor de nombres devuelve la dirección, y luego la entidad de transporte establece la conexión. Es útil para servicios que cambian de localización de vez en cuando, por ejemplo para balancear la carga.
+ *Creación del proceso en el momento de la solicitud*: el emisor envía una petición a una dirección bien conocida, donde un proceso del sistema crea el proceso destino y devuelve su dirección. Por ejemplo, una cliente puede pedirle a un gestor de trabajos remoto que lance un programa de simulación en un servidor.

== Explique el uso de la multiplexación en el contexto de un protocolo de transporte.

El protocolo de transporte utiliza multiplexación en dos sentidos respecto de los protocolos de capas superiores y respecto de los servicios de red que usa.

Respecto de las capas superiores, el protocolo de transporte multiplexa y demultiplexa múltiples usuarios sobre el mismo protocolo de transporte, distinguiéndose mediante números de puerto o puntos de acceso al servicio. En TCP, como una conexión queda determinada por los _sockets_ origen y destino, un mismo puerto puede admitir múltiples conexiones, cada una con un puerto diferente. UDP incorpora a IP esta capacidad de direccionamiento de puerto.

Respecto de los servicios de red, la entidad de transporte puede usar multiplexación hacia arriba, que consiste en multiplexar múltiples conexiones sobre una única conexión de la capa inferior, o multiplexación hacia abajo, que consiste en dividir una única conexión entre múltiples conexiones de la capa inferior. Por ejemplo, en el caso de redes X.25, si un solo circuito tiene el rendimiento suficiente para varios usuarios conviene multiplexarlos sobre él. Por otra parte, cada circuito X.25 está restringido en números de secuencia, y en redes de alta velocidad y gran retardo podría requerirse un rango mayor, por lo que dividir la conexión entre varios circuitos puede mejorar el rendimiento.

== Describa brevemente el esquema de créditos utilizado por TCP para el control de flujo.

Es un control de flujo extremo a extremo donde el receptor le indica explícitamente al emisor cuántos datos puede enviar. Cada octeto tiene un número de secuencia y los segmentos llevan tres campos: número de secuencia (SN, el del primer octeto de datos del segmento), número de confirmación (AN) y ventana (W). Un segmento con (AN = i, W = j) significa:

- Se confirman todos los octetos hasta i − 1; el siguiente esperado es el i.
- Se concede crédito para enviar j octetos más, del i al i + j − 1.

El emisor avanza el borde final de su ventana a medida que transmite y el borde inicial solo cuando recibe crédito nuevo (la ventana se achica al transmitir y se amplía con cada crédito). El receptor no está obligado a confirmar cada segmento: puede enviar una confirmación acumulada.

#figure(
  image("assets/credito-tcp.png", width: 70%),
  caption: [Ejemplo del mecanismo de asignación de crédito de TCP.],
)

El receptor puede ser _conservador_ (conceder solo el espacio libre real en su memoria temporal) u _optimista_ (conceder espacio que espera liberar, mejorando el rendimiento con retardos grandes; pero si el emisor es más rápido que el receptor se descartan segmentos y hay que retransmitir, lo que complica el protocolo).

== ¿Cuál es la diferencia principal entre el esquema de créditos de TCP y el esquema de control de flujo de ventana deslizante utilizada por muchos otros protocolos, como por ejemplo HDLC?

En la ventana deslizante fija (como en X.25) confirmar y dar permiso de envío son lo mismo: cada confirmación avanza automáticamente una ventana de tamaño fijo, y para frenar al emisor el receptor retiene las confirmaciones. En el esquema de créditos de TCP la *confirmación y el control de flujo están desacoplados*: se puede confirmar un segmento sin conceder crédito nuevo (W = 0) y conceder crédito sin confirmar datos nuevos. Además, la ventana es variable y se mide en octetos, no en tramas.

Esto pesa en redes no fiables: con ventana fija, si el receptor frena reteniendo confirmaciones, el emisor no puede distinguir si la falta de confirmaciones se debe al control de flujo o a una pérdida. Con créditos el receptor confirma aunque no conceda crédito, y la pérdida de un segmento de confirmación/crédito se corrige con las confirmaciones posteriores. El único riesgo es un bloqueo mutuo si se pierde el (AN = i, W = j) que reabre una ventana cerrada con W = 0; se evita con un temporizador de ventana que obliga a reenviar un segmento al expirar.

== Explique los mecanismos de diálogo en dos y tres pasos.

*Diálogo en dos pasos:* A envía un SYN (solicitud de conexión); si B está en LISTEN, responde con un SYN que funciona como confirmación y pasa a ESTAB, y A pasa a ESTAB al recibirlo. La pérdida de un SYN se cubre con un temporizador de retransmisión, y los SYN duplicados se ignoran una vez establecida la conexión. Basta con un servicio de red fiable, pero sobre una red no fiable falla:

- Un segmento de datos obsoleto de una conexión anterior puede llegar durante una nueva y aceptarse en lugar del válido, que se descarta como duplicado. Para evitarlo, cada conexión empieza con un número de secuencia distinto, que se anuncia en el SYN (SYN i).
- Eso no resuelve un SYN i obsoleto: B lo toma como una solicitud nueva y responde, descarta el SYN real de A como duplicado, y ambos creen tener una conexión válida con números de secuencia distintos, por lo que B rechaza los datos de A.

#figure(
  image("assets/dos-pasos-datos-obsoleto.png", width: 70%),
  caption: [Diálogo en dos pasos: un segmento de datos obsoleto se acepta en una conexión nueva.],
)

#figure(
  image("assets/dos-pasos-syn-obsoleto.png", width: 70%),
  caption: [Diálogo en dos pasos: un SYN obsoleto desincroniza los números de secuencia.],
)

*Diálogo en tres pasos (usado por TCP):* cada extremo confirma explícitamente el SYN y el número de secuencia inicial (ISN) del otro. El SYN ocupa el número i, por lo que el primer octeto de datos es el i + 1:

+ A → B: SYN, SN = i
+ B → A: SYN, SN = j, AN = i + 1
+ A → B: SN = i + 1, AN = j + 1 (es el primer segmento de datos de A)

Se agrega el estado SYN RECEIVED, para no declarar la conexión establecida hasta que ambos SYN estén confirmados, y el segmento RST. La regla es enviar RST si la conexión todavía no está en ESTAB y llega un ACK inválido (que no referencia nada enviado):

- Si un SYN i obsoleto llega a B, este responde SYN j, AN = i + 1; A no pidió esa conexión y responde RST, AN = j. El AN en el RST evita que un RST obsoleto cancele una apertura legítima.
- Si un SYN/ACK obsoleto (SYN k, AN = p) llega a A mientras abre una conexión, A responde RST, AN = k y la apertura real sigue sin problemas, porque las confirmaciones llevan números de secuencia.

#figure(
  image("assets/tres-pasos.png", width: 70%),
  caption: [Diálogo en tres pasos: (a) funcionamiento normal, (b) SYN retrasado, (c) SYN/ACK obsoleto durante una apertura.],
)

== ¿Cuál es el beneficio del mecanismo de diálogo en tres pasos?

Su beneficio es que evita que los segmentos SYN duplicados u obsoletos, que llegan con retraso desde conexiones anteriores, generen conexiones falsas o confundan una conexión nueva. Para lograrlo, cada extremo confirma explícitamente el SYN y el número de secuencia inicial del otro antes de dar la conexión por establecida.


== Defina las características de urgencia y forzado de TCP.


== ¿Qué es una opción en los criterios de implementación de TCP?


== ¿Cómo puede utilizarse TCP para tratar la congestión de red o de interconexión de red?


== ¿Qué proporciona UDP que no ofrezca IP?


// TODO Actividad 2: responder al menos 11 ejercicios (pág. 719) del Capítulo 20

// Bibliografía. Si hay referencias bibliográficas se renderiza.
// Si no, solamente con full: true se renderiza la bibliografía completa, aunque no haya referencias en el texto
#bibliography("bibliografia.bib", full: true)
