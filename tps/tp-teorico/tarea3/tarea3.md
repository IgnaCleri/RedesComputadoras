# Trabajo Práctico N°3

**Integrantes del Grupo:**

| Name                            | DNI      | Mail UNC                          | Github                                                            |
| ------------------------------- | -------- | --------------------------------- | ----------------------------------------------------------------- |
| Viberti, Benjamin               | 46224179 | b.viberti@mi.unc.edu.ar           | [@benjaviberti](https://github.com/benjaviberti)                   |
| Espinoza Sutta, Aaron Alejandro | 96009173 | aaron.espinoza_4500@mi.unc.edu.ar | [@Aaron45000](https://github.com/Aaron45000)                       |
| Cleri, Juan Ignacio             | 46452662 | ignacio.cleri@mi.unc.edu.ar       | [@IgnaCleri](https://github.com/IgnaCleri)                         |
| Pineda, Juan Ignacio            | 45591343 | juan.ignacio.pineda@mi.unc.edu.ar | [@juanignaciopineda-dot](https://github.com/juanignaciopineda-dot) |
| Grafión, Atilio Leonel         | 43940195 | atilio.grafion@mi.unc.edu.ar      | [@Aollgn](https://github.com/Aollgn)                               |
| Badenes, Tomas                  | 44785038 | tomasbadenes@mi.unc.edu.ar        | NA                                                                |
| Oviedo, Ignacio Nicolas         | 43940195 | ignacio.oviedo.239@mi.unc.edu.ar  | NA                                                                |

# b) PREGUNTAS DE REPASO

## 4.1. ¿Por qué hay dos cables en un par trenzado de cobre?

Cada par de cables trenzados constituye un único enlace de comunicación. La razón de que sean dos conductores, y no uno solo, es eléctrica: para que la corriente circule se necesita un circuito cerrado, es decir, un camino de ida y otro de retorno hacia la fuente; un solo cable no puede transportar una señal sin ese segundo conductor que complete el circuito.

Además, al ser dos conductores trenzados entre sí y muy próximos, ambos quedan expuestos de forma prácticamente idéntica a las interferencias electromagnéticas externas. Esto es lo que permite, en el receptor, tomar la señal como la diferencia entre ambos cables: el ruido captado por igual en los dos se cancela, mejorando la inmunidad al ruido frente a un único conductor.

## 4.2. ¿Cuáles son las limitaciones del par trenzado?

Comparado con otros medios guiados (cable coaxial y fibra óptica), el par trenzado presenta varias limitaciones:

- **Menor ancho de banda, distancia y velocidad de transmisión**: su rango de frecuencias útil (hasta 1 MHz para cables multipar) y la separación entre repetidores (apenas 2 km) son mucho menores que los del cable coaxial (hasta 500 MHz, repetidores cada 1-9 km) o la fibra óptica (hasta 370 THz, repetidores cada 40 km).
- **Atenuación fuertemente dependiente de la frecuencia**: a mayor frecuencia de la señal, mayor es la pérdida de energía por unidad de longitud.
- **Alta susceptibilidad a interferencias y ruido**: al acoplarse fácilmente con campos electromagnéticos externos, un par trenzado tendido en paralelo a una línea de alta tensión, por ejemplo, capta la energía de 50/60 Hz de esa línea. También es vulnerable al ruido impulsivo.
- **Necesidad frecuente de regeneración de la señal**: para transmisión analógica requiere amplificadores cada 5-6 km, y para transmisión digital, repetidores cada 2-3 km, un espaciado mucho más corto que el de otros medios guiados.

## 4.3. ¿Cuál es la diferencia entre el par trenzado no apantallado y el par trenzado apantallado?

La diferencia está en si el par de cables está protegido o no por una malla metálica adicional:

- **Par trenzado no apantallado (UTP, *Unshielded Twisted Pair*)**: es el más común, sobre todo en telefonía. Es el medio de transmisión más económico de todos, y también el más simple de instalar y manipular, pero al no tener protección adicional resulta más vulnerable a interferencias electromagnéticas externas, incluyendo las de pares cercanos o fuentes de ruido próximas.
- **Par trenzado apantallado (STP, *Shielded Twisted Pair*)**: el par de cables se recubre con una malla metálica que reduce las interferencias externas. Esto le permite ofrecer mejores prestaciones a velocidades de transmisión más altas, a cambio de ser más costoso y más difícil de manipular que el UTP.

## 4.4. Describir los principales componentes del cable de fibra óptica.

La fibra óptica es un medio flexible y muy delgado (entre 2 y 125 μm), capaz de confinar un haz de luz en su interior. Se puede fabricar con distintos materiales, con una relación directa entre costo y pérdidas: las fibras de silicio ultrapuro fundido son las que menos pérdidas presentan, pero también las más difíciles de fabricar; las fibras de cristal multicomponente son más económicas a cambio de mayores pérdidas; y las fibras de plástico son las más baratas de todas, aptas para enlaces cortos donde son aceptables pérdidas más altas.

Un cable de fibra óptica tiene forma cilíndrica y está compuesto por tres secciones concéntricas:

- **Núcleo**: la sección más interna, formada por una o varias fibras de cristal o plástico, con un diámetro de entre 8 y 100 μm. Es por donde efectivamente viaja el haz de luz.
- **Revestimiento**: rodea a cada fibra individualmente. Es también cristal o plástico, pero con propiedades ópticas distintas a las del núcleo. La frontera entre núcleo y revestimiento actúa como un reflector que confina el haz de luz dentro del núcleo, sin el cual la luz escaparía.
- **Cubierta**: la capa más exterior, que envuelve a uno o varios revestimientos. Está hecha de plástico y otros materiales dispuestos en capas, con una función puramente de protección física: contra la humedad, la abrasión, aplastamientos y otros daños.

## 4.5. ¿Qué ventajas y desventajas tiene la transmisión de microondas?

**Ventajas:**

- Para una distancia dada, requiere menos repetidores o amplificadores que el cable coaxial.
- Su atenuación crece con el cuadrado de la distancia, no exponencialmente como en el par trenzado o el coaxial, por lo que los repetidores pueden espaciarse mucho más: entre 10 km y 100 km, frente a los pocos km de los medios guiados.
- A mayor frecuencia utilizada, mayor ancho de banda potencial y, por lo tanto, mayor velocidad de transmisión alcanzable.
- A frecuencias más altas, las antenas necesarias son más pequeñas y más económicas.

**Desventajas:**

- Exige que las antenas estén perfectamente alineadas entre sí, siguiendo la línea visual directa, y montadas de forma rígida.
- La atenuación aumenta con la lluvia, un efecto especialmente marcado por encima de los 10 GHz.
- Al ser un medio cada vez más popular, las áreas de cobertura tienden a solaparse, generando riesgo de interferencias, lo que exige una regulación estricta en la asignación de bandas.

## 4.6. ¿Qué es la difusión directa por satélite (DBS, Direct Broadcast Satellite)?

DBS es la aplicación más reciente de la tecnología satelital a la televisión, en la que la señal de video se transmite directamente desde el satélite a los domicilios de los usuarios, sin pasar por estaciones terrestres intermedias que redistribuyan la programación. Se volvió económicamente viable gracias a la reducción en costo y tamaño de las antenas receptoras domésticas, lo que a su vez permitió aumentar la cantidad de canales disponibles.

## 4.7. ¿Por qué un satélite debe usar frecuencias ascendentes y descendentes distintas?

Porque un satélite no puede transmitir y recibir simultáneamente en el mismo rango de frecuencias sin generar interferencia entre ambas señales: si usara la misma banda para el canal ascendente (estación terrestre → satélite) y el descendente (satélite → estación terrestre), la propia retransmisión del satélite se mezclaría con la señal entrante. Por eso, la señal recibida en una frecuencia dada debe reenviarse necesariamente en una frecuencia distinta.

## 4.8. Indique las diferencias más significativas entre la difusión de radio y las microondas.

## 4.9. ¿Qué dos funciones realiza una antena?

Una antena es un conductor eléctrico (o un conjunto de conductores) que sirve para radiar o captar energía electromagnética, y cumple dos funciones opuestas:

- **Transmitir**: convierte la energía eléctrica que le llega del transmisor en energía electromagnética, y la radia hacia el entorno cercano (la atmósfera, el espacio o el agua).
- **Recibir**: captura energía electromagnética del entorno y la convierte en energía eléctrica, que entrega al receptor.

En comunicaciones bidireccionales suele usarse la misma antena para ambas funciones, ya que sus características de transferencia de energía son idénticas en los dos sentidos, transmitiendo o recibiendo, siempre que se use la misma frecuencia.

## 4.10. ¿Qué es una antena isotrópica?

Es una antena ideal, sin equivalente físico real, definida como un punto en el espacio que radia potencia de igual forma en todas las direcciones. Su diagrama de radiación (la representación gráfica de cómo radia potencia según la dirección) es, por lo tanto, una esfera perfecta centrada en la posición de la antena. Al ser el caso más simple e igual en todas direcciones, se usa como referencia para medir la ganancia de otras antenas reales.

# Bibliografía

Stallings, W. *Comunicaciones y Redes de Computadoras*.
