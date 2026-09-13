# Trabajo Práctico N°4 — Informe

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

## Consigna 1 — Alcance de Redes y Virtualización

### a)

> Investigar cómo se clasifican las redes según su alcance. Mencionar brevemente las características principales de cada una y colocar en cada cuadro de la Figura el acrónimo de red que corresponda.

### b)

> ¿Qué es una vLAN? ¿Cómo se clasifican?

### c)

> Investigar y resumir el protocolo IEEE 802.1Q. ¿Cómo se relaciona con las VLAN?

### d)

> En el contexto de los dos ítems anteriores ¿Qué es el Tagging?

## Consigna 2 — VLANs entre dos switches en Packet Tracer

Topología a implementar:

```
PC-A --F0/6-- [SW-1] --F0/1<->F0/1-- [SW-2] --F0/18-- PC-B
```

Tabla de direccionamiento:

| Device | Interface | IP Address    | Subnet Mask   | Default Gateway |
| ------ | --------- | ------------- | ------------- | --------------- |
| SW-1   | VLAN 1    | 192.168.1.11  | 255.255.255.0 | N/A             |
| SW-2   | VLAN 1    | 192.168.1.12  | 255.255.255.0 | N/A             |
| PC-A   | NIC       | 192.168.10.3  | 255.255.255.0 | 192.168.10.1    |
| PC-B   | NIC       | 192.168.10.4  | 255.255.255.0 | 192.168.10.1    |

### a)

> Desde cada computadora, ingresar a la terminal y configurar los switch. Nombrar a los mismos sw1 y sw2 respectivamente.

### b)

> Asignar contraseñas privilegiadas, de consola y vty.

### c)

> Encriptar las contraseñas (`service password-encryption`).

### d)

> Configurar las redes VLAN para ambos switch según la tabla de direcciones provista.

### e)

> Desconectar todas las interfaces que no estén siendo utilizadas.

### f)

> Guardar la configuración (`write memory`).

### g)

> Testear comunicación usando pings entre las computadoras.

### h)

> Crear VLANs en ambos switches: 10 (Laboratorio), 20 (Bar), 99 (Management).

### i)

> Utilizar `show vlan brief` para visualizar la lista de VLANs en alguno de los switch. ¿Cuál es la VLAN utilizada por defecto? Colocar el output en el informe.

### j)

> Asignar la PC-A a la VLAN Laboratorio.

### k)

> Desde la VLAN 1, remover la ip de Management y configurarla para funcionar en la VLAN 99 (que configuramos como Management).

### l)

> Verificar el estado de la VLAN utilizando `show vlan brief` y el estado de las interfaces utilizando `show ip interface brief`. Colocar los output en el informe e interpretar.

### m)

> Asignar la PC-B a la VLAN Laboratorio en el sw2. Repetir el inciso k) pero para el sw2.

### n)

> Verificar la conectividad entre PC-A y PC-B utilizando pings. Verificar conectividad entre sw1 y sw2 utilizando pings. Interpretar los resultados.

## Consigna 3 — VLANs, NAT y ACLs: red LAN a bordo de una aeronave

> Utilizando lo que aprendimos sobre VLAN, e investigando la configuración de NAT y ACLs, simularemos el despliegue de una red LAN a bordo de una aeronave, con tres segmentos: Clase Turista (acceso solo a un sistema de entretenimiento), Clase Business (acceso a entretenimiento e internet) y Administración (acceso total).

Tabla de direccionamiento:

| VLAN | Nombre         | Red IP         | Gateway     | Acceso              |
| ---- | -------------- | -------------- | ----------- | ------------------- |
| 10   | Turista        | 10.10.10.0/24  | 10.10.10.1  | Solo servidor        |
| 20   | Business       | 10.10.20.0/24  | 10.10.20.1  | Servidor + Internet  |
| 99   | Administración | 10.10.99.0/24  | 10.10.99.1  | Acceso total         |
| —    | Enlace ISP     | 200.0.0.0/30   | 200.0.0.1–.2| —                    |

Pruebas a realizar:

| Prueba                              | Desde       | Hacia               | Resultado esperado |
| ------------------------------------ | ----------- | -------------------- | ------------------- |
| Ping al servidor de entretenimiento   | PC Turista  | 10.10.99.10           | ✅ Responde          |
| Acceso HTTP a servidor local          | PC Turista  | http://10.10.99.10    | ✅ Carga la página   |
| Ping a Internet                       | PC Turista  | —                     | ❌ Bloqueado         |
| Acceso HTTP a servidor local          | PC Business | http://10.10.99.10    | ✅ Carga             |
| Ping a Internet (ej: 8.8.8.8)         | PC Business | —                     | ✅ Funciona          |
| Ping entre Admin y todos              | Admin PC    | —                     | ✅ Todos             |

### Diagrama de red

### Configuración (VLANs, NAT, ACLs)

### Capturas de pantalla y pruebas

### Conclusiones