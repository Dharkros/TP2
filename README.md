# LOGIN_REDIS.{PL,CGI}

[![N|Solid](https://lh3.googleusercontent.com/_eV71T0c42cBDFbnjG3GjxSkP6r5O9DcFUPVH4rtBUHHHzLs_xjE7kp51OwNxnx_l4qOsKiQi54MT90UTrfGwD7ifMiHQWlKwPL0AYs1vRC5yu027HJdAmGe300GMQrRNOs08RgA=w2400)](https://github.com/Dharkros)



Este es un script que te muestra un formulario con dos campos, el primero campo es "usuario" en el cual debe de introducir un usuario y el segundo es el campo "contraseña". Luego se muestra un segundo formulario el cual recibe datos sobre el usuario.

# Dependecias

  - Instalacion de apache2 + modulo CGI.
  - Instalacion de built-essential.
  - Instalacion de git.
  - Instalacion de [Redis](https://github.com/antirez/redis).

### Instalación

El fichero hello_user_redis.pl se debe de guarda en /usr/lib/cgi-bin/ con permiso de ejecución.

Instalamos apache2 y activamos el modulo CGI para tener el servicio web

```sh
$ sudo apt-get install apache2
```
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
