# Ejercicio 1

Onda Electromagnetica
## Definición

Una onda electromagnética es la propagación de energía producida por campos eléctricos y magnéticos que varían periódicamente en el tiempo y el espacio. En el contexto de redes de computadoras, **es el medio fundamental para la transmisión de datos** tanto en medios guiados (cables de cobre, fibra óptica) como no guiados (aire, espacio libre).

## Características principales

**Naturaleza de la señal**: Toda onda electromagnética, considerada como función del tiempo, puede representarse como una señal analógica o digital.

**Composición en frecuencia**: Según el análisis de Fourier, cualquier onda electromagnética está constituida por una superposición de componentes sinusoidales, cada una con:
- Amplitud específica
- Frecuencia propia  
- Fase característica

**Universalidad**: Sumando un número suficiente de señales sinusoidales con sus correspondientes amplitudes, frecuencias y fases, se puede construir y representar cualquier onda electromagnética.



# Señal de Tiempo Continuo

Una señal de tiempo continuo es aquella que está definida para cualquier valor de tiempo y varía de manera continua sin saltos ni discontinuidades. En el dominio de la transmisión de datos, una **señal analógica** es una onda electromagnética que varía continuamente en el tiempo.

**Características:**
- Varía suavemente en el tiempo
- Los datos analógicos (voz, vídeo, temperatura) ocupan un espectro de frecuencias limitado
- Se pueden representar mediante ondas electromagnéticas que ocupen el mismo espectro
- Pueden propagarse a través de medios guiados (par trenzado, cable coaxial, fibra óptica) o no guiados (atmósfera, espacio)

**Parámetros de una onda sinusoidal (base de análisis de Fourier):**
- Amplitud: valor máximo de la señal (medido en voltios)
- Frecuencia: razón de repetición (ciclos por segundo o Hertz)
- Fase: posición relativa de la señal dentro de un período

# Señal de Tiempo Discreto

Una señal de tiempo discreto es aquella que solo está definida en valores específicos y separados del tiempo. En el contexto de transmisión de datos, una **señal digital** es una secuencia de pulsos de tensión con valores constantes durante intervalos de tiempo determinados.

**Características:**
- La intensidad se mantiene constante durante intervalos de tiempo, luego cambia a otro valor constante
- Los datos digitales toman valores discretos (ejemplo: cadenas de texto, números enteros)
- Se puede transmitir a través de medios conductores usando diferentes niveles de tensión
- Ejemplo: nivel de tensión positiva representa un bit 0, nivel negativo representa un bit 1

**Ventajas sobre señales analógicas:**
- Más económica en términos generales
- Menos susceptible a interferencias de ruido
- Mejor integridad de datos en transmisión digital