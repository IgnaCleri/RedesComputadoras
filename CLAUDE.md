# CLAUDE.md

Índice de este repositorio para agentes (Claude Code u otros).

## Qué es este repo

Repositorio de material de estudio de la materia **Redes de Computadoras**: no es un proyecto de software, no tiene build, tests ni lint que correr. El "código" son documentos (PDFs, Markdown, imágenes) que colaboradores van agregando a lo largo de la cursada.

Para las reglas de cómo agregar contenido (conventional commits, ramas, PRs), ver [`CONTRIBUTING.md`](./CONTRIBUTING.md) — no las dupliques acá.

## Estructura actual

- `README.md` — horario de cursada.
- `CONTRIBUTING.md` — cómo agregar contenido nuevo al repo.
- `Material/Bibliografia/` — PDFs de libros de texto de la materia (Comer, Kurose & Ross, Stallings, Tanenbaum).
- `Material/Bibliografia/clases/` — ubicación histórica de apuntes de clase (`clase1.md`, `clase1practico.md`, imágenes). **Nota:** la convención vigente para clases nuevas es `Material/clases/`; estos archivos no se movieron para no romper el historial, pero el contenido nuevo debe ir en la ubicación nueva.
- `Material/clases/` — apuntes de clase (teóricas y prácticas), un archivo o carpeta por clase. Crear esta carpeta cuando se agregue el primer apunte nuevo.
- `Material/resumenes/` — resúmenes de unidades o temas. Crear esta carpeta cuando se agregue el primer resumen.
- `Material/Redes de Computadoras - Programa.pdf` — programa de la materia.
- `tps/practico/tpN/` — enunciados y entregas de los trabajos prácticos del práctico (ej. `tps/practico/tp1/`).
- `tps/teorico/tpN/` — enunciados y entregas de los trabajos prácticos del teórico. Crear esta carpeta cuando se agregue el primer TP teórico.

## Mantener este índice actualizado

Cuando agregues, muevas o renombres archivos y carpetas (nuevo TP, nueva clase, nuevo resumen, reorganización), actualizá este archivo en el mismo cambio para que siga reflejando la estructura real del repo. Si el cambio afecta también el flujo de trabajo (ramas, commits, PRs), actualizá también [`CONTRIBUTING.md`](./CONTRIBUTING.md).
