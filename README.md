# WireGuardians

**Redes de Computadoras — Ingeniería en Computación — FCEFyN — UNC— 2026**

## Trabajos Prácticos

| TP                  | Informe                                            | Enunciado                                          |
| ------------------- | -------------------------------------------------- | -------------------------------------------------- |
| TP1 — Práctico    | [informe-tp-1.md](tps/practico/tp1/informe-tp-1.md) | [RC - TP N1.pdf](<tps/practico/tp1/RC - TP N1.pdf>) |
| TP2 — Práctico    | [InformeTP2.md](tps/practico/TP2/InformeTP2.md)     | [RC - TP N2.pdf](<tps/practico/TP2/RC - TP N2.pdf>) |
| Tarea 2 — Teórico | [tarea2.md](tps/tp-teorico/tarea2.md)               | —                                                 |

### Esquema de archivos

```
tps/
├── practico/
│   ├── tp1/
│   │   ├── informe-tp-1.md
│   │   ├── RC - TP N1.pdf
│   │   └── imagenes/
│   └── TP2/
│       ├── InformeTP2.md
│       └── RC - TP N2.pdf
└── tp-teorico/
    ├── tarea2.md
    └── imagenes/
```

## Horario de cursada

| Día   | Tipo      | Inicio | Finaliza | Sede      |
| ------ | --------- | ------ | -------- | --------- |
| Lunes  | Teórico  | 18:30  | 21:00    | CU107 Lab |
| Jueves | Práctica | 18:30  | 21:00    | CU301     |

## Modalidad de trabajo

El repositorio cuenta con tareas asignadas en issues, cada una correspondiente a un punto de un trabajo práctico.

Se trabaja en ramas individuales (podés ponerle el nombre que prefieras) y se sube contenido a `master` mediante Pull Request con los entregables.

Para trabajar en los TPs, buscá el archivo correspondiente y agregá los cambios ahí: no crees varios archivos del mismo TP, ni agregues apuntes auxiliares (para recordatorio o provisorios). Si los necesitás, creá una rama aparte con esos archivos auxiliares.

## Cómo contribuir

Este repositorio guarda el material de estudio de la materia: trabajos prácticos (del práctico y del teórico), apuntes de clase, resúmenes y bibliografía. Esta sección explica cómo agregar contenido nuevo sin romper la organización existente.

### Estructura de carpetas

| Tipo de contenido                | Carpeta destino                      |
| -------------------------------- | ------------------------------------ |
| TP del práctico                 | `tps/practico/tpN/`                |
| TP del teórico                  | `tps/teorico/tpN/`                 |
| Apuntes de clase teórica        | `Material/clases/teorico/claseN/`  |
| Apuntes de clase práctica       | `Material/clases/practico/claseN/` |
| Resúmenes                       | `Material/resumenes/`              |
| Bibliografía (libros, programa) | `Material/Bibliografia/`           |

Si un archivo no encaja en ninguna categoría existente, creá la carpeta que corresponda siguiendo el mismo criterio (tipo de contenido, no persona ni fecha) y documentala acá (ver [Mantener esto actualizado](#mantener-esto-actualizado)).

### Conventional Commits

Los mensajes de commit siguen el formato `tipo: descripción breve`. Tipos usados en este repo:

- `docs:` — agregar o modificar material de estudio (TPs, bibliografía, resúmenes).
- `class:` — agregar o modificar apuntes de una clase puntual.
- `feat:` — cambios estructurales del repo (nuevas carpetas, reorganización).
- `fix:` — corregir un error en un archivo ya subido (typo, archivo corrupto, etc.).

Ejemplos:

```
docs: agregar TP2 de práctico
docs: agregar TP1 de teórico
class: agregar apuntes clase 2
docs: agregar resumen unidad 3
fix: corregir enlace roto en apuntes clase 1
```

### Ramas

Cada colaborador trabaja en su propia rama personal, con el patrón `trabajo-<nombre>` (por ejemplo `trabajo-igna`, `trabajo-aaron`). Antes de empezar a trabajar, actualizá tu rama con los últimos cambios de `master`:

```
git checkout trabajo-<nombre>
git merge master
```

Hacé tus commits en esa rama.

### Pull Requests

`master` está protegida: no se puede pushear directo a esa rama, todo cambio tiene que entrar por Pull Request.

Cuando quieras subir contenido a `master`:

1. Pusheá tu rama personal (`trabajo-<nombre>`).
2. Abrí un Pull Request contra `master`.
3. El PR necesita **2 aprobaciones** antes de poder mergearse.

### Mantener esto actualizado

Si agregás una categoría nueva de material, reorganizás carpetas, o cambiás el flujo de ramas/PRs, actualizá esta sección en el mismo cambio para que no quede desactualizada respecto a la estructura real del repo.
