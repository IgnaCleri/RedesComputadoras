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

### a) 

#### Pregunta:

En una configuración multipunto, sólo un dispositivo puede trasmitir cada vez, ¿por qué?

#### Respuesta: 

En este caso depende exactamente de como este implementado el medio de transmisión, si este cuenta con mas de un canal de transmisión de datos (usando Multiplexación por División de Frecuencias), pero en un caso basico con un unico canal, si se puede decir que solo se puede transmitir un dispositivo a la vez.

### b) 

#### Pregunta:

Hay dos posibles aproximaciones que refuerzan la idea de que, en un momento dado, sólo un dispositivo puede transmitir. En un sistema centralizado, una estación es la responsable del control y podrá transmitir o decidir que lo haga cualquier otra. En el método descentralizado, las estaciones cooperan entre sí, estableciéndose una serie de turnos. ¿Qué ventajas y desventajas presentan ambas aproximaciones?

#### Respuesta:

##### Caso 1: Sistema Centralizado.

 - Ventajas:
 Es mas sencillo evitar transmisiones a la vez ya que el que daria la orden directamente seria la estación de control, tambien al evitar el sistema de turnos en teoria puedes optimizar el uso del medio de transmisión.
 
 - Desventajas: 
 Todo el control depende de una unica estación la cual puede quedar fuera de servicio y parar en seco las transmisiones todas las demas estaciones.

##### Caso 2: Sistema Descentralizado.

 - Ventajas:
 Puede seguir funcionando incluso si una o varias estaciones estan fuera de servicio

 - Desventajas:
 El sistema es menos optimo ya que puede que el canal sea necesitado por alguna central pero no usado ya que no es el turno de la central que la necesita

## 3.2 

### Pregunta:

Una señal tiene una frecuencia fundamental de 1000 Hz. ¿Cuál es su periodo?

### Respuesta:

Si una señal tiene una frencuencia fundamental $f=1000hz \rightarrow T=\frac{1}{f}=\frac{1}{1000hz}= 1ms$

##  3.3 

### Pregunta:

Simplifique las siguientes expresiones:

a) $\sin(2\pi ft - \pi) + \sin(2\pi ft + \pi)$

b) $\sin(2\pi f t) + \sin(2\pi f t - \pi)$

### Respuesta:

#### a)

$$
\sin(2\pi ft - \pi) + \sin(2\pi ft + \pi) = -\sin(2\pi ft) + \left(-\sin(2\pi ft)\right) = -2\sin(2\pi ft)
$$


#### b)

$$
\sin(2\pi f t) + \sin(2\pi f t - \pi) = \sin(2\pi f t) + (-\sin(2\pi f t)) = 0
$$

## 3.4 

### Pregunta:

El sonido se puede modelar mediante funciones sinusoidales. Compare la frecuencia relativa y la longitud de onda de las notas musicales. Piense que la velocidad del sonido es igual a 330 m/s y que las frecuencias de una escala musical son:

### Respuesta:

Sea $v$ velocidad del sonido, $\lambda$ la longitud de onda y $f$ frecuencia de la nota

$$ \lambda = \frac{v}{f}$$



| Nota | DO | RE | MI | FA | SOL | LA | SI | DO |
|---|---|---|---|---|---|---|---|---|
| **f (Hz)** | 264 | 297 | 330 | 352 | 396 | 440 | 495 | 528 |
| **λ (m)** | 1.2500 | 1.1111 | 1.0000 | 0.9375 | 0.8333 | 0.7500 | 0.6667 | 0.6250 |

Podemos ver como a mayor la frecuencia de la nota, menor es la longitud de onda.

## 3.5 

### Pregunta:

Si la curva trazada con una línea continua de la Figura 3.17 representa al $\sin(2nt)$, ¿qué función corresponde a la línea discontinua? En otras palabras, la línea discontinua se puede expresar como $A\sin(2nft+\phi)$, ¿qué son $A$, $f$ y $\phi$?



![figura 3.17](imagenes/image.png)

### Respuesta:

