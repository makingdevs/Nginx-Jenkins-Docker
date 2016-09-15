# README

## Docker Nginx Jenkis 

Este repo contiene la instalacion con docker de Nginx y¡con un virtual host llamado ci-makingdevs.com (proximamente parametrizado) y la instalcion de jenkis 

Comandos Utiles:

* docker build -t *Nombre-Imagen* .

* docker stop *Nombre-Imagen*

* dokcer rm *Nombre-Imagen*

* docker ps 

* docker run --name webserver -v /Users/makingdevs/jenkins:/root/.jenkins *Nombre-Imagen*

