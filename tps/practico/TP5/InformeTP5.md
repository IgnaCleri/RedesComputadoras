# Trabajo Práctico N° 5 — Informe

**Grupo:** WireGuardians

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

## Consigna 1 — ICMP y primer contacto con Wireshark

### Investigación

#### a)

> ¿Qué es ICMP y para qué se usa? ¿Transporta datos de aplicaciones como lo hacen TCP o UDP?

#### b)

> ¿Qué relación tiene con IP? ¿Viaja dentro de IP, al lado de IP o debajo de IP? ¿Cómo sabe el receptor que el contenido de un paquete IP es ICMP?

#### c)

> ¿Qué hace ping? ¿Qué son un Echo Request y un Echo Reply? ¿Qué campos de ICMP permiten distinguirlos?

#### d)

> ¿Qué información mínima contiene un mensaje ICMP de tipo Echo?

### Configuración de red

> Averiguar la configuración de red de alguna de las computadoras del grupo: dirección IPv4, máscara, gateway por defecto y dirección MAC de la interfaz que usan (Wi-Fi o cableada).

| Parámetro      | Valor |
| -------------- | ----- |
| Interfaz       |       |
| Dirección IPv4 |       |
| Máscara        |       |
| Gateway        |       |
| Dirección MAC  |       |

### Capas del Echo Request

> Seleccionar un Echo Request y desplegar el panel de detalles. Identificar las capas que muestra Wireshark y completar la tabla.

| Capa (como la nombra Wireshark)   | Dirección/identificador origen | Dirección/identificador destino | ¿Qué campo indica qué protocolo viene "adentro"? |
| --------------------------------- | ------------------------------ | ------------------------------- | ------------------------------------------------ |
| Ethernet II                       |                                |                                 |                                                  |
| Internet Protocol Version 4       |                                |                                 |                                                  |
| Internet Control Message Protocol |                                |                                 |                                                  |
| Datos / payload                   |                                |                                 |                                                  |

### Análisis de la captura

#### a)

> La MAC destino del Echo Request enviado a 8.8.8.8, ¿es la MAC de 8.8.8.8? ¿De qué equipo es? Compárenla con la MAC destino del ping al gateway. ¿Qué conclusión sacan sobre el alcance de una dirección MAC frente al de una dirección IP?

#### b)

> Comparen un Echo Request con su Echo Reply (Wireshark los vincula en el campo `[Response frame: …]`). Hagan una lista de los campos que cambian y de los que se mantienen en Ethernet, IP e ICMP. ¿Por qué tiene sentido cada cambio? ¿Por qué el identificador y el número de secuencia se mantienen?

#### c)

> ¿Dónde está el payload de ping? ¿Cuántos bytes tiene y qué contiene? ¿Es igual en el Reply? Si en el grupo hay una computadora con Windows y otra con Linux, compárenlos: ¿qué les sugiere que sean distintos?

#### d)

> ¿Qué valor de TTL tiene el Echo Request que ustedes enviaron? ¿Y el Reply que llegó de 8.8.8.8? ¿Por qué no son iguales?

#### e)

> Dibujen la encapsulación del paquete que eligieron como "cajas dentro de cajas", indicando para cada caja qué tamaño en bytes tiene según Wireshark.

## Consigna 2 — ARP: de una IP a una dirección MAC

### Investigación

#### a)

> ¿Qué problema resuelve ARP? ¿En qué capa lo ubicarían y por qué es discutible?

#### b)

> ¿Qué es un ARP Request y un ARP Reply? ¿A quién se envía cada uno?

#### c)

> ¿Qué es la caché ARP y por qué existe?

#### d)

> Traten de responder con sus palabras: "Tengo la IP de una máquina de mi red local. ¿Cómo sé a qué dirección MAC debo enviarle la trama?"

#### e)

> Ver la caché ARP de su computadora y buscar la entrada del gateway. ¿La MAC asociada al gateway coincide con la MAC destino que vieron anteriormente?

### Análisis de la captura

> Analizar un ARP Request y su ARP Reply. Para cada uno completar la tabla.

| Campo                             | ARP Request | ARP Reply |
| --------------------------------- | ----------- | --------- |
| MAC destino (encabezado Ethernet) |             |           |
| MAC origen (encabezado Ethernet)  |             |           |
| Opcode                            |             |           |
| Sender MAC address                |             |           |
| Sender IP address                 |             |           |
| Target MAC address                |             |           |
| Target IP address                 |             |           |

