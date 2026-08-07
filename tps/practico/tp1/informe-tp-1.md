# Trabajo Práctico N°1 — Informe

## 3) Modulación de señales digitales

### a) Técnica de modulación representada

La técnica representada es **PSK (Phase Shift Keying / Modulación por desplazamiento de fase)**, en su variante binaria (**BPSK**).

En el gráfico, la portadora senoidal mantiene su **amplitud y frecuencia constantes** a lo largo de toda la transmisión; lo único que cambia entre símbolos es su **fase**: los intervalos donde el bit vale "1" muestran la onda con una fase (por ejemplo 0°), y los intervalos donde el bit vale "0" muestran la misma onda invertida 180° respecto a la anterior. Por eso se ve un "quiebre" o inversión en la forma de onda justo en las transiciones entre bits distintos, mientras que entre bits iguales consecutivos la señal continúa sin discontinuidad. Como el parámetro modulado es la fase de la portadora (y no su amplitud ni su frecuencia), se trata de PSK.

### b) Señal modulada para la secuencia `0 1 1 1 0 1 1 0`

Aplicando el mismo principio (PSK) a la secuencia de bits `0 1 1 1 0 1 1 0`, la señal digital de entrada y su correspondiente portadora modulada en fase se ven así:

![Modulación PSK de la secuencia 0 1 1 1 0 1 1 0](images/ej3b-psk-modulacion.svg)

Arriba se muestra la señal digital (nivel bajo = "0", nivel alto = "1") y abajo la portadora senoidal resultante: amplitud y frecuencia constantes en toda la señal, con un cambio (inversión) de fase de 180° cada vez que el bit cambia de valor respecto al anterior.
