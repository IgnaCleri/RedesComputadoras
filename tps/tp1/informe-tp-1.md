# REDES DE COMPUTADORAS
## Trabajo Práctico Nº1

---
**Nombre del Grupo:**
**Integrantes del Grupo:**

1. Benjamin Viberti - 46224179 - b.viberti@mi.unc.edu.ar
2. 
3. 

**Profesor:**

---

# Consigna 1

## Parte 1: Resumen de Conceptos Teóricos

### 1.1. Onda Electromagnética

#### Definición

Una onda electromagnética es la propagación de energía producida por campos eléctricos y magnéticos que varían periódicamente en el tiempo y el espacio. En el contexto de redes de computadoras, **es el medio fundamental para la transmisión de datos** tanto en medios guiados (cables de cobre, fibra óptica) como no guiados (aire, espacio libre).

#### Características Principales

**Naturaleza de la señal:** Toda onda electromagnética, considerada como función del tiempo, puede representarse como una señal analógica o digital.

**Composición en frecuencia:** Según el análisis de Fourier, cualquier onda electromagnética está constituida por una superposición de componentes sinusoidales, cada una con:
- Amplitud específica
- Frecuencia propia  
- Fase característica

**Universalidad:** Sumando un número suficiente de señales sinusoidales con sus correspondientes amplitudes, frecuencias y fases, se puede construir y representar cualquier onda electromagnética.

### 1.2. Señal de Tiempo Continuo

#### Definición

Una señal de tiempo continuo es aquella que está definida para cualquier valor de tiempo y varía de manera continua sin saltos ni discontinuidades. En el dominio de la transmisión de datos, una **señal analógica** es una onda electromagnética que varía continuamente en el tiempo.

#### Características

- Varía suavemente en el tiempo
- Los datos analógicos (voz, vídeo, temperatura) ocupan un espectro de frecuencias limitado
- Se pueden representar mediante ondas electromagnéticas que ocupen el mismo espectro
- Pueden propagarse a través de medios guiados (par trenzado, cable coaxial, fibra óptica) o no guiados (atmósfera, espacio)

#### Parámetros de una Onda Sinusoidal

Base del análisis de Fourier:
- **Amplitud:** valor máximo de la señal (medido en voltios)
- **Frecuencia:** razón de repetición (ciclos por segundo o Hertz)
- **Fase:** posición relativa de la señal dentro de un período

### 1.3. Señal de Tiempo Discreto

#### Definición

Una señal de tiempo discreto es aquella que solo está definida en valores específicos y separados del tiempo. En el contexto de transmisión de datos, una **señal digital** es una secuencia de pulsos de tensión con valores constantes durante intervalos de tiempo determinados.

#### Características

- La intensidad se mantiene constante durante intervalos de tiempo, luego cambia a otro valor constante
- Los datos digitales toman valores discretos (ejemplo: cadenas de texto, números enteros)
- Se puede transmitir a través de medios conductores usando diferentes niveles de tensión
- Ejemplo: nivel de tensión positiva representa un bit 0, nivel negativo representa un bit 1

#### Ventajas sobre Señales Analógicas

- Más económica en términos generales
- Menos susceptible a interferencias de ruido
- Mejor integridad de datos en transmisión digital

### 1.4. Modulación/Demodulación

#### Modulación

La modulación es el proceso mediante el cual se codifican datos en una onda electromagnética variando alguno de los parámetros característicos de una señal denominada **portadora**. Permite adaptar los datos al canal de transmisión disponible, haciendo posible la transmisión de datos digitales a través de medios diseñados para señales analógicas.

**Proceso de modulación digital (módem):**
- Convierte una serie de pulsos binarios discretos (datos digitales en tiempo discreto) en una señal analógica de tiempo continuo
- Codifica los datos digitales variando la amplitud, frecuencia o fase de la portadora
- La señal resultante ocupa un espectro de frecuencias centrado en la frecuencia de la portadora

**Aplicación práctica:** Los módems convencionales representan datos binarios en el espectro de la voz, permitiendo que datos digitales se transmitan a través de líneas telefónicas convencionales (medios diseñados originalmente para señales analógicas).

#### Demodulación

La demodulación es el proceso inverso a la modulación: recupera los datos originales a partir de una señal modulada. Es esencial para recibir e interpretar correctamente la información transmitida.

**Proceso de demodulación (módem receptor):**
- Recibe la señal modulada en tiempo continuo
- Extrae los datos digitales originales (en tiempo discreto) que fueron codificados en la portadora
- Recupera la secuencia de bits binarios original

**Analogía con datos analógicos (codec):** Un codec (codificador-decodificador) realiza una operación similar pero en dirección opuesta a los módems: toma una señal analógica (tiempo continuo) y la aproxima mediante una cadena de bits (tiempo discreto). En el receptor, estos bits se usan para reconstruir la señal analógica original.

---

## Parte 2: Análisis Práctico

### Punto b

**Datos extraídos del gráfico:**

A partir del gráfico se identifica que la onda completa un ciclo cada 60 mm, por lo que la longitud de onda es:

$$\lambda = 60 \text{ mm} = 0{,}06 \text{ m}$$

**Cálculo de la frecuencia:**

La longitud de onda se relaciona con la velocidad de propagación y la frecuencia mediante la expresión:

$$\lambda \cdot f = v$$

Dado que la onda viaja exactamente a la velocidad de la luz ($c \approx 3 \times 10^8 \text{ m/s}$), despejando la frecuencia se obtiene:

$$f = \frac{c}{\lambda} = \frac{3 \times 10^8 \text{ m/s}}{0{,}06 \text{ m}} = 5 \times 10^9 \text{ Hz} = 5 \text{ GHz}$$

**Resultado:**

| Parámetro | Valor |
|---|---|
| Longitud de onda (λ) | 0,06 m (60 mm) |
| Frecuencia (f) | 5 × 10⁹ Hz = 5 GHz |

### Punto c

**Marco de referencia normativo:**

Para la clasificación sistemática del espectro electromagnético, se consulta el Artículo 2, Sección 2.1 de las Regulaciones de Radiocomunicaciones de la Unión Internacional de Telecomunicaciones (ITU-R Radio Regulations). Este documento establece la división internacional del espectro de radiofrecuencias en bandas designadas, cada una identificada por un rango específico de frecuencias.

**Bandas de frecuencia según ITU-R (Artículo 2, Sección 2.1):**

El espectro se organiza en las siguientes bandas principales:

| Designación | Rango de Frecuencia | Región del Espectro EM        |
| ----------- | ------------------- | ----------------------------- |
| VHF         | 30 MHz – 300 MHz    | Ondas de Radio                |
| UHF         | 300 MHz – 3 GHz     | Ondas de Radio/Microondas     |
| **SHF**     | **3 GHz – 30 GHz**  | **Microondas**                |
| EHF         | 30 GHz – 300 GHz    | Microondas/Ondas Milimétricas |

**Clasificación de la onda analizada:**

Con una frecuencia de **5 GHz**, la onda electromagnética estudiada se ubica específicamente en:

- **Banda ITU:** SHF (Super High Frequency)
- **Región del Espectro EM:** Microondas
- **Rango:** 3 GHz < 5 GHz < 30 GHz 

**Conclusión:**

La onda electromagnética con frecuencia de 5 GHz opera en la **banda SHF del espectro de radiofrecuencias** según las definiciones de la ITU, perteneciendo a la región de **microondas** del espectro electromagnético.