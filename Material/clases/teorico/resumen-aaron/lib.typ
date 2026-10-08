// Utilidades compartidas por todos los capítulos del resumen.
// Las rutas de `image` se resuelven relativas a este archivo, por eso
// todas las figuras se cargan desde acá.

#let azul = rgb("#1f4e79")

// Figura extraída del libro. `fuente` indica de dónde sale
// (ej. "Stallings, Fig. 1.1, p. 11").
#let fig(archivo, pie, fuente: none, ancho: 80%) = figure(
  image("img/" + archivo, width: ancho),
  caption: [#pie#if fuente != none [ #text(fill: luma(90))[(#fuente)]]],
)

#let _caja(titulo, color, cuerpo) = block(
  width: 100%,
  inset: (x: 9pt, y: 7pt),
  radius: 3pt,
  stroke: (left: 2.5pt + color),
  fill: color.lighten(92%),
  breakable: true,
)[#text(fill: color.darken(15%), weight: "bold")[#titulo] \ #cuerpo]

#let lectura(cuerpo) = _caja("Lectura de la clase", azul, cuerpo)
#let clave(cuerpo) = _caja("Idea clave", rgb("#2e7d32"), cuerpo)
#let ejemplo(titulo: "Ejemplo resuelto", cuerpo) = _caja(titulo, rgb("#c25e00"), cuerpo)
#let ojo(cuerpo) = _caja("Atención", rgb("#b71c1c"), cuerpo)
#let extra(cuerpo) = _caja("Complemento (fuera de la bibliografía de la clase)", rgb("#6a1b9a"), cuerpo)

// Pregunta/ejercicio del libro con su respuesta guía.
#let pr(num, enunciado, respuesta) = block(width: 100%, breakable: true, above: 0.9em)[
  #text(weight: "bold", fill: azul)[#num] #enunciado \
  #pad(left: 1em)[#text(fill: luma(40))[→ #respuesta]]
]

// Tabla con encabezado sombreado.
#let tabla(columns: none, align: left, ..celdas) = table(
  columns: columns,
  align: align,
  inset: 5pt,
  stroke: 0.5pt + luma(170),
  fill: (_, y) => if y == 0 { azul.lighten(85%) },
  ..celdas,
)