#### a)

> ¿Por qué el Request va a una dirección broadcast y el Reply no? ¿Qué valor tiene Target MAC address en el Request y por qué?

#### b)

> En el encabezado Ethernet de la trama ARP, ¿qué valor tiene el campo Type? ¿Hay un encabezado IP? ¿Qué les dice eso sobre dónde "vive" ARP?

#### c)

> Con la Opción A (IP inexistente): ¿cuántos ARP Request aparecieron? ¿Hubo Reply? ¿Apareció algún ICMP Echo Request en la captura? Expliquen por qué.

#### d)

> Volvieron a hacer ping al mismo destino un minuto después: ¿apareció ARP de nuevo? Revisen la caché ARP. ¿Qué ventaja tiene la caché y qué problema podría causar si una entrada quedara vieja?

## Consigna 3 — TCP y UDP "a mano" con ncat

### Investigación

#### a)

> ¿Qué significa "establecer una conexión"? ¿Dónde "existe" una conexión TCP: en los cables, en los routers o en los extremos?

#### b)

> ¿Qué es un puerto? ¿Qué identifica el par (IP, puerto)?

#### c)

> ¿Qué significa que un proceso esté "escuchando" en un puerto?

### Análisis de las capturas

#### a)

> ¿Qué pasó en la red cuando ejecutaron el comando del cliente, antes de escribir el primer mensaje? Compárenlo con TCP.

#### b)

> ¿Cuántos datagramas generó cada mensaje? ¿Hay algo parecido a un ACK?

#### c)

> Comparen el encabezado UDP con el encabezado TCP de un segmento con datos: ¿qué campos tiene cada uno? ¿Cuántos bytes ocupa cada encabezado?

#### d)

> ¿Qué pasó en la red al cerrar el cliente con Ctrl+C? ¿Y en TCP?

#### e)

> Para enviar la misma frase, ¿cuántos paquetes necesitaron en total con TCP y cuántos con UDP? ¿Qué "compran" con los paquetes extra de TCP?

#### f)

> ¿Y si nadie escucha? Con Wireshark capturando en loopback y el filtro `tcp.port == 12000 || udp.port == 12001 || icmp`, sin servidores corriendo:

```text
ncat -v 127.0.0.1 12000       # TCP a un puerto cerrado
ncat -v -u 127.0.0.1 12001    # UDP a un puerto cerrado, escribir y enter
```

## Consigna 4 — Servidor TCP mínimo

> Capturando en loopback con el filtro `tcp.port == 12000` la ejecución de `tcp_server.py` y `tcp_client.py`, completar la tabla. Para cada llamada, indicar si genera tráfico y, si lo genera, qué segmentos (número de paquete en Wireshark y flags).

### Ejecución normal

Se ejecutaron ambos scripts completos, capturando en loopback con el filtro `tcp.port == 12000` (captura [`TP5-TCP-Cliente-Servidor2.pcapng`](TP5-TCP-Cliente-Servidor2.pcapng)). El cliente se ejecutó sin argumentos, por lo que se conectó a `127.0.0.1` y envió el mensaje por defecto `"Hola servidor"`.

Terminal A (servidor):

```text
$ python tcp_server.py
[servidor TCP] escuchando en 127.0.0.1:12000 ...
[servidor TCP] conexión aceptada desde 127.0.0.1:55292
[servidor TCP] recibido (13 bytes): 'Hola servidor'
[servidor TCP] respuesta enviada: 'Recibido: Hola servidor'
[servidor TCP] el cliente cerró la conexión
```

Terminal B (cliente):

```text
$ python tcp_client.py
[cliente TCP] conectado a 127.0.0.1:12000 desde 127.0.0.1:55292
[cliente TCP] enviado: 'Hola servidor'
[cliente TCP] respuesta (23 bytes): 'Recibido: Hola servidor'
```

La salida coincide con el comportamiento esperado: el puerto del cliente (55292) es un puerto efímero asignado por el sistema operativo, y la cantidad de bytes corresponde al mensaje enviado (13 bytes) y a la respuesta (23 bytes, por el prefijo `"Recibido: "`).

Los paquetes capturados fueron:

