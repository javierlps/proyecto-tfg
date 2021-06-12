# Version 0.1

# Imagen básica del sistema operativo Debian 
FROM debian

# Informaciónpersona que creo esta imagen
MAINTAINER Marlene "maria80rea@gmail.com"

# Indicamos al S.O Debian que actualice los repositorios e instale apache2.
# La opción -y para aceptar todo lo que se instale, ya que no hay interacción humana
RUN apt-get -yqq update && apt-get -y install apache2

# Abre el puerto 80 dentro del contenedor
EXPOSE 80

# Copia el archivo index.html de la máquina host a la ruta indicada en el contenedor 
ADD ["index.html","/var/www/html/"]

# Instala php7.3
RUN apt-get install -y php7.3

# Instala MySQLi, es la extensión de MySQL
RUN apt-get install -y php7.3-mysqli

# Comado de inicio del contenedor en segundo plano
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