La linea discontinua corresponda a una funcion seno a la cual se le cambio la frecuencia $f$ (esta paso a ser el doble de la anterior), se le aplico un desfasaje $\phi$ (de mas o menos $0.5$) y ademas se le aumento la amplitud $A$ (Una amplitud mayor a 1)

## 3.6

### Pregunta:

Exprese la señal _(1 + 0,1 $\cos 5t$) $\cos 100t$_ como combinación lineal de funciones sinusoidales; encuentre la amplitud, frecuencia y fase de cada una de las componentes. _(Sugerencia: use la expresión del cos a cos b)_.

### Respuesta:
 
- Distribuímos el producto
$$s(t) = (1)(\cos100t) + (0{,}1\cos5t)(\cos100t) = \cos100t + 0{,}1\cos5t\cos100t$$
 
- Aplicamos la identidad trigonométrica que nos suguiere la consigna en el segundo termino: $\cos a\cos b=\tfrac12[\cos(a-b)+\cos(a+b)]$ 
 
$$0{,}1\cos100t\cos5t = 0{,}1\cdot\frac12\big[\cos(100t-5t)+\cos(100t+5t)\big] = 0{,}1\cdot\frac12\big[\cos95t+\cos105t\big] = 0{,}05\cos95t+0{,}05\cos105t$$
 
$$s(t) = \cos100t + 0{,}05\cos95t + 0{,}05\cos105t$$
 
| Término | Amplitud | ω (rad/s) | f = ω/2π (Hz) | Fase |
|---|---|---|---|---|
| $\cos100t$ | 1 | 100 | ≈15,92 | 0 |
| $0{,}05\cos95t$ | 0,05 | 95 | ≈15,12 | 0 |
| $0{,}05\cos105t$ | 0,05 | 105 | ≈16,71 | 0 |

## 3.7

### Pregunta: 

Encuentre el periodo de la función $f(t)=(10\cos t)^2$.

### Respuesta: 

$$f(t) = (10\cos t)^2 = 100\cos^2t$$
  
- Usar la identidad de ángulo doble $\cos^2t = \dfrac{1+\cos2t}{2}$:
 
$$f(t) = 100\cdot\frac{1+\cos2t}{2}= 50 + 50\cos2t$$
 
- Frecuencia angular es $\omega=2$ rad/s, y el periodo es $T=2\pi/\omega$:
 
$$T = \frac{2\pi}{2} = \pi$$

## 3.9

### Pregunta:

La Figura 3.4 muestra el efecto resultante al eliminar las componentes de alta frecuencia de un pulso cuadrado, considerando sólo las componentes de baja frecuencia. ¿Cómo sería la señal resultante en el caso contrario (es decir, quedándose con todos los armónicos de frecuencia alta y eliminando los de bajas frecuencias)?
_
![figura 3.4](imagenes/image-1.png)

### Respuesta:

La señal resultante quedándose con todos los armónicos de frecuencias altas y eliminando los de bajas frecuencias, se pierde todo lo "plano" de la onda cuadrada. Lo que sobrevive son unos picos angostos justo donde antes había un salto brusco (los flancos).

## 3.10

### Pregunta:

La Figura 3.5b muestra la función correspondiente a un pulso rectangular en el dominio de la frecuencia. Este pulso puede corresponder a un 1 digital en un sistema de comunicación. Obsérvese que se necesita un número infinito de frecuencias (con amplitud decreciente cuanto mayor es la frecuencia). ¿Qué implicaciones tiene este hecho en un sistema de transmisión real?

![figura 3.5b](imagenes/image-2.png)

### Respuesta:

Las implicaciones que tiene este hecho en un sistema real son: como ningún canal de transmisión tiene ancho de banda infinito, en algún punto se pierden las componentes de frecuencia más alta del pulso, que son justamente las que le dan sus bordes filosos. Como consecuencia, el pulso que llega al receptor ya no conserva la forma rectangular ideal, sino que aparece con los flancos redondeados y estirado en el tiempo. Cuanto menor sea el ancho de banda disponible, mayor es esa distorsión.

# d) Modulación en AM en Python

