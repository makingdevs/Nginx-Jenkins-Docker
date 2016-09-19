#! /bin/bash -e

echo "Ejecuntando script"
/sbin/nginx
java $JAVA_OPTS -jar jenkins.war 