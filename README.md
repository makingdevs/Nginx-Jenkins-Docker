# README

## Docker Nginx Jenkis 

Este repo contiene la instalacion con docker de Nginx y¡con un virtual host llamado ci-makingdevs.com (proximamente parametrizado) y la instalcion de jenkis 

Comandos Utiles:

* docker build -t *Nombre-Imagen* .

* docker stop *Nombre-Imagen*

* dokcer rm *Nombre-Imagen*

* docker ps 

* docker run --name webserver -d -v /Users/makingdevs/jenkins:/root/.jenkins --env JAVA_OPTS="-Djava.util.logging.config.file=/logging.properties" *Nombre-Imagen*

* docker logs -f webserver | grep nginx-log

* docker logs -f webserver | grep jenkins-log

* docker run --rm --env-file env.txt --volumes-from webserver --name dockup wetransform/dockup:latest

* docker-machine create --driver amazonec2 --amazonec2-region us-east-1 --amazonec2-vpc-id vpc-86e9bfe3 machine-docker