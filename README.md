<p align="center">
  <img src="https://raw.githubusercontent.com/ayogun/42-project-badges/main/badges/ft_ircm.png" alt="ft_irc Badge"/>
</p>

<h1 align="center">💬 ft_irc</h1>

<p align="center">
  <strong>Internet Relay Chat Server in C++</strong><br>
  Servidor IRC desarrollado en C++ siguiendo el protocolo IRC
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-C++-blue?style=for-the-badge&logo=cplusplus" />
  <img src="https://img.shields.io/badge/Networking-TCP/IP-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/School-42_Madrid-black?style=for-the-badge&logo=42" />
</p>

---

## 📋 Tabla de Contenidos

* [Sobre el Proyecto](#-sobre-el-proyecto)
* [Características](#-características)
* [Requisitos](#-requisitos)
* [Instalación](#-instalación)
* [Uso](#-uso)
* [Comandos IRC](#-comandos-irc)
* [Características Técnicas](#-características-técnicas)
* [Estructura del Proyecto](#-estructura-del-proyecto)
* [Aprendizajes Clave](#-aprendizajes-clave)
* [Autor](#-autor)

---

## 🎯 Sobre el Proyecto

**ft_irc** es un proyecto del cursus de 42 que consiste en desarrollar un servidor IRC en **C++**, capaz de gestionar múltiples clientes conectados simultáneamente mediante sockets TCP.

El objetivo principal del proyecto es comprender cómo funcionan los servidores de red, la comunicación cliente-servidor y la gestión de eventos en aplicaciones concurrentes.

Durante el desarrollo se trabajan conceptos como:

* Programación de sockets
* Protocolo IRC
* Comunicación TCP/IP
* Gestión de múltiples clientes
* Parsing de comandos
* Canales, usuarios y permisos
* Arquitectura cliente-servidor

---

## ✨ Características

* ✅ Servidor IRC desarrollado en C++
* ✅ Comunicación mediante sockets TCP
* ✅ Soporte para múltiples clientes
* ✅ Gestión de usuarios y canales
* ✅ Autenticación mediante contraseña
* ✅ Nicknames y usernames
* ✅ Creación y unión a canales
* ✅ Envío de mensajes privados
* ✅ Envío de mensajes a canales
* ✅ Gestión de operadores de canal
* ✅ Comandos básicos del protocolo IRC
* ✅ Modos de canal `i`, `t`, `k`, `o` y `l`
* ✅ Bot interno con comandos de ayuda, usuarios, canales y bromas
* ✅ Reenvío de mensajes DCC `SEND` entre clientes
* ✅ Manejo de desconexiones y errores
* ✅ Compatible con clientes IRC como `irssi` o `netcat`

---

## 🛠️ Requisitos

* Sistema operativo Linux o macOS
* Compilador compatible con C++98
* Make
* Cliente IRC recomendado: `irssi`

El servidor acepta puertos entre `1024` y `65535`, y la contraseña debe tener al menos un carácter.

### Instalación de dependencias

En Ubuntu/Debian:

```bash
sudo apt update
sudo apt install g++ make irssi
```

---

## 📦 Instalación

```bash
git clone https://github.com/MiMendiola/ft_irc.git
cd ft_irc
make
```

### Comandos Make disponibles

```bash
make        # Compila el servidor
make clean  # Elimina archivos objeto
make fclean # Elimina archivos objeto y ejecutable
make re     # Recompila desde cero
```

---

## 🚀 Uso

Ejecutar el servidor:

```bash
./IRC <port> <password>
```

Ejemplo:

```bash
./IRC 6667 password123
```

Conectarse usando `irssi`:

```bash
irssi
/connect localhost 6667 password123
```

También se puede probar con `nc`:

```bash
nc localhost 6667
PASS password123
NICK miguel
USER miguel 0 * :Miguel Mendiola
```

---

## 💬 Comandos IRC

Algunos comandos soportados por el servidor:

| Comando   | Descripción                          |
| --------- | ------------------------------------ |
| `PASS`    | Autenticación con contraseña         |
| `NICK`    | Define el nickname durante el registro |
| `USER`    | Registra información del usuario     |
| `JOIN`    | Unirse a un canal                    |
| `PART`    | Salir de un canal                    |
| `PRIVMSG` | Enviar mensajes privados o a canales |
| `KICK`    | Expulsar a un usuario de un canal    |
| `TOPIC`   | Ver o modificar el topic de un canal |
| `MODE`    | Consultar o cambiar modos del canal  |
| `QUIT`    | Desconectarse del servidor           |
| `BOT`     | Consultar ayuda, usuarios, canales o una broma |

### Modos de canal

| Modo | Uso | Descripción |
| ---- | --- | ----------- |
| `+i` / `-i` | `MODE #canal +i` | Activa o desactiva el modo de solo invitación |
| `+t` / `-t` | `MODE #canal +t` | Restringe el cambio de topic a operadores |
| `+k` / `-k` | `MODE #canal +k clave` | Define o elimina la contraseña del canal |
| `+o` / `-o` | `MODE #canal +o nick` | Da o quita permisos de operador a un usuario del canal |
| `+l` / `-l` | `MODE #canal +l limite` | Define o elimina el límite de usuarios del canal |

> El comando `INVITE` no está implementado en esta versión. Aunque existe el modo `+i`, no hay una lista de invitados gestionada por el servidor.

### Bot interno

El comando `BOT` acepta un único parámetro:

```text
BOT help
BOT users
BOT channels
BOT joke
```

---

## 🔬 Características Técnicas

### Arquitectura general

El servidor gestiona:

* Clientes conectados
* Canales activos
* Mensajes entrantes
* Comandos IRC
* Respuestas del servidor
* Permisos de operadores
* Desconexiones limpias
* Logs de conexiones y mensajes en `log.txt`

La gestión de múltiples clientes se realiza con `poll()`. El servidor acumula datos por cliente y procesa cada comando cuando recibe una línea completa terminada en `\n`.

### Conceptos principales

```text
Client
 ├── socket fd
 ├── nickname
 ├── username
 ├── authentication status
 ├── registration status
 └── input buffer

Channel
 ├── name
 ├── topic
 ├── users
 ├── operators
 ├── channel modes
 ├── password
 └── user limit

Server
 ├── listening socket
 ├── connected clients
 ├── active channels
 ├── poll descriptors
 ├── command parser
 └── log file
```

### Flujo básico del servidor

```text
1. Crear socket principal
2. Asociar socket a un puerto
3. Escuchar conexiones entrantes
4. Aceptar nuevos clientes
5. Leer mensajes recibidos
6. Parsear comandos IRC
7. Ejecutar la acción correspondiente
8. Enviar respuestas al cliente
9. Gestionar desconexiones
```

---

## 📁 Estructura del Proyecto

```text
ft_irc/
├── Makefile
├── README.md
├── LICENSE
├── includes/
│   ├── Channel.hpp
│   ├── Client.hpp
│   ├── Parser.hpp
│   ├── Server.hpp
│   └── Utils.h
├── src/
│   ├── Channel.cpp
│   ├── Client.cpp
│   ├── Irc.cpp
│   ├── Parser.cpp
│   ├── Server.cpp
│   └── Utils.cpp
└── log.txt          # Se genera al ejecutar el servidor
```

---

## 🎓 Aprendizajes Clave

Este proyecto me permitió profundizar en:

* Programación de red con sockets
* Funcionamiento del protocolo IRC
* Arquitectura cliente-servidor
* Gestión de múltiples conexiones
* Parsing y validación de comandos
* Diseño orientado a objetos en C++
* Gestión de errores y desconexiones
* Comunicación en tiempo real

---

## 👤 Autor

* **Miguel Mendiola** - [@MiMendiola](https://github.com/MiMendiola)

---

## 📄 Licencia

Este proyecto forma parte del cursus de 42 Madrid y está sujeto a sus normas académicas.

---

<p align="center">
  <sub>Desarrollado con 💻 en 42 Madrid</sub>
</p>
