# b) PREGUNTAS DE REPASO 

## 3.1. ¿En qué se diferencia un medio guiado de un medio no guiado?

En ambos tipos de medios la comunicación se realiza mediante ondas electromagnéticas; la diferencia radica en **cómo se propaga la onda**:

- **Medio guiado:** La onda se transmite confinada a lo largo de un camino físico. Ejemplos: par trenzado, cable coaxial, fibra óptica.

- **Medio no guiado (inalámbrico):** La onda se propaga libremente, sin estar confinada a un camino físico. Ejemplos: propagación a través del aire, el mar o el vacío.


## 3.2. ¿Cuáles son las diferencias entre una señal electromagnética analógica y una digital?

Toda señal electromagnética, considerada como función del tiempo, puede ser tanto analógica como digital. La diferencia entre ambas está en cómo varía la intensidad de la señal en el tiempo:

- **Señal analógica:** Es una onda electromagnética que varía continuamente en el tiempo, sin saltos ni discontinuidades, y puede tomar cualquier valor dentro de un rango continuo. Según su espectro, puede propagarse tanto por medios guiados (par trenzado, cable coaxial, fibra óptica) como no guiados (atmósfera, espacio).

- **Señal digital:** Es una secuencia de pulsos de tensión que se mantiene constante durante un intervalo de tiempo, tras el cual cambia abruptamente a otro valor constante. Por ejemplo, un nivel de tensión positiva puede representar un bit 0 y un nivel de tensión negativa un bit 1.

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


## 3.4. ¿Cuántos radianes hay en 360°?

El radián es la unidad de medida angular basada en la relación entre el arco y el radio de una circunferencia: un ángulo de 1 radián es aquel que subtiende un arco de longitud igual al radio.

Dado que el perímetro completo de una circunferencia equivale a $2\pi$ veces su radio, una vuelta completa (360°) equivale a $2\pi$ radianes:

$$360° = 2\pi \text{ radianes} $$

## 3.5. ¿Cuál es la relación entre la longitud de onda y la frecuencia en una onda seno?

La longitud de onda ($\lambda$) se define como la distancia que ocupa un ciclo de la señal, o equivalentemente, la distancia entre dos puntos de igual fase en dos ciclos consecutivos. Representa la contraparte espacial del período (T), que es su equivalente en el dominio temporal.

Si la señal se propaga a una velocidad $v$, la longitud de onda se relaciona con el período mediante:

$$\lambda = v \cdot T$$

Dado que $T = 1/f$, esta expresión es equivalente a:

$$\lambda \cdot f = v$$

Es decir, **la longitud de onda y la frecuencia son inversamente proporcionales**: a mayor frecuencia, menor longitud de onda, y viceversa, para una misma velocidad de propagación $v$.


## 3.6. ¿Cuál es la relación entre el espectro de una señal y su ancho de banda?

Según el análisis de Fourier, cualquier señal electromagnética puede descomponerse en una colección de componentes sinusoidales (ondas seno), cada una con su propia amplitud, frecuencia y fase. Mientras la señal $s(t)$ describe su comportamiento en el dominio del tiempo, la función $S(f)$ la describe en el dominio de la frecuencia, especificando las amplitudes de sus componentes.

A partir de esto:

- **Espectro:** Es el conjunto de frecuencias que constituyen una señal.
- **Ancho de banda absoluto:** Es la anchura de ese espectro, es decir, la diferencia entre su frecuencia más alta y más baja.

En la práctica, muchas señales (por ejemplo, cualquier onda digital) tienen un espectro y, por lo tanto, un ancho de banda absolutoinfinito. Sin embargo, la mayor parte de su energía se concentra en una banda de frecuencias relativamente estrecha; a esa banda se la denomina **ancho de banda efectivo** (o simplemente ancho de banda).

**Relación con la transmisión real:** Ningún sistema de transmisión puede portar un ancho de banda infinito, y cuanto mayor es el ancho de banda transmitido, mayor es el costo. Por eso, en la práctica se transmite una versión de ancho de banda limitado de la señal original. Esta limitación introduce distorsión: cuanto más se restringe el ancho de banda respecto del espectro original, mayor es la distorsión y mayor la probabilidad de errores en el receptor.


## 3.7. ¿Qué es la atenuación?

La atenuación es la pérdida de energía que sufre una señal a medida que se propaga a través de un medio de transmisión, decayendo con la distancia recorrida. Es una de las dificultades fundamentales de la transmisión, junto con la distorsión de retardo y el ruido, y provoca que la señal recibida difiera de la señal originalmente transmitida (degradando su calidad en señales analógicas, o generando bits erróneos en señales digitales).

**Comportamiento según el tipo de medio:**

- **Medios guiados:** La atenuación suele ser exponencial, por lo que se expresa como un valor constante en decibelios por unidad de longitud.
- **Medios no guiados:** La atenuación es una función más compleja de la distancia, dependiente además de las condiciones atmosféricas.

