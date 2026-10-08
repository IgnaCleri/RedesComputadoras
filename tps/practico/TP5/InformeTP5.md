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

ICMP (Protocolo de Mensajes de Control de Internet) es un protocolo de la capa de red que se utiliza para realizar diagnósticos y reportar errores. No transporta datos de aplicaciones de usuario, sino información de control exclusiva para el funcionamiento de la red.

#### b)

> ¿Qué relación tiene con IP? ¿Viaja dentro de IP, al lado de IP o debajo de IP? ¿Cómo sabe el receptor que el contenido de un paquete IP es ICMP?

ICMP es uno de los protocolos principales del conjunto IP.  El mensaje ICMP se coloca dentro del área de datos de un paquete IP normal. El receptor identifica un mensaje ICMP por medio del encabezado del paquete IP que lo envuelve. Cuando el valor del campo 'Protocolo' del encabezado IPv4 es 1, el equipo receptor identifica que los datos que viajan dentro de ese paquete IP corresponden a un mensaje ICMP.

#### c)

> ¿Qué hace ping? ¿Qué son un Echo Request y un Echo Reply? ¿Qué campos de ICMP permiten distinguirlos?

 El comando ping verifica la conectividad y mide el tiempo de latencia entre un emisor y un destino. Por ejemplo, una computadora envía un mensaje de consulta llamado Echo Request, y el equipo destino contesta con un mensaje de confirmación llamado Echo Reply. Se distinguen por el campo "Type" (Tipo) en la cabecera ICMP, en donde el valor 8 corresponde al Echo Request y el valor 0 al Echo Reply.
#### d)

> ¿Qué información mínima contiene un mensaje ICMP de tipo Echo?

 El encabezado mínimo de un mensaje Echo contiene 5 campos esenciales:

* Tipo (Type): 8 o 0.
* Código (Code): Generalmente 0 para los Echo.
* Suma de comprobación (Checksum): Para detectar errores de corrupción.
* Identificador (Identifier): Para vincular las respuestas con el programa que las solicitó.
* Número de secuencia (Sequence Number): Para saber qué paquete específico se está respondiendo.

### Configuración de red

> Averiguar la configuración de red de alguna de las computadoras del grupo: dirección IPv4, máscara, gateway por defecto y dirección MAC de la interfaz que usan (Wi-Fi o cableada).

| Parámetro      | Valor |
| -------------- | ----- |
| Interfaz       |  WIFI     |
| Dirección IPv4 |  192.168.1.4     |
| Máscara        |  255.255.255.0     |
| Gateway        |   192.168.1.1    |
| Dirección MAC  |    BC-CD-99-AA-26-7F   |

### Capas del Echo Request

> Seleccionar un Echo Request y desplegar el panel de detalles. Identificar las capas que muestra Wireshark y completar la tabla.

| Capa (como la nombra Wireshark)   | Dirección/identificador origen | Dirección/identificador destino | ¿Qué campo indica qué protocolo viene "adentro"? |
| --------------------------------- | -------------------------------| ------------------------------- | ------------------------------------------------ |
| Ethernet II                       |   bc:cd:99:aa:26:7f            | 38:a6:59:ea:01:77               |                    Type: IPv4 (0x0800)           |
| Internet Protocol Version 4       |         192.168.1.4            |             8.8.8.8             |                          Protocol: ICMP (1)      |
| Internet Control Message Protocol |             No dice              | No Dice                       | Type: Echo (ping) request (8)                    |
| Datos / payload                   |              -                 |                          -      |       abcdefghijklmnopqrstuvwabcdefghi           |

### Análisis de la captura

#### a)

> La MAC destino del Echo Request enviado a 8.8.8.8, ¿es la MAC de 8.8.8.8? ¿De qué equipo es? Compárenla con la MAC destino del ping al gateway. ¿Qué conclusión sacan sobre el alcance de una dirección MAC frente al de una dirección IP?

No, la mac 38:a6:59:ea:01:77 es la mac del router, 8.8.8.8 es el destino. 
La conclusion final es que una dirección MAC tiene alcance local, solo sirve para llegar al próximo equipo dentro de la misma red, y en cada router la trama se rearma con nuevas MAC. Una dirección IP, en cambio, identifica el destino final.
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

![alt text](image.png)

Al ejecutar arp -a, la entrada del gateway 192.168.1.1 tiene la dirección física 38-a6-59-ea-01-77, de tipo dinámico. Coincide con la MAC destino del Echo Request a 8.8.8.8 observada en el punto 1. Esto muestra que al hacer ping, la PC tomó la MAC del gateway de su caché ARP para armar la trama Ethernet.

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

| Llamada     | ¿Dónde se ejecuta? | ¿Genera tráfico? | Segmentos que observan |
| ----------- | ------------------ | ---------------- | ---------------------- |
| `socket()`  | servidor y cliente |                  |                        |
| `bind()`    | servidor           |                  |                        |
| `listen()`  | servidor           |                  |                        |
| `connect()` | cliente            |                  |                        |
| `accept()`  | servidor           |                  |                        |
| `sendall()` | servidor           |                  |                        |
| `recv()`    | servidor           |                  |                        |
| `close()`   | ambos              |                  |                        |