| N°  | Tiempo (s) | Sentido | Flags    | Seq | Ack | Len | Descripción                                                    |
| --- | ---------- | ------- | -------- | --- | --- | --- | -------------------------------------------------------------- |
| 1   | 0.000000   | C → S   | SYN      | 0   | 0   | 0   | Handshake (1/3): el cliente pide abrir la conexión             |
| 2   | 0.000037   | S → C   | SYN, ACK | 0   | 1   | 0   | Handshake (2/3): el servidor acepta y envía su ISN             |
| 3   | 0.000059   | C → S   | ACK      | 1   | 1   | 0   | Handshake (3/3): el cliente confirma, conexión establecida     |
| 4   | 0.000149   | C → S   | PSH, ACK | 1   | 1   | 13  | Datos del cliente: `"Hola servidor"`                           |
| 5   | 0.000160   | S → C   | ACK      | 1   | 14  | 0   | El servidor confirma los 13 bytes recibidos                    |
| 6   | 0.000388   | S → C   | PSH, ACK | 1   | 14  | 23  | Respuesta del servidor: `"Recibido: Hola servidor"`            |
| 7   | 0.000407   | C → S   | ACK      | 14  | 24  | 0   | El cliente confirma los 23 bytes recibidos                     |
| 8   | 0.000458   | C → S   | FIN, ACK | 14  | 24  | 0   | El cliente inicia el cierre (cierre activo)                    |
| 9   | 0.000539   | S → C   | FIN, ACK | 24  | 15  | 0   | El servidor confirma el FIN del cliente y envía su propio FIN  |
| 10  | 0.000584   | C → S   | ACK      | 15  | 25  | 0   | El cliente confirma el FIN del servidor                        |

Toda la conexión, desde el SYN hasta el último ACK, duró menos de 0,6 ms. En el cierre, el servidor ejecutó `conexion.close()` apenas después de recibir el FIN del cliente, antes de que venciera el *delayed ACK*, por lo que el ACK del FIN y el FIN del servidor viajaron en un mismo segmento y el cierre se vio en 3 segmentos en lugar de 4.

Como en esta ejecución todas las llamadas ocurren en menos de 1 milisegundo, no es posible saber a partir de la captura qué llamada generó cada segmento. Por eso se repitió la ejecución línea por línea, como se describe a continuación.

### Ejecución paso a paso

Se ejecutó el código de ambos scripts línea por línea en el intérprete de Python (una terminal para el servidor y otra para el cliente), observando en Wireshark qué segmentos aparecían después de cada llamada. Esta captura ([`TP5-TCP-Cliente-Servidor.pcapng`](TP5-TCP-Cliente-Servidor.pcapng)) es la que se usa para completar la tabla de llamadas y segmentos. Además de los segmentos TCP contiene tráfico DNS e ICMP ajeno a la consigna, por lo que hay que aplicar el filtro `tcp.port == 12000` al abrirla.

#### Configuración Inicial

`tcp_client.py`:

```python
import socket
import sys

SERVER_IP = sys.argv[1] if len(sys.argv) > 1 else "127.0.0.1"
MENSAJE = sys.argv[2] if len(sys.argv) > 2 else "Hola servidor"
SERVER_PORT = 12000


cliente = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
cliente.settimeout(5)  

```
`tcp_server.py`:

```python
import socket
import sys

HOST = sys.argv[1] if len(sys.argv) > 1 else "127.0.0.1"
PORT = int(sys.argv[2]) if len(sys.argv) > 2 else 12000

servidor = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
servidor.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
servidor.bind((HOST, PORT))
servidor.listen(1)
print(f"[servidor TCP] escuchando en {HOST}:{PORT} ...")

```

En esta etapa no hubo envío de paquetes de ningún tipo, ya que ambos cliente y servidor están configurando los sockets de conexión (cliente) y el de escucha (servidor), en el caso del servidor además este se queda escuchando en el socket a la espera de recibir un paquete.

#### Inicio de conexión Cliente-Servidor

`tcp_client.py`:

```python
try:
    cliente.connect((SERVER_IP, SERVER_PORT))
except ConnectionRefusedError:
    sys.exit("[cliente TCP] conexión rechazada: el host respondió, pero nadie escucha en ese puerto (RST)")
except (socket.timeout, TimeoutError):
    sys.exit("[cliente TCP] sin respuesta al intento de conexión (¿firewall? ¿IP equivocada? ¿aislamiento de clientes?)")
ip_local, puerto_local = cliente.getsockname()
print(f"[cliente TCP] conectado a {SERVER_IP}:{SERVER_PORT} desde {ip_local}:{puerto_local}")

```
En este paso únicamente se intenta la conexión con el servidor, y se imprime la IP y puerto del servidor junto con la IP y puerto local del cliente (`getsockname()`). Este último es un puerto efímero elegido por el sistema operativo, ya que el cliente nunca llamó a `bind()`.

