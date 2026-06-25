<p align="center">
  <img src="https://raw.githubusercontent.com/ayogun/42-project-badges/main/badges/ft_ircm.png" alt="ft_irc Badge"/>
</p>

<h1 align="center">💬 ft_irc</h1>

<p align="center">
  <strong>Internet Relay Chat Server in C++</strong><br>
  IRC server developed in C++ following the IRC protocol
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-C++-blue?style=for-the-badge&logo=cplusplus" />
  <img src="https://img.shields.io/badge/Networking-TCP/IP-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/School-42_Madrid-black?style=for-the-badge&logo=42" />
  <a href="../../README.md">
    <img src="https://img.shields.io/badge/Leer_en-Español-purple?style=for-the-badge" alt="Leer en Español" />
  </a>
</p>

---

## 📋 Table of Contents

* [About the Project](#-about-the-project)
* [Features](#-features)
* [Requirements](#-requirements)
* [Installation](#-installation)
* [Usage](#-usage)
* [IRC Commands](#-irc-commands)
* [Technical Features](#-technical-features)
* [Project Structure](#-project-structure)
* [Key Learnings](#-key-learnings)
* [Author](#-author)

---

## 🎯 About the Project

**ft_irc** is a 42 cursus project focused on building an IRC server in **C++**, capable of handling multiple clients connected at the same time through TCP sockets.

The main goal of the project is to understand how network servers work, how client-server communication is handled, and how event-driven applications manage concurrent connections.

During development, the project works with concepts such as:

* Socket programming
* IRC protocol
* TCP/IP communication
* Multiple client management
* Command parsing
* Channels, users and permissions
* Client-server architecture

---

## ✨ Features

* ✅ IRC server developed in C++
* ✅ TCP socket communication
* ✅ Multiple client support
* ✅ User and channel management
* ✅ Password authentication
* ✅ Nicknames and usernames
* ✅ Channel creation and joining
* ✅ Private messages
* ✅ Channel messages
* ✅ Channel operator management
* ✅ Basic IRC protocol commands
* ✅ Channel modes `i`, `t`, `k`, `o` and `l`
* ✅ Built-in bot with help, users, channels and joke commands
* ✅ DCC `SEND` message forwarding between clients
* ✅ Disconnection and error handling
* ✅ Compatible with IRC clients such as `irssi` or `netcat`

---

## 🛠️ Requirements

* Linux or macOS
* C++98-compatible compiler
* Make
* Recommended IRC client: `irssi`

The server accepts ports between `1024` and `65535`, and the password must contain at least one character.

### Dependency installation

On Ubuntu/Debian:

```bash
sudo apt update
sudo apt install g++ make irssi
```

---

## 📦 Installation

```bash
git clone https://github.com/MiMendiola/ft_irc.git
cd ft_irc
make
```

### Available Make commands

```bash
make        # Compiles the server
make clean  # Removes object files
make fclean # Removes object files, objs directory and executable
make re     # Rebuilds from scratch
```

---

## 🚀 Usage

Run the server:

```bash
./IRC <port> <password>
```

Example:

```bash
./IRC 6667 password123
```

Connect using `irssi`:

```bash
irssi
/connect localhost 6667 password123
```

You can also test it with `nc`:

```bash
nc localhost 6667
PASS password123
NICK miguel
USER miguel 0 * :Miguel Mendiola
```

---

## 💬 IRC Commands

Some commands supported by the server:

| Command | Description |
| ------- | ----------- |
| `PASS` | Authenticates with the server password |
| `NICK` | Sets the nickname during registration |
| `USER` | Registers user information |
| `JOIN` | Joins a channel |
| `PART` | Leaves a channel |
| `PRIVMSG` | Sends private or channel messages |
| `KICK` | Kicks a user from a channel |
| `TOPIC` | Views or changes a channel topic |
| `MODE` | Views or changes channel modes |
| `QUIT` | Disconnects from the server |
| `BOT` | Shows help, users, channels or a joke |

### Channel Modes

| Mode | Usage | Description |
| ---- | ----- | ----------- |
| `+i` / `-i` | `MODE #channel +i` | Enables or disables invite-only mode |
| `+t` / `-t` | `MODE #channel +t` | Restricts topic changes to operators |
| `+k` / `-k` | `MODE #channel +k key` | Sets or removes the channel password |
| `+o` / `-o` | `MODE #channel +o nick` | Gives or removes channel operator privileges |
| `+l` / `-l` | `MODE #channel +l limit` | Sets or removes the user limit |

> The `INVITE` command is not implemented in this version. Although `+i` mode exists, the server does not manage an invitation list.

### Built-in Bot

The `BOT` command accepts a single parameter:

```text
BOT help
BOT users
BOT channels
BOT joke
```

---

## 🔬 Technical Features

### General architecture

The server manages:

* Connected clients
* Active channels
* Incoming messages
* IRC commands
* Server replies
* Operator permissions
* Clean disconnections
* Connection and message logs in `log.txt`

Multiple clients are managed with `poll()`. The server stores pending data per client and processes each command when it receives a full line ending in `\n`.

### Main concepts

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

### Basic server flow

```text
1. Create main socket
2. Bind socket to a port
3. Listen for incoming connections
4. Accept new clients
5. Read received messages
6. Parse IRC commands
7. Execute the corresponding action
8. Send replies to the client
9. Handle disconnections
```

---

## 📁 Project Structure

```text
ft_irc/
├── Makefile
├── README.md
├── LICENSE
├── Documentation/
│   └── en/
│       └── README.en.md
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
└── log.txt          # Generated when running the server
```

---

## 🎓 Key Learnings

This project allowed me to improve my understanding of:

* Network programming with sockets
* How the IRC protocol works
* Client-server architecture
* Multiple connection management
* Command parsing and validation
* Object-oriented design in C++
* Error and disconnection handling
* Real-time communication

---

## 👤 Author

* **Miguel Mendiola** - [@MiMendiola](https://github.com/MiMendiola)

---

## 📄 License

This project is part of the 42 Madrid cursus and follows its academic rules.

---

<p align="center">
  <sub>Developed with 💻 at 42 Madrid</sub>
</p>