Para este punto se implementó el código de graficación de la modulación AM que aparece en el blog indicado en la consigna (el cual también incluye un segundo script que reproduce las mismas señales como audio, pero no se usó porque no se ajusta al objetivo de "ver" el efecto de cada parámetro). El código, tal como se implementó, es el siguiente:

```python
import numpy as np
import matplotlib.pyplot as plt

A_m = 5 #amplitud de la moduladora
f_m = 4000 #frecuencia de la moduladora
A_p = 5 #amplitud de la portadora
f_p = 40000 #frecuencia de la portadora
ka = 3 #indice de modulacion
t = np.linspace(0, 1, 1000)

moduladora = A_m*np.cos(2*np.pi*f_m*t)
portadora = A_p*np.cos(2*np.pi*f_p*t)
modulacion_AM = A_p*(1+ka*np.cos(2*np.pi*f_m*t))*np.cos(2*np.pi*f_p*t)

# señal moduladora
plt.subplot(3,1,1)
plt.title("Señal de Mensaje o Moduladora")
plt.plot(moduladora,'g')
plt.ylabel('Amplitud')

# señal portadora
plt.subplot(3,1,2)
plt.title("Señal Portadora")
plt.plot(portadora,'r')
plt.ylabel('Amplitud')

# señal AM
plt.subplot(3,1,3)
plt.title("Modulacion AM")
plt.plot(modulacion_AM, color='purple')
plt.ylabel('Amplitud')
plt.xlabel('Señal AM')

plt.show()
```

El código grafica tres señales: la moduladora (la que contiene la información), la portadora (de mayor frecuencia) y el resultado de modularlas en amplitud. La señal AM se calcula como $A_p \cdot (1 + k_a \cos(2\pi f_m t)) \cdot \cos(2\pi f_p t)$: el término entre paréntesis es la envolvente, y $k_a$ controla cuánto varía esa envolvente respecto a la portadora.

Al correr el código con distintos parámetros notamos que la ventana de tiempo original (de 0 a 1 segundo, con solo 1000 muestras) no alcanza a representar bien portadoras de decenas de miles de Hz: para que se vean correctamente sus oscilaciones hace falta muestrear muchas más veces por segundo. Por eso, para las pruebas que siguen ajustamos la ventana de tiempo y la cantidad de muestras según la frecuencia usada en cada caso (sin tocar las fórmulas del código original), de forma de poder ver con claridad unos pocos ciclos de la envolvente con la portadora bien resuelta dentro de cada uno.

Como caso de referencia partimos de $A_p=5$, $f_p=40000$ Hz, $A_m=5$, $f_m=4000$ Hz y $k_a=1$ (el valor de $k_a$ que da la modulación "ideal", en la que la envolvente llega justo a cero en sus mínimos sin cruzarlo):

![Corrida base](imagenes/am-r1-base.png)

Se distinguen los 40 ciclos de portadora que corresponden a 40000 Hz durante 1 ms, y los 4 ciclos de moduladora que corresponden a 4000 Hz en esa misma ventana. La envolvente de la señal AM sigue exactamente la forma de la moduladora, tocando el cero en cada mínimo.

### Variando la portadora

Primero probamos subir la amplitud de la portadora a 10, manteniendo todo lo demás igual:

![Portadora con mayor amplitud](imagenes/am-r2-portadora-amplitud.png)

El resultado tiene exactamente la misma forma que la corrida base, pero escalada al doble: tanto la portadora como la señal AM llegan ahora al doble de su valor anterior. Tiene sentido, porque $A_p$ multiplica a toda la expresión de la señal AM, así que cambiarla solo estira o achica verticalmente el gráfico sin modificar la forma de la envolvente.

Después bajamos la frecuencia de la portadora a 20000 Hz:

![Portadora con menor frecuencia](imagenes/am-r3-portadora-frecuencia.png)

Acá sí cambia algo relevante: en la misma ventana de 1 ms ahora entran 20 ciclos de portadora en lugar de 40, es decir la mitad. La envolvente, que depende de la moduladora y no de la portadora, se mantiene igual. Esto confirma que $f_p$ solo determina qué tan rápido oscila la portadora dentro de cada lóbulo de la envolvente, sin afectar la forma de esa envolvente.

