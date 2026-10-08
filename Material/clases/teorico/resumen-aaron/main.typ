// Resumen teórico de Redes de Computadoras (FCEFyN - UNC, 2026).
// Compilar desde la raíz del repo: mise run pdf Material/clases/teorico/resumen-aaron/main.typ
#import "lib.typ": *

#set document(title: "Resumen teórico - Redes de Computadoras", author: "WireGuardians")
#set text(lang: "es", size: 10.5pt)
#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2.2cm),
  numbering: "1",
  header: context {
    if counter(page).get().first() > 1 [
      #set text(size: 8.5pt, fill: luma(110))
      Redes de Computadoras — Resumen teórico #h(1fr) FCEFyN – UNC – 2026
    ]
  },
)
#set par(justify: true, spacing: 0.9em)
#set heading(numbering: "1.1.")
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  set text(fill: azul, size: 17pt)
  block(below: 1em, it)
}
#show heading.where(level: 2): set text(fill: azul.darken(10%))
#set figure(gap: 0.6em)
#show figure.caption: set text(size: 9pt)
#set table(inset: 5pt)
#set math.equation(numbering: none)
// Coma decimal: en fórmulas la coma no debe dejar espacio (1,38 y no 1, 38).
#show math.equation: it => { show ",": math.class("normal", ","); it }
#show link: set text(fill: azul)

// ------------------------------------------------------------------ carátula
#align(center)[
  #v(3cm)
  #text(size: 26pt, weight: "bold", fill: azul)[Redes de Computadoras]
  #v(0.3em)
  #text(size: 16pt)[Resumen teórico por clase]
  #v(1.5em)
  #text(size: 12pt)[Clases 1 a 9 · 3 de agosto – 5 de octubre de 2026]
  #v(0.5em)
  #text(size: 11pt, fill: luma(80))[FCEFyN – Universidad Nacional de Córdoba · Grupo WireGuardians]
  #v(2.5cm)
]

#block(inset: 10pt, stroke: 0.5pt + luma(170), radius: 4pt)[
  *Cómo usar este resumen.* Cada capítulo corresponde a una clase de la planificación
  (`Material/Bibliografia/Planificacion_V1.md`) y sigue la lectura sugerida.
  Las figuras se extrajeron del libro de Stallings (7.ª ed.) y llevan entre paréntesis
  el número de figura y la página impresa del libro; las tablas y diagramas sin
  referencia son de elaboración propia. Al final de cada capítulo hay una guía
  de respuestas para las _cuestiones de repaso_ y los _ejercicios_ del capítulo
  correspondiente de Stallings, con los resultados numéricos ya calculados
  para poder verificar.

  *Bibliografía.* [STA] W. Stallings, _Comunicaciones y Redes de Computadores_, 7.ª ed.,
  Pearson, 2004. [COM] D. Comer, _Internetworking with TCP/IP, Vol. 1_, 6.ª ed.,
  Addison-Wesley, 2013. [KR] J. Kurose y K. Ross, _Redes de computadoras: un
  enfoque descendente_, 7.ª ed., Pearson, 2017.
]

#pagebreak()
#outline(depth: 2, indent: auto)

#include "clases/clase01.typ"
#include "clases/clase02.typ"
#include "clases/clase03.typ"
#include "clases/clase04.typ"
#include "clases/clase05.typ"
#include "clases/clase07.typ"
#include "clases/clase08.typ"
#include "clases/clase09.typ"
