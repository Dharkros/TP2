# HELLO_USER_PL

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)



Este es un script que te muestra un formulario con dos campos el primero campo es "nombre" en el cual debe de introducir un nombre y el segundo es el campo "apellido" en el cual debe de introducir el primer apellido.
Advertencia!!!
El campo apellido solo debe de contener el primer apellido.

# Dependecias

  - Instalacion de built-essential.
  - Instalacion de git.
  - Instalacion de [Redis](https://github.com/antirez/redis).

### Instalación

Para instalar Redis primero debemos de instalar built-essential.

```sh
$ sudo apt-get install build-essential
```
Para instalar Redis primero debemos de instalar git para descargar mas tarde la fuente de [Redis](https://github.com/antirez/redis).

```sh
$ sudo apt-get install git
```

Mediante cpan instalamos Redis.

```sh
$ sudo cpan -i Redis
```
Para instalar redis mediante código fuente debemos de descargar la fuente de GITHUB (El contenido se guardara en la carpeta donde nos situemos)

```sh
$ sudo git clone https://github.com/antirez/redis.git
$ cd redis/src
$ make

# Editar el fichero para editar la linea "daemonize" no a "daemonize yes".
$ vi ../redis.conf

#Para arrancarlo con la configuracion. 
$ ./redis-server ../redis.conf

```

### Desarrollador
- Santiago Amo Quintero