**Consideraciones respecto a la atenuación:**

1. La señal recibida debe tener suficiente energía para que el receptor pueda detectarla adecuadamente.
2. Debe conservar un nivel notoriamente mayor que el del ruido para poder recibirse sin error.
3. La atenuación es, habitualmente, una función creciente de la frecuencia (afecta más a las frecuencias altas).

**Mitigación:** Los dos primeros problemas se resuelven controlando la energía de la señal mediante amplificadores o repetidores, ubicados a distancias adecuadas cuando la atenuación acumulada se vuelve inaceptable. El tercer problema se aborda con técnicas de ecualización de la atenuación en una banda de frecuencias dada.

## 3.8. Defina la capacidad de un canal

Se denomina **capacidad del canal** a la velocidad máxima a la que se pueden transmitir datos en un canal (o ruta de comunicación de datos) bajo unas condiciones dadas. Para el caso de datos digitales, la pregunta que responde es en qué medida los efectos nocivos que distorsionan o corrompen la señal limitan la velocidad de transmisión.

## 3.9. ¿Qué factores clave afectan a la capacidad de un canal?

Hay **cuatro conceptos relacionados entre sí** que determinan la capacidad de un canal:

- **La velocidad de transmisión de los datos:** Velocidad, expresada en bits por segundo (bps), a la que se pueden transmitir los datos.
- **El ancho de banda:** Ancho de banda de la señal transmitida, limitado por el transmisor y por la naturaleza del medio; se mide en hercios.
- **El ruido:** Nivel medio de ruido presente en el camino de transmisión.
- **La tasa de errores:** Tasa a la que ocurren errores (recibir un 1 habiendo transmitido un 0, o viceversa).

**Relación entre estos factores:**

- **Ancho de banda de Nyquist** (canal sin ruido): dado un ancho de banda $B$, la máxima velocidad de señal alcanzable es $2B$. Para señales con $M$ niveles discretos, la capacidad es
							$C = 2B \log_2 M$.

- **Capacidad de Shannon** (canal con ruido): relaciona la capacidad con el ancho de banda y la relación señal-ruido (SNR):

$$C = B \log_2(1 + SNR)$$

Esta fórmula representa el límite teórico máximo: dado un ancho de banda y un nivel de ruido, mayor SNR permite mayor capacidad. En la práctica se obtienen velocidades menores, ya que la fórmula supone únicamente ruido térmico y no contempla otros efectos como el ruido impulsivo o las distorsiones de atenuación y retardo.

---



# c) Ejercicios (3.1 a 3.20)


## 3.1

### a) En una configuración multipunto, sólo un dispositivo puede trasmitir cada vez, ¿por qué?

En este caso depende exactamente de como este implementado el medio de transmisión, si este cuenta con mas de un canal de transmisión de datos (usando Multiplexación por División de Frecuencias), pero en un caso basico con un unico canal, si se puede decir que solo se puede transmitir un dispositivo a la vez.

### b) Hay dos posibles aproximaciones que refuerzan la idea de que, en un momento dado, sólo un dispositivo puede transmitir. En un sistema centralizado, una estación es la responsable del control y podrá transmitir o decidir que lo haga cualquier otra. En el método descentralizado, las estaciones cooperan entre sí, estableciéndose una serie de turnos. ¿Qué ventajas y desventajas presentan ambas aproximaciones?

#### Caso 1: Sistema Centralizado.

 - Ventajas:
 Es mas sencillo evitar transmisiones a la vez ya que el que daria la orden directamente seria la estación de control, tambien al evitar el sistema de turnos en teoria puedes optimizar el uso del medio de transmisión.
 
 - Desventajas: 
 Todo el control depende de una unica estación la cual puede quedar fuera de servicio y parar en seco las transmisiones todas las demas estaciones.

#### Caso 2: Sistema Descentralizado.

 - Ventajas:
 Puede seguir funcionando incluso si una o varias estaciones estan fuera de servicio

 - Desventajas:
 El sistema es menos optimo ya que puede que el canal sea necesitado por alguna central pero no usado ya que no es el turno de la central que la necesita

## 3.2 Una señal tiene una frecuencia fundamental de 1000 Hz. ¿Cuál es su periodo?

Si una señal tiene una frencuencia fundamental $f=1000hz \rightarrow T=\frac{1}{f}=\frac{1}{1000hz}= 1ms$

##  3.3 Simplifique las siguientes expresiones:

### a)

$$
\sin(2\pi ft - \pi) + \sin(2\pi ft + \pi) = -\sin(2\pi ft) + \left(-\sin(2\pi ft)\right) = -2\sin(2\pi ft)
$$


### b)

$$
\sin(2\pi f t) + \sin(2\pi f t - \pi) = \sin(2\pi f t) + (-\sin(2\pi f t)) = 0
$$


# Bibliografía

Stallings, W. *Comunicaciones y Redes de Computadoras*.
