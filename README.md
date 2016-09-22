# README

## Docker Nginx - Jenkis 

Este repo contiene la instalacion con docker de Nginx y Jenkis, con un virtual host llamado ci-makingdevs.com y la instalción de jenkis 

### Prepación

Tenemos que tener instalado:

```
- brew install docker
- brew install docker-machine 
```

### Creacion de docker machine 

Primeramente tenmos que tener una maquina de docker, esta puede ser virtualbox o amazon(ec2). `--driver virtualbox` o `--driver amazonec2`.

```
docker-machine create --driver virtualbox <nombre de la maquina>
```

En el caso de virtualbox no necesitamos mucho mas que el nombre y listo. En el caso de amazon necesitamos algunos parametros mas, como son el id de la vpc y la region (estos facilmente los podras encontrar desde la consola de amazon).

```
docker-machine create --driver amazonec2 --amazonec2-region us-east-1 --amazonec2-vpc-id vpc-12345617 <Nombre de la maquina>
```

En el caso de amazon es necesario tener nuestro archvio `~/.aws/credentials`

```
[default]
aws_access_key_id = <aws_access_key_id>
aws_secret_access_key = <aws_secret_access_key>
```

Con ls nos mostrara las maquinas creadas, con el nombre asignado e ip asignada

```
docker-machine ls
```
Para conectarte a la maquina basta con ingresar el siguiente comando.

```
docker-machine env <Nombre de la maquina>
```

Si no tenemos los parametros de entorno cargados, podemos ejecutar el siguiente comando 

```
eval $(docker-machine env <Nombre de maquina>)
```

Listo, con ellos tendremos lista nuestra maquina para intalar la imagen de nginx - jenkins en ella.

### Creando nuestro docker container con Nginx - Jenkins

Clonamos el repo y nos posicionamos dentro de el. El primer paso sera construir la imagen de docker la cual instalaremos a nuestra maquina previamente creada. Podremos nombrar nuestra imagen como queramos.

```
docker build -t <Nombre de la imagen> .
```

Una vez terminado tendremos lista nuestra imagen para ejecutarla.

```
docker run --name <Nombre del proceso> -p 80:80 -p 8080:8080 -d --env JAVA_OPTS="-Djava.util.logging.config.file=/logging.properties" <Nombre de la imagen>

docker ps 
```

Con `docker ps ` nos aseguramos de que el proceso se encuntre activo y listo con ellos ya tenemos un nginx y jenkis ejecutandose dentro de nuestra maquina. podremos ver nuestro jenkis ejecutando accediendo a la url de la maquina.

El Administrator password lo podremos encontrar en el log de docker 

```
docker logs <Nombre del proceso>
```

### Log de Nginx y de Jenkis 

```
docker logs -f <Nombre del proceso> | grep [nginx]

docker logs -f <Nombre del proceso> | grep [jenkins]
```

### Otros comandos utiles

```
docker stop <Nombre del proceso> --Para detener el proceso 
dokcer rm <Nombre del proceso> --Para eliminar el proceso 

docker run --name <Nombre del proceso> -d -v /Users/makingdevs/jenkins:/root/.jenkins --env JAVA_OPTS="-Djava.util.logging.config.file=/logging.properties" *Nombre-Imagen*
```

Este ultimo comando nos ayuda a correr la imagen, agregando un enlance de un directorio (Home de Jenkins) de docker a nuestra maquina en la cual estemaos ejecutando docker (Importante esto solo funciona en virtualbox no en amazon)

### Backup y Restore del volumen de docker (Home de jenkis)

Si deseamos conservar nuestra informacion de jenkis es decir toda la configuracion y jobs de jenkis es necesario usar un plugin que nos ayudara a esto. Este se conecta al bucket de s3 de amazon que le indiquemos, tanto para realizar un backup o restore de la informacion

[Dockup](https://hub.docker.com/r/wetransform/dockup/)

```
docker run --rm --env-file env.txt --volumes-from <Nombre del proceso> --name dockup wetransform/dockup:latest
```

En donde el archivo env.txt contiene informacion de nuestro s3 (Importante este tendremos que modificarlo para agregar nuestras llaves de amazon) ademas de indicarle en que bucket o carpeta deseamos realizar los respaldos, o si deseamos hacer el restore de la informacion colocando la bandera `RESTORE=true` 

La propiedad `CRON_TIME=0 0 * * *` en el archivo env.txt es el cron para el tiempo en el cual se realizara el respaldo de la información si esta propiedad no esta solo se ejecutara una sola vez el respaldo y terminara el proceso

### Exportar o importar docker machine

```
./docker-machine-export.sh <Nombre de Maquina>

./docker-machine-import.sh <zipMaquina.zip>
```
