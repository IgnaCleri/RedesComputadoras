# Contribuir a este repo

Este repositorio guarda el material de estudio de la materia **Redes de Computadoras**: trabajos prácticos (del práctico y del teórico), apuntes de clase, resúmenes y bibliografía. Esta guía explica cómo agregar contenido nuevo sin romper la organización existente.

## Estructura de carpetas

| Tipo de contenido | Carpeta destino |
|---|---|
| TP del práctico | `tps/practico/tpN/` |
| TP del teórico | `tps/teorico/tpN/` |
| Apuntes de clase | `Material/clases/` |
| Resúmenes | `Material/resumenes/` |
| Bibliografía (libros, programa) | `Material/Bibliografia/` |

Si un archivo no encaja en ninguna categoría existente, creá la carpeta que corresponda siguiendo el mismo criterio (tipo de contenido, no persona ni fecha) y documentala acá (ver [Mantener esto actualizado](#mantener-esto-actualizado)).

## Conventional Commits

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

## Ramas

Cada colaborador trabaja en su propia rama personal, con el patrón `trabajo-<nombre>` (por ejemplo `trabajo-igna`, `trabajo-aaron`). Antes de empezar a trabajar, actualizá tu rama con los últimos cambios de `master`:

```
git checkout trabajo-<nombre>
git merge master
```

Hacé tus commits en esa rama.

## Pull Requests

`master` está protegida: no se puede pushear directo a esa rama, todo cambio tiene que entrar por Pull Request.

Cuando quieras subir contenido a `master`:

1. Pusheá tu rama personal (`trabajo-<nombre>`).
2. Abrí un Pull Request contra `master`.
3. El PR necesita **2 aprobaciones** antes de poder mergearse.

## Mantener esto actualizado

Si agregás una categoría nueva de material, reorganizás carpetas, o cambiás el flujo de ramas/PRs, actualizá este archivo y también [`CLAUDE.md`](./CLAUDE.md) en el mismo cambio. Esto vale tanto para colaboradores humanos como para agentes: no dejes que la documentación quede desactualizada respecto a la estructura real del repo.