### Variando la moduladora

Con la portadora en sus valores originales, bajamos la amplitud de la moduladora a 1:

![Moduladora con menor amplitud](imagenes/am-r4-moduladora-amplitud.png)

Este fue el resultado más llamativo de todas las pruebas: aunque la señal moduladora graficada aparte se ve mucho más chica, la señal AM final queda idéntica a la de la corrida base. Revisando la fórmula usada en el código, $A_m$ no aparece en ningún lado del cálculo de la modulación AM: solo se usa para graficar la moduladora como señal independiente. La profundidad de la modulación (cuánto "se hunde" la envolvente) queda determinada únicamente por $k_a$, no por la amplitud real de la señal de mensaje.

Por último, subimos la frecuencia de la moduladora a 10000 Hz (achicando la ventana de tiempo para seguir viendo la misma cantidad de ciclos de envolvente):

![Moduladora con mayor frecuencia](imagenes/am-r5-moduladora-frecuencia.png)

Al acercarse la frecuencia de la moduladora a la de la portadora, entran muchos menos ciclos de portadora dentro de cada lóbulo de la envolvente. Se nota que la envolvente ya no queda tan prolija: con pocos ciclos de portadora para dibujarla, se pierde la suavidad del contorno. Esto ilustra por qué en un sistema real la portadora tiene que ser bastante más rápida que la señal de mensaje: si no hay suficientes ciclos de portadora por cada variación de la moduladora, la envolvente deja de representarse con fidelidad.

### Variando el índice de modulación

Volviendo a los valores de la corrida base, probamos dos valores de $k_a$ distintos de 1. Con $k_a=0.3$ (submodulación):

![Submodulación](imagenes/am-r6-submodulacion.png)

La envolvente ya no llega a tocar el cero: se queda oscilando entre valores siempre positivos. Esto es la submodulación: se está usando menos rango dinámico del que la portadora podría aprovechar, lo que en un sistema real significa transmitir con menos eficiencia de la posible.

Con $k_a=2.5$ (sobremodulación):

![Sobremodulación](imagenes/am-r7-sobremodulacion.png)

Se ve claramente un rizado adicional cerca de los cruces por cero de la envolvente, que no estaba presente en la corrida base. Esa es la distorsión típica de la sobremodulación: al superar $k_a=1$, la envolvente se cruza consigo misma y ya no representa fielmente a la señal moduladora, lo que en la práctica generaría errores al recuperar la información en el receptor.

### Conclusión

Jugando con los parámetros del código pudimos separar el efecto de cada uno sobre la señal AM resultante. La amplitud de la portadora ($A_p$) solo escala el resultado sin cambiar su forma, y la frecuencia de la portadora ($f_p$) solo cambia cuántos ciclos de portadora entran por cada lóbulo de la envolvente, también sin afectar su forma. En cambio, la amplitud de la moduladora ($A_m$) no tiene ningún efecto sobre la señal AM en esta implementación: todo el peso de la modulación depende del índice $k_a$. La frecuencia de la moduladora ($f_m$), en cambio, sí es crítica: cuanto más se acerca a la frecuencia de la portadora, menos ciclos de portadora quedan disponibles para dibujar cada lóbulo de la envolvente, y la modulación se vuelve menos fiel. Finalmente, el índice de modulación resultó ser el parámetro más determinante de todos: valores menores a 1 dejan la envolvente sin llegar a cero (submodulación, poco eficiente), y valores mayores a 1 la distorsionan con rizado adicional (sobremodulación, poco fiel). En conjunto, estas pruebas muestran por qué en un sistema de comunicación real la relación entre $f_p$ y $f_m$, y el ajuste correcto de $k_a$, son decisiones de diseño tan importantes: determinan tanto la fidelidad como la eficiencia de la transmisión.

# Bibliografía

Stallings, W. *Comunicaciones y Redes de Computadoras*.
