# PREGUNTAS DE REPASO

3.1. ¿En qué se diferencia un medio guiado de un medio no guiado?
3.2. ¿Cuáles son las diferencias entre una señal electromagnética analógica y una digital?
3.3. ¿Cuáles son las tres características más importantes de una señal periódica?
3.4. ¿Cuántos radianes hay en 360o?
3.5. ¿Cuál es la relación entre la longitud de onda y la frecuencia en una onda seno?
3.6. ¿Cuál es la relación entre el espectro de una señal y su ancho de banda?
3.7. ¿Qué es la atenuación?
3.8. Defina la capacidad de un canal.
3.9. ¿Qué factores clave afectan a la capacidad de un canal?




# RESPUESTAS

## 3.1. ¿En qué se diferencia un medio guiado de un medio no guiado?

En ambos tipos de medios la comunicación se realiza mediante ondas electromagnéticas; la diferencia radica en **cómo se propaga la onda**:

- **Medio guiado:** La onda se transmite confinada a lo largo de un camino físico. Ejemplos: par trenzado, cable coaxial, fibra óptica.

- **Medio no guiado (inalámbrico):** La onda se propaga libremente, sin estar confinada a un camino físico. Ejemplos: propagación a través del aire, el mar o el vacío.


## 3.2. ¿Cuáles son las diferencias entre una señal electromagnética analógica y una digital?

Toda señal electromagnética, considerada como función del tiempo, puede ser tanto analógica como digital. La diferencia entre ambas está en cómo varía la intensidad de la señal en el tiempo:

- **Señal analógica:** es una onda electromagnética que varía continuamente en el tiempo, sin saltos ni discontinuidades, y puede tomar cualquier valor dentro de un rango continuo. Según su espectro, puede propagarse tanto por medios guiados (par trenzado, cable coaxial, fibra óptica) como no guiados (atmósfera, espacio).

- **Señal digital:** es una secuencia de pulsos de tensión que se mantiene constante durante un intervalo de tiempo, tras el cual cambia abruptamente a otro valor constante. Por ejemplo, un nivel de tensión positiva puede representar un bit 0 y un nivel de tensión negativa un bit 1.

**Ventajas y desventajas de la señalización digital frente a la analógica:**

- *Ventaja:* en términos generales es más económica y menos susceptible a las interferencias de ruido.
- *Desventaja:* las señales digitales sufren más con la atenuación que las señales analógicas.


## 3.3. ¿Cuáles son las tres características más importantes de una señal periódica?

Una señal periódica se caracteriza por contener un patrón que se repite a lo largo del tiempo. Matemáticamente, una señal s(t) es periódica si y solo si:

$$s(t + T) = s(t), \quad -\infty < t < \infty$$

donde T es el período de la señal (el menor valor que verifica la ecuación).

Las **tres características más importantes** que definene a una señal periódica son:

- **Amplitud (A):** El valor máximo que alcanza la señal en el tiempo (amplitud de pico), normalmente medido en voltios.

- **Frecuencia (f):** La razón, en ciclos por segundo o Hercios (Hz), a la que la señal se repite. Su parámetro equivalente es el período (T), definido como el tiempo transcurrido entre dos repeticiones consecutivas, cumpliéndose que T = 1/f.

- **Fase (φ):** Una medida de la posición relativa de la señal dentro de un período de la misma.


---
Bibliografia
Libro: Comunicación y redes de computadoras - Stallings
