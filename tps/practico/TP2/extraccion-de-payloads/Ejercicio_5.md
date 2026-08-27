# Extraccion de Payload — TP N°2, ejercicio 5

Redes de Computadoras (FCEFyN, UNC). Programa en Go que extrae de `frames.bin` los payloads de cada grupo, la ordena por número de secuencia y reconstruye el mensaje final.

## Uso

```bash
go run main.go
```


## Formato de las frames

El enunciado define:

```
[ GROUP 5 bytes ][ SEQ 1 byte ][ LENGTH 1 byte ][ PAYLOAD LENGTH bytes ]
       +0              +5            +6                  +7
```

`GROUP` son los primeros 5 caracteres del nombre del grupo, en minúscula y sin
acentos: `TCPánico` → `tcpan`, `Los Red(ondos)` → `los r`. De eso se encarga
`groupKey()`.

## Resultado

Este es el link de resultado que estaba escondido en `frames-bin`, este fue encontrado via fuerza bruta (IA) debido a unos problemas encontrados al intentar extraer los payloads

```
https://www.youtube.com/shorts/dbbe_ln6Lnw
```

| SEQ | Bit de inicio | GROUP | LEN | Payload | Grupo |
|----:|-------:|-------|----:|---------|-------|
| 1 | 952 | `#hidd` | 2 | `ht` | #hiddenSSID |
| 2 | 1816 | `aurac` | 1 | `t` | Auracast |
| 3 | 1511 | `bitbr` | 1 | `p` | BitBros |
| 4 | 1709 | `click` | 2 | `s:` | ClickByte |
| 5 | 237 | `death` | 1 | `/` | Death Net |
| 6 | 295 | `ferne` | 1 | `/` | no figura en la tabla de grupos |
| 7 | 2233 | `group` | 1 | `w` | Group Not Found :( |
| 8 | 2387 | `grupo` | 1 | `w` | Grupo |
| 9 | 2533 | `la la` | 2 | `w.` | LA LA LAN |
| 10 | 2620 | `lan-g` | 2 | `yo` | LAN-gustia |
| 11 | 2157 | `los r` | 2 | `ut` | Los Red(ondos) |
| 12 | 2024 | `los s` | 2 | `ub` | Los simuLANdores |
| 13 | 742 | `los_c` | 2 | `e.` | Los_CondIPcionales |
| 14 | 591 | `los-t` | 1 | `c` | Los-Tios-Networks |
| 15 | 1353 | `lost-` | 1 | `o` | Lost-Pointer-2.4 |
| 16 | 1201 | `macac` | 3 | `m/s` | MACac OS |
| 17 | 828 | `milan` | 2 | `ho` | MiLANesas |
| 18 | 1584 | `netru` | 1 | `r` | NetRunners |
| 19 | 1884 | `netru` | 2 | `ts` | NetRunners |
| 20 | 378 | `panda` | 1 | `/` | PandaBasic |
| 21 | 660 | `ping ` | 2 | `db` | Ping Floyd |
| 22 | 483 | `red h` | 2 | `be` | Red Hot Chilli Packets |
| 23 | 98 | `tcpan` | 2 | `_l` | TCPánico |
| 24 | 1283 | `wan-d` | 2 | `n6` | WAN-direction |
| 25 | 1101 | `wireg` | 3 | `Lnw` | WireGuardians |

## Anomalías

El programa las reporta como avisos, pero **no** las corrige: hay que
interpretarlas a mano.

1. **SEQ 7 — `Group Not Found :(`**: el byte de `SEQ` vale `0x20` en
   lugar de `0x07`.
2. **SEQ 10 — `LAN-gustia`**: vale `0x0d` en lugar de `0x0a`, y por eso
   choca con el `SEQ` 13 de `Los_CondIPcionales`.
3. **SEQ 12 — `Los simuLANdores`**: entre la etiqueta `los s` y su
   header se metieron los 27 bytes de relleno `TPREDESDECOMPUTADORAAASSSSS`

Además:

- **`Bitless`** no tiene ningun frame en el archivo.
- **`NetRunners`** es el único grupo con dos frames (`SEQ` 18 y 19).
- Sobra un grupo con etiqueta **`ferne`** (`SEQ` 6) que no está en la planilla.
  Sin su `/`, el link quedaría `https:/`.


## Estructura del programa

| Función | Qué hace |
|---|---|
| `groupKey()` | Deriva la etiqueta de 5 bytes a partir del nombre del grupo. |
| `searchPackages()` | Devuelve **todos** los offsets donde aparece esa etiqueta. |
| `readPacket()` | Lee `SEQ`, `LENGTH` y el payload, validando los límites del slice. |
| `searchPayloads()` | Recorre los grupos y separa los que no tienen trama. |
| `printable()` | Descarta payloads que no son ASCII (tramas mal alineadas). |

En `main()` está comentada la lista original de la planilla (24 grupos) y activa
la lista de los que realmente tienen trama: sin `Bitless` y con `ferne` agregado aunque esto siga retornando un resultado erroneo.
