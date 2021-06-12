#!/bin/bash

## Funcion de ayuda al usuario. Descripcion de uso del programa.Se usa una estructura heredoc.
function ayuda () {
cat << DESCRPCION_AYUDA
	$(echo -e "\e[31mUSO DEL PROGRAMA\e[0m")
SYNOPSIS
	$0	o	bash $0
DESCRIPCION
	Iniciara la comprobación en el equipo para ver si los programas requeridos
	estan instalados o no. Segun este o no, iniciara la instalacion segun la respuesta
	del usuario, de estar ya instalados solo mostrara un mensaje de verificacion. Es importante
	saber que si no se instalan de no estarlos ya los tres primeros, el programa se cerrara.
	Los dos ultimos son opcionales y solo accesibles si se cumple el anterior requisito, es decir,
	si se cuemplen los requisitos, se podra de forma opcional, desplegar el entorno si se encuentra
	el fichero [ docker-compose.yml ]. Tambien, si se desea, se podra instalar el programa editor
	de codigo, Visual Studio Code.

	$(echo -e "\e[31mOPCIONES --help Y --debug\e[0m")
SYNOPSYS
	$0 --help
DESCRIPTION
 	Esta opcion desplegara este menu donde podra saber las opciones del programa y su uso.

SYNOPSYS
	$0 --debug
DESCRIPTION
	Esta opcion permite ejecutar el programa en modo depuracion, es decir, ejecutara linea a linea
	y comprobara que no haya ningun error en el codigo.

	$(echo -e "\e[31mCODIGOS DE RETORNO\e[0m")

CODIGOS
	1 El programa tiene que ejecutarse como root o con permisos de sudo.
	2 Excede el numero de argumentos.
	3 Depurar el programa.
	4 Menu de ayuda.
	5 No esta instalado docker ni se pudo instalar.
	6 Opcion no permitida.
	7 No esta instalado docker-compose ni se pudo instalar.
	8 Opcion no permitida.
	9 No esta instalado git ni se puedo instalar.
	10 Opcion no permitida.
	11 Opcion no permitida.
	12 No se instalara VSC.
	13 Opcion no permitida.
DESCRPCION_AYUDA
}


## Funcion depurar, permite encontrar errores en el codigo mientras se ejecutas.
function debug (){
/bin/bash -x -v instalacion_de_software.sh
}

# Comprobacion de usuario Root o con permisos de este usando un condicional if.
if [ "${USER}" != "root" ]
then
    echo "Para ejecutar este programa uste debe ser root o ejecutar el programa con sudo"
    exit 1
fi


# Si el número de argumentos es 2 o mas. Usando un condicional if.
if [ $# -ge 2 ]
then
	echo "Número de argumentos no válido, solo admite 1, [ $0 --debug o $0 --help ]"
	exit 2
fi

# Si el primer argumento es: --debug o --help o no tiene. Si tiene otro que no sean los anteriores casos, salir del programa.
if [ "$1" == "--debug" ]
then
	debug
	exit 3
elif [ "$1" == "--help" ]
then
	ayuda
	exit 4
elif [ "$1" == "" ]
then
	echo "Iniciando el programa, espere unos segundos."
	echo
	sleep 5
else
	echo "Opcion no valida. Pruebe a ejecutar [ $0 --help ] para saber como funciona el programa."
	exit 0
fi


## Instalacion de Docker. Hace la comprobación del lugar donde esta el comando, si no devuelve nada es que no esta instalado y se inicia el proceso de instalacion si la respuesta es Si.
if [ "$(which docker)" == "" ]
then
	# Se pregunta al usuario si desea iniciar la instalación con el comando: read -p una_frase: variable
	read -p "Docker no está instalado, ¿Quieres instalar Docker en su sistema? (s/n): " RES
	echo
	# Si la respues es afirmativa, se iniciara el proceso. Usando un condicional if, se ejecutara 1 de los tres casos.
	if [ "$RES" == "s" ]
	then
		echo "Se procede a actualizar su lista de paquetes existente."
		echo
		sleep 5
		apt update -y
		echo
		echo "Instalando software adicional."
		echo
		sleep 5
		sudo apt install apt-transport-https ca-certificates curl software-properties-common
		echo
		echo "Agregando la clave GPG para el repositorio oficial de Docker a su sistema."
		echo
		sleep 5
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
		echo
		echo "Agregando el repositorio de Docker a las fuentes de APT"
		echo
		sleep 5
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
		echo
		echo "Actualizando la base de datos de paquetes usando los paquetes de Docker del repositorio que se acaban de agregar."
		echo
		sleep 5
		sudo apt update
		echo
		echo "Asegurando de que va a instalar desde el repositorio de Docker en vez del repositorio de Ubuntu predeterminado."
		echo
		sleep 5
		apt-cache policy docker-ce
		echo
		sleep 5
		echo "Instalando Docker"
		echo
		sleep 5
		sudo apt install docker-ce
		echo
		echo "Verificación de la instalación. Su versión instalada es la siguiente:"
		echo
		docker --version
		sleep 3
		echo
	# Si la respuesta es negativa, no se iniciara el proceso y devolvera un mensaje.
	elif [ "$RES" == "n" ]
	then
		echo "No se instalará Docker. Se cerrara el programa porque es necesario tenerlo instalado."
		exit 5
	else
		# Si se responde con otra cosa que no sera (s/n) se cancelara el programa y lanzara un mensaje.
		echo "Respuesta no permitida, debe contestar con: "s" o con "n"."
		exit 6
	fi
else
	# El programa ya esta instalado. Mostrará un mensaje y version del mismo.
	echo "Docker ya esta instalado en su sistema"
 	docker --version
 	sleep 3
 	echo
fi

## Instalacion de Docker-Compose

# Si el resultado del comando  es nada, es que no esta instalado y se iniciara la posibilidad de su instalacion.
if [ "$(which docker-compose)" == "" ]
then
	# Se pregunta al usuario si desea instalar el programa.
        read -p "Docker-Compose no está instalado, ¿Quieres instalar Docker-Compose en su sistema? (S/N): " RES1
        echo
	# En el caso que se responda de forma afirmativa, se inicia el proceso, si es negativa, se mostrara un mensaje y se cancelara el programa. De otra forma de respuesta, se saldra del programa. 
	case $RES1 in
    		[Ss]*)
			echo "Se descargará la versión 1.29.2 y guardará el archivo ejecutable en /usr/local/bin/docker-compose, que hará que este software esté globalmente accesible como docker-compose"
			echo
			sleep 5
			sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
			echo
			echo "Aplicando permisos de ejecución"
			echo
			sleep 5
			sudo chmod +x /usr/local/bin/docker-compose
			echo
			echo "Verificación de la instalación. Su versión instalada es la siguiente:"
			echo
                	docker-compose --version
			sleep 3
			echo
			;;
    		[Nn]*)
			echo "No se instalará Docker-Compose en su sistema. Se cerrara el programa porque es necesario tenerlo instalado."
			exit 7
			;;
    		*)
			echo "Por favor, responda (S/N). Vuelva a intentarlo de nuevo"
			exit 8
			;;
  	esac
else
	echo "Docker compose ya está instalado en su sistema."
        docker-compose --version
        sleep 3
        echo
fi

## Instalacion de Git

# Misma estructura que las anteriores, usando el estructura case, preguntara por la ubicación del comando y de no encontrarlo, entendera que no esta instalado.
if [ "$(which git)" == "" ]
then
        read -p "Git no está instalado, ¿Quieres instalar Git en su sistema? (S/N): " RES2
        echo
        case $RES2 in
                [Ss]*)
                        echo "Actualizando su índice local de paquetes."
			echo
                        sleep 5
                        apt update
                        echo
                        echo "Instalación de Git"
			echo
                        sleep 5
                        apt install git
                        echo
                        echo "Verificación de la instalación. Su versión instalada es la siguiente:"
                        echo
                        git --version
			sleep 3
			echo
                        ;;
                [Nn]*)
                        echo "No se instalará Git en su sistema. Se cerrara el programa porque es necesario tenerlo instalado."
                        exit 9
                        ;;
                *)
                        echo "Por favor, responda (S/N). Vuelva a intentarlo de nuevo."
                        exit 10
                        ;;
        esac
else
        echo "Git ya está instalado en su sistema."
        git --version
        sleep 3
        echo
fi

## Ejecución del entorno
# Si en el directorio actual no existe un fichero llamado asi, entendera que no hay ninguno. Si detecta alguno, preguntara al usuario si desea ejecutarlo. con una estructura case.
if [ "docker-compose.yml" == "$(ls | grep "docker-compose.yml")" ]
then
	read -p "Se ha detectado el fichero docker-compose.yml, ¿quieres desplegar el entorno? " RES3
        echo
        case $RES3 in
                [Ss]*)
                        docker-compose up -d
                        echo
                        ;;
                [Nn]*)
                        echo "No se desplego el entorno, puede usar el comando: [docker-compose up -d] para hacerlo cuando quiera."
			echo
                        ;;
                *)
                        echo "Por favor, responda (S/N). Vuelva a intentarlo de nuevo."
			echo
                        exit 11
                        ;;
        esac
else
	echo "No se ha detectado el fichero docker-compose.yml"
	sleep 3
	echo
fi

## Instalacion de VSC
if [ "$(which code)" == "" ]
then
        read -p "Visual Studio Code no está instalado en su sistema, ¿Quieres instalar VSC? (S/N): " RES3
        echo
        case $RES3 in
                [Ss]*)
                        echo "Actualizando el índice de paquetes e instalar las dependencias necesarias."
			echo
                        sleep 5
                        apt update; sudo apt install software-properties-common apt-transport-https wget
                        echo
                        echo "Importando la clave GPG de Microsoft utilizando wget"
			echo
                        sleep 5
                        wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
                        echo
                        echo "Habilitando el repositorio de VSC."
			echo
			sleep 5
			sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
                        echo
			echo "Iniciando la instalación del paquete VSC."
			echo
			sleep 5
			sudo apt install code
			echo
			echo "Actualizando el paquete de Visual Studio Code."
			echo
			sleep 5
			apt update && sudo apt upgrade
			echo
			echo "Puede comprobar la versión de su VSC con el siguiente comando: code --version"
			echo
			echo "Es posible que necesite instalar extensiones adicionales para mejorar su experiencia con VSC y trabajar con distintos lenguajes de pregamacion."
			echo
                        ;;
                [Nn]*)
                        echo "No se instalará VSC en su sitema."
                        exit 12
                        ;;
                *)
                        echo "Por favor, responda (S/N). Vuelva a intentarlo de nuevo."
                        exit 13
                        ;;
        esac
else
        echo "VSC ya está instalado en su sistema, puedes comprobar su version con: code --version"
        sleep 3
        echo
fi
