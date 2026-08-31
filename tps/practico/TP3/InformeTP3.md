# Trabajo Práctico N°3 — Informe

**Grupo:** WireGuardians

**Integrantes del Grupo:**

| Name                            | DNI      | Mail UNC                          | Github                                                            |
| ------------------------------- | -------- | --------------------------------- | ----------------------------------------------------------------- |
| Viberti, Benjamin               | 46224179 | b.viberti@mi.unc.edu.ar           | [@benjaviberti](https://github.com/benjaviberti)                   |
| Espinoza Sutta, Aaron Alejandro | 96009173 | aaron.espinoza_4500@mi.unc.edu.ar | [@Aaron45000](https://github.com/Aaron45000)                       |
| Cleri, Juan Ignacio             | 46452662 | ignacio.cleri@mi.unc.edu.ar       | [@IgnaCleri](https://github.com/IgnaCleri)                         |
| Pineda, Juan Ignacio            | 45591343 | juan.ignacio.pineda@mi.unc.edu.ar | [@juanignaciopineda-dot](https://github.com/juanignaciopineda-dot) |
| Grafión, Atilio Leonel          | 43940195 | atilio.grafion@mi.unc.edu.ar      | [@Aollgn](https://github.com/Aollgn)                               |
| Badenes, Tomas                  | 44785038 | tomasbadenes@mi.unc.edu.ar        | [@b-Tomas](https://github.com/b-Tomas)                             |
| Oviedo, Ignacio Nicolas         | 43940195 | ignacio.oviedo.239@mi.unc.edu.ar  | [@GIX02](https://github.com/GIX02)                                 |
| Mendez, Jorge Nicolas           | 41301342 | jorge.mendez@mi.unc.edu.ar        | [@jorge088](https://github.com/jorge088)                           |

## Consigna 1

### a)

### b)

### c)

### d)

## Consigna 2

### a)

### b)

### c)

### d)

## Consigna 3

### a)

### b)

### c)

### d)

### e)

### f)

## Consigna 4

### Configuración del cliente

Se levantó una instancia de **PacketSender** en modo cliente y se estableció una conexión TCP
contra el servidor, utilizando la opción **Persistent TCP** para mantener la sesión abierta durante todo el intercambio:

Cada comando se envió como carga útil ASCII, tal como pedia la consigna.

### Comandos enviados y respuestas obtenidas

![Comunicación con el servidor](imagenes/image.png)

| Comando enviado  | Respuesta del servidor  |
| ---------------- | ----------------------- |
| `hola\r`         | `hola :)\n`             |
| `ping\r`         | `pong\n`                |
| `wireguardians\r`| `seq: 25, payload: cQ\n`|

El comando correspondiente a nuestro grupo (**wireguardians**) fue reconocido como comando
válido por el servidor, que respondió con el par `seq: 25, payload: cQ`: el número de secuencia
que nos corresponde dentro del conjunto de grupos y el fragmento de información que nos tocó.

### Captura de la sesión con Wireshark

![Captura de paquetes en Wireshark](imagenes/image-1.png)

La captura se filtró con `tcp.port == 5555 or tcp.port == 40527` para aislar únicamente la
conversación con el servidor. Sobre los paquetes capturados se puede observar:

- El intercambio sigue el patrón **pedido / respuesta / confirmación**: por cada comando el
  cliente envía un segmento `[PSH, ACK]`, el servidor contesta con otro `[PSH, ACK]` que
  transporta la respuesta y el cliente cierra el ciclo con un `[ACK]` sin datos (`Len=0`).
- Los números de secuencia y de acuse avanzan exactamente en la cantidad de bytes
  transportados: `Seq=1 Len=5` (`hola\r`) → el servidor responde con `Ack=6` y `Len=8`
  (`hola :)\n`), y así sucesivamente hasta `Seq=25 Ack=35`
- El detalle del *frame* 182 muestra el encapsulamiento completo de las capas vistas en el
  práctico: **Ethernet II** (Src `00:e0:4c:68:0e:87`) → **IPv4** (Src `192.168.0.106`,
  Dst `34.136.251.235`) → **TCP** (Src Port `40527`, Dst Port `5555`) → **Data (5 bytes)**.
- En el panel de bytes se lee la carga útil en claro: `hola\r`.

La captura completa se encuentra en
[`Captura de Paquetes/Ejercicio4-CapturaPaquetes.pcapng`](Captura%20de%20Paquetes/Ejercicio4-CapturaPaquetes.pcapng)
(interfaz `enp3s0f3u1u1`, 3789 paquetes registrados a lo largo de 191 s). De ese total, el
filtro aísla **16 paquetes** que constituyen la totalidad de la conexión con el servidor, desde
su apertura hasta su cierre.

#### Detalle de los 16 paquetes de la conversación

| N.º  | t (s)   | Origen → Destino               | Flags    | Seq | Ack | Len | Frame | Carga útil               |
| ---- | ------- | ------------------------------ | -------- | --- | --- | --- | ----- | ------------------------ |
| 75   | 6,011   | 192.168.0.106 → 34.136.251.235 | SYN      | 0   | 0   | 0   | 74 B  | —                        |
| 78   | 6,206   | 34.136.251.235 → 192.168.0.106 | SYN, ACK | 0   | 1   | 0   | 74 B  | —                        |
| 79   | 6,206   | 192.168.0.106 → 34.136.251.235 | ACK      | 1   | 1   | 0   | 66 B  | —                        |
| 182  | 13,218  | 192.168.0.106 → 34.136.251.235 | PSH, ACK | 1   | 1   | 5   | 71 B  | `hola\r`                 |
| 185  | 13,412  | 34.136.251.235 → 192.168.0.106 | ACK      | 1   | 6   | 0   | 66 B  | —                        |
| 186  | 13,412  | 34.136.251.235 → 192.168.0.106 | PSH, ACK | 1   | 6   | 8   | 74 B  | `hola :)\n`              |
| 187  | 13,412  | 192.168.0.106 → 34.136.251.235 | ACK      | 6   | 9   | 0   | 66 B  | —                        |
| 324  | 22,629  | 192.168.0.106 → 34.136.251.235 | PSH, ACK | 6   | 9   | 5   | 71 B  | `ping\r`                 |
| 325  | 22,817  | 34.136.251.235 → 192.168.0.106 | PSH, ACK | 9   | 11  | 5   | 71 B  | `pong\n`                 |
| 326  | 22,817  | 192.168.0.106 → 34.136.251.235 | ACK      | 11  | 14  | 0   | 66 B  | —                        |
| 413  | 29,230  | 192.168.0.106 → 34.136.251.235 | PSH, ACK | 11  | 14  | 14  | 80 B  | `wireguardians\r`        |
| 418  | 29,421  | 34.136.251.235 → 192.168.0.106 | PSH, ACK | 14  | 25  | 21  | 87 B  | `seq: 25, payload: cQ\n` |
| 419  | 29,421  | 192.168.0.106 → 34.136.251.235 | ACK      | 25  | 35  | 0   | 66 B  | —                        |
| 3113 | 151,020 | 192.168.0.106 → 34.136.251.235 | FIN, ACK | 25  | 35  | 0   | 66 B  | —                        |
| 3119 | 151,220 | 34.136.251.235 → 192.168.0.106 | FIN, ACK | 35  | 26  | 0   | 66 B  | —                        |
| 3120 | 151,220 | 192.168.0.106 → 34.136.251.235 | ACK      | 26  | 36  | 0   | 66 B  | —                        |

#### Apertura de la conexión: three-way handshake

Los frames 75, 78 y 79 registran el establecimiento de la conexión:

1. **`SYN`** (75): el cliente propone la conexión desde el puerto 40527
2. **`SYN, ACK`** (78): envía su propio número de secuencia inicial y acusa el del cliente con `Ack=1`.
3. **`ACK`** (79): el cliente confirma. A partir de aquí la conexión está establecida y ambos extremos pueden enviar datos.

Nótese que los dos primeros segmentos miden 74 bytes y llevan cabecera TCP de **40 bytes** (20 fijos
+ 20 de opciones), mientras que del `ACK` en adelante la cabecera baja a **32 bytes**: las opciones
de negociación sólo se transmiten en el handshake.

#### Cierre de la conexión: four-way handshake

Al cerrar la ventana de chat de PacketSender se capturó el cierre:

1. **`FIN, ACK`** (3113): el cliente indica que no tiene más datos para enviar.
2. **`FIN, ACK`** (3119): el servidor acusa el `FIN` del cliente (`Ack=26`) y, en el mismo segmento,
   envía su propio `FIN`.
3. **`ACK`** (3120): el cliente acusa el `FIN` del servidor (`Ack=36`) y la conexión queda cerrada.

Aunque el cierre son cuatro pasos (`FIN` → `ACK` → `FIN` → `ACK`), en la práctica se
observan **sólo tres segmentos**: el servidor fusionó su `ACK` con su propio `FIN` en un único
paquete, optimización habitual cuando el extremo pasivo tampoco tiene datos pendientes.

Wireshark confirma que la conversación quedó registrada íntegramente:

```
[Conversation completeness: Complete, WITH_DATA (31)]
    RST: Absent   FIN: Present   Data: Present
    ACK: Present  SYN-ACK: Present   SYN: Present
    [Completeness Flags: ·FDASS]
```

### Resultado colectivo

Al reunir realizar el experimento con el nombre de todos los demas grupos  y ordenarlos por número de secuencia, los fragmentos se concatenan reconstruyendo el mensaje oculto que el servidor repartió entre todos los grupos:


| Nombre | Seq | Payload |
|--------|-----|---------|
|#hiddenSSID| 1   | ht      |
|Auracast| 2   | tp      |
|BitBros| 3   | s:      |
|Bitless| 4   | //      |
|ClickByte| 5   | ww      |
|Death Net| 6   | w.      |
|Fernet Modulation| 7   | yo      |
|Group Not Found :(| 8   | u       |
|Grupo| 9   | t       |
|LA LA LAN| 10  | ub      |
|LAN-gustia| 11  | e       |
|Los Red(ondos)| 12  | .c      |
|Los simuLANdores| 13  | om      |
|Los_CondIPcionales| 14  | /w      |
|Los-Tios-Networks| 15  | a       |
|Lost-Pointer-2.4| 16  | t       |
|MACac OS| 17  | ch      |
|MiLANesas| 18  | ?       |
|NetRunners| 19  | v=      |
|PandaBasic| 20  | d       |
|Ping Floyd| 21  | Qw      |
|Red Hot Chilli Packets| 22  | 4w      |
|TCPanico| 23  | 9W      |
|WAN-direction| 24  | gX      |
|WireGuardians| 25  | cQ      |

Concatenando los payloads en orden de secuencia se obtiene:


[Link de Resultado nada sospechoso](https://www.youtube.com/watch?v=dQw4w9WgXcQ)