Los paquetes capturados fueron:

| N°  | Tiempo (s)   | Sentido | Flags    | Seq | Ack | Len | Descripción                                                |
| --- | ------------ | ------- | -------- | --- | --- | --- | ---------------------------------------------------------- |
| 338 | 642.028002   | C → S   | SYN      | 0   | 0   | 0   | Handshake (1/3): el cliente pide abrir la conexión         |
| 339 | 642.028046   | S → C   | SYN, ACK | 0   | 1   | 0   | Handshake (2/3): el servidor acepta y envía su ISN         |
| 340 | 642.028071   | C → S   | ACK      | 1   | 1   | 0   | Handshake (3/3): el cliente confirma, conexión establecida |

Estos paquetes son el Three-Way-Handshake que inicia la conexión, generado completamente durante el `connect()` del cliente.

#### Envío Cliente-Servidor

`tcp_server.py`:

```python
conexion, direccion_cliente = servidor.accept()
print(f"[servidor TCP] conexión aceptada desde {direccion_cliente[0]}:{direccion_cliente[1]}")

datos = conexion.recv(1024)

mensaje = datos.decode("utf-8", errors="replace")
print(f"[servidor TCP] recibido ({len(datos)} bytes): {mensaje!r}")

```
`tcp_client.py`:

```python
cliente.sendall(MENSAJE.encode("utf-8"))
print(f"[cliente TCP] enviado: {MENSAJE!r}")
```

En este paso el servidor crea un nuevo socket específico para ese cliente y espera para recibir datos, luego imprime lo recibido, y el cliente simplemente envía el mensaje 'Hola servidor'.

Cabe aclarar que no todas las llamadas de este paso generan tráfico. El paquete lo genera el `sendall()` del cliente, y el ACK lo envía el kernel del servidor después de recibir los datos, no el `recv()`, que solo lee del buffer de recepción.

Los paquetes capturados en este paso fueron:

| N°  | Tiempo (s)   | Sentido | Flags    | Seq | Ack | Len | Descripción                                                |
| --- | ------------ | ------- | -------- | --- | --- | --- | ---------------------------------------------------------- |
| 363 | 844.233631   | C → S   | PSH, ACK | 1   | 1   | 13  | Datos del cliente: `"Hola servidor"`                       |
| 364 | 844.233663   | S → C   | ACK      | 1   | 14  | 0   | El servidor confirma los 13 bytes recibidos                |

#### Envío Servidor-Cliente

`tcp_server.py`:

```python
respuesta = f"Recibido: {mensaje}"
conexion.sendall(respuesta.encode("utf-8"))
print(f"[servidor TCP] respuesta enviada: {respuesta!r}")
```
`tcp_client.py`:

```python
datos = cliente.recv(1024)
print(f"[cliente TCP] respuesta ({len(datos)} bytes): {datos.decode('utf-8', errors='replace')!r}")

```

En este paso el servidor genera una respuesta y la envía, mientras que el cliente recibe con `recv()` los datos enviados. Al igual que antes, los datos enviados los genera el `sendall()` del servidor, mientras que el ACK lo envía el kernel del cliente después de recibir los datos, independientemente de su `recv()`.

Los paquetes capturados en este paso fueron:

| N°  | Tiempo (s)   | Sentido | Flags    | Seq | Ack | Len | Descripción                                                |
| --- | ------------ | ------- | -------- | --- | --- | --- | ---------------------------------------------------------- |
| 365 | 1199.263997  | S → C   | PSH, ACK | 1   | 14  | 23  | Respuesta del servidor: `"Recibido: Hola servidor"`        |
| 366 | 1199.264035  | C → S   | ACK      | 14  | 24  | 0   | El cliente confirma los 23 bytes recibidos                 |

#### Cierre de Conexión


`tcp_client.py`:

```python
# El cliente termina la conexión
cliente.close()
```
`tcp_server.py`:

