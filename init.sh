#! /bin/bash -e

echo "Ejecuntando script"
service nginx start
java $JAVA_OPTS -jar jenkins.war 