# Trabajo Práctico N°4

**Integrantes del Grupo:**

| Name                            | DNI      | Mail UNC                          | Github                                                             |
| ------------------------------- | -------- | --------------------------------- | ------------------------------------------------------------------ |
| Viberti, Benjamin               | 46224179 | b.viberti@mi.unc.edu.ar           | [@benjaviberti](https://github.com/benjaviberti)                   |
| Espinoza Sutta, Aaron Alejandro | 96009173 | aaron.espinoza_4500@mi.unc.edu.ar | [@Aaron45000](https://github.com/Aaron45000)                       |
| Cleri, Juan Ignacio             | 46452662 | ignacio.cleri@mi.unc.edu.ar       | [@IgnaCleri](https://github.com/IgnaCleri)                         |
| Pineda, Juan Ignacio            | 45591343 | juan.ignacio.pineda@mi.unc.edu.ar | [@juanignaciopineda-dot](https://github.com/juanignaciopineda-dot) |
| Grafión, Atilio Leonel          | 43940195 | atilio.grafion@mi.unc.edu.ar      | [@Aollgn](https://github.com/Aollgn)                               |
| Badenes, Tomás                  | 44785038 | tomasbadenes@mi.unc.edu.ar        | [@b-Tomas](https://github.com/b-Tomas)                             |
| Oviedo, Ignacio Nicolas         | 43940195 | ignacio.oviedo.239@mi.unc.edu.ar  | [@GIX02](https://github.com/GIX02)                                 |
| Mendez, Jorge Nicolas           | 41301342 | jorge.mendez@mi.unc.edu.ar        | [@jorge088](https://github.com/jorge088)                           |

# PREGUNTAS DE REPASO - Capítulo 15

## 15.1. ¿Qué diferencias hay entre los requisitos clave para las redes existentes en salas de computadores de aquellos necesarios para redes de área local de computadores personales?

## 15.2. ¿Qué diferencias hay entre una red LAN de respaldo, una red SAN y una red LAN troncal?

## 15.3. ¿Qué es la topología de una red?

## 15.4. Enumere cuatro topologías comunes para redes LAN y describa brevemente su principio de funcionamiento.

## 15.5. ¿Cuál es el propósito del comité IEEE 802?

## 15.6. ¿Por qué existen diferentes normativas para redes LAN?

## 15.7. Enumere y describa brevemente los servicios proporcionados por LLC.

## 15.8. Enumere y describa brevemente los modos de operación proporcionados por el protocolo LLC.

## 15.9. Enumere algunas funciones básicas que se realicen en la capa MAC.

1. Encapsulado de datos: Ensamblado y desarmado de tramas (agrega encabezado con direcciones MAC y tráiler de control).
2. Control de acceso al medio: Regulación de la transmisión para compartir el canal físico entre múltiples dispositivos.
3. Detección de errores: Identificación de tramas alteradas usando la secuencia de comprobación de trama.
4. Direccionamiento físico: Identificación unívoca del emisor y receptor dentro de la red local.

## 15.10. ¿Qué funciones lleva a cabo un puente?
* Filtrado y reenvío: Lee la dirección MAC de destino para decidir si transmite la trama a otro segmento o la descarta.
* Aprendizaje automático: Inspecciona las direcciones de origen para construir dinámicamente una tabla de direcciones MAC asignadas a sus puertos.
* Segmentación de red: Divide una red grande en dominios de colisión independientes para reducir el tráfico innecesario.

## 15.11. ¿Qué es un árbol de expansión?
Es una topología lógica sin bucles generada por el protocolo STP. Bloquea de forma selectiva los puertos de enlaces redundantes para evitar tormentas de difusión (broadcast storms) y bucles de capa 2, garantizando una única ruta activa entre cualquier par de nodos.

## 15.12. ¿Qué diferencias existen entre un concentrador y un conmutador de capa 2?
Hub (Capa 1): Es un repetidor pasivo que retransmite las señales a todos sus puertos por igual. Todos los equipos comparten un único dominio de colisión y el mismo ancho de banda.
Switch L2 (Capa 2): Examina la trama y la reenvía únicamente al puerto de destino correspondiente. Otorga un dominio de colisión independiente por puerto y permite transmisiones simultáneas.

## 15.13. ¿Cuál es la diferencia entre un conmutador de almacenamiento y envío y uno rápido?
Almacenamiento y envío: Recibe la trama completa en su memoria intermedia, verifica que no tenga errores mediante el código CRC/FCS y luego la reenvía. Mayor latencia, pero no propaga tramas corruptas.
Conmutación rápida: Lee solo los primeros bytes para obtener la dirección MAC de destino y comienza a reenviar la trama de inmediato. Menor latencia, pero puede reenviar tramas dañadas.

# Bibliografía

Stallings, W. *Comunicaciones y Redes de Computadoras*, 7ma Edición, Pearson, 2004.