```python
while conexion.recv(1024):
    pass
print("[servidor TCP] el cliente cerró la conexión")

# ...
# Para que se viera explícitamente el Four-Way-Handshake final se espera entre el cierre de cliente y de servidor
# ...
conexion.close()
servidor.close()
```
En este paso el cliente termina su conexión. Al recibir el FIN, el kernel del servidor no envía el ACK de inmediato sino que espera un momento (*delayed ACK*) por si puede enviarlo junto con otro segmento. En una ejecución normal el servidor cierra su conexión casi al mismo tiempo, dentro de esa espera, causando que el ACK y su FIN viajen en un mismo segmento (*piggybacking*) y que no se vean los 4 envíos explícitos en Wireshark (paquete 9 de la ejecución normal). Como se ejecutó línea por línea, se esperó un tiempo entre el cierre del cliente y el del servidor: el kernel envió el ACK solo debido a este tiempo, por lo que se pueden ver los 4 paquetes.

Los paquetes capturados en este paso fueron:

| N°  | Tiempo (s)   | Sentido | Flags    | Seq | Ack | Len | Descripción                                                |
| --- | ------------ | ------- | -------- | --- | --- | --- | ---------------------------------------------------------- |
| 369 | 1493.299798  | C → S   | FIN, ACK | 14  | 24  | 0   | El cliente inicia el cierre (cierre activo)                |
| 370 | 1493.340865  | S → C   | ACK      | 24  | 15  | 0   | El servidor confirma el FIN del cliente                    |
| 371 | 1514.113160  | S → C   | FIN, ACK | 24  | 15  | 0   | El servidor cierra su sentido de la conexión               |
| 372 | 1514.113203  | C → S   | ACK      | 15  | 25  | 0   | El cliente confirma el FIN del servidor                    |


### Llamadas y segmentos

| Llamada     | ¿Dónde se ejecuta? | ¿Genera tráfico?       | Segmentos que observan                                                                                                                                                                                       |
| ----------- | ------------------ | ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `socket()`  | servidor y cliente | No                     | —                                                                                                                                                                                                            |
| `bind()`    | servidor           | No                     | —                                                                                                                                                                                                            |
| `listen()`  | servidor           | No                     | —                                                                                                                                                                                                            |
| `connect()` | cliente            | Sí, inicio de conexión | 338 [SYN] (C → S)<br>339 [SYN, ACK] (S → C, respuesta del kernel del servidor)<br>340 [ACK] (C → S)                                                                                                          |
| `accept()`  | servidor           | No                     | —                                                                                                                                                                                                            |
| `sendall()` | servidor y cliente | Sí, envío de datos     | Cliente: 363 [PSH, ACK] (C → S) + 364 [ACK] del kernel del servidor<br>Servidor: 365 [PSH, ACK] (S → C) + 366 [ACK] del kernel del cliente                                                                   |
| `recv()`    | servidor y cliente | No                     | —                                                                                                                                                                                                            |
| `close()`   | ambos              | Sí, cierre de conexión | Cliente: 369 [FIN, ACK] (C → S) + 370 [ACK] del kernel del servidor<br>Servidor (`conexion`): 371 [FIN, ACK] (S → C) + 372 [ACK] del kernel del cliente<br>Servidor (`servidor`, socket de escucha): ninguno |

> Los números de paquete corresponden a la captura de la ejecución paso a paso (`TP5-TCP-Cliente-Servidor.pcapng`). En la ejecución normal (`TP5-TCP-Cliente-Servidor2.pcapng`) los mismos segmentos son los paquetes 1–3 (`connect()`), 4–7 (`sendall()`) y 8–10 (`close()`), con el cierre en 3 segmentos.

### ¿Hacía falta usar puertos distintos para TCP y UDP?

En el enunciado se usa el puerto 12000 para TCP y el 12001 para UDP. En realidad no era necesario que fueran distintos: cuando llega un paquete, el sistema operativo primero mira el campo *Protocol* del encabezado IP (6 = TCP, 17 = UDP) para decidir a qué protocolo de transporte entregarlo, y recién después busca el puerto. Cada protocolo de transporte administra su propio espacio de puertos, por lo que un proceso puede escuchar en TCP 12000 y otro en UDP 12000 al mismo tiempo sin conflicto. Un ejemplo real es DNS, que usa el puerto 53 tanto en UDP como en TCP.

Se eligieron puertos distintos por una cuestión práctica: así los filtros de Wireshark quedan claramente separados y no se mezclan los paquetes al comparar las capturas de TCP y UDP.
