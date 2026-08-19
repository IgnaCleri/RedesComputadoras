# CLAUDE.md

Índice de este repositorio para agentes (Claude Code u otros).

## Qué es este repo

Repositorio de material de estudio de la materia **Redes de Computadoras**: no es un proyecto de software, no tiene build, tests ni lint que correr. El "código" son documentos (PDFs, Markdown, imágenes) que colaboradores van agregando a lo largo de la cursada.

Para las reglas de cómo agregar contenido (conventional commits, ramas, PRs), ver la sección ["Cómo contribuir" del `README.md`](./README.md#cómo-contribuir) — no las dupliques acá.

## Estructura actual

- `README.md` — horario de cursada y guía de contribución (estructura de carpetas, conventional commits, ramas, PRs).
- `Material/Bibliografia/` — PDFs de libros de texto de la materia (Comer, Kurose & Ross, Stallings, Tanenbaum).
- `Material/Bibliografia/clases/` — ubicación histórica de apuntes de clase (`clase1.md`, `clase1practico.md`, imágenes). **Nota:** la convención vigente para clases nuevas es `Material/clases/`; estos archivos no se movieron para no romper el historial, pero el contenido nuevo debe ir en la ubicación nueva.
- `Material/clases/teorico/claseN/` — apuntes/transcripciones de las clases teóricas, una carpeta por clase (ej. `Material/clases/teorico/clase2/`).
- `Material/clases/practico/claseN/` — apuntes de las clases prácticas, una carpeta por clase. Crear esta carpeta cuando se agregue el primer apunte práctico nuevo.
- `Material/resumenes/` — resúmenes de unidades o temas. Crear esta carpeta cuando se agregue el primer resumen.
- `Material/Redes de Computadoras - Programa.pdf` — programa de la materia.
- `tps/practico/tpN/` — enunciados y entregas de los trabajos prácticos del práctico (ej. `tps/practico/tp1/`).
- `tps/teorico/tpN/` — enunciados y entregas de los trabajos prácticos del teórico. Crear esta carpeta cuando se agregue el primer TP teórico.

## Mantener este índice actualizado

Cuando agregues, muevas o renombres archivos y carpetas (nuevo TP, nueva clase, nuevo resumen, reorganización), actualizá este archivo en el mismo cambio para que siga reflejando la estructura real del repo. Si el cambio afecta también el flujo de trabajo (ramas, commits, PRs), actualizá también la sección ["Cómo contribuir" del `README.md`](./README.md#cómo-contribuir).
