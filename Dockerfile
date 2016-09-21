FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y install wget
RUN apt-get -y install nginx

VOLUME ["/root/.jenkins"]

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.virtual.conf /etc/nginx/conf.d/virtual-host.conf

RUN wget http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war

RUN apt-get -y install python3-software-properties

RUN apt-get update

RUN apt-get -y install software-properties-common

RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update

RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" |  debconf-set-selections
RUN apt-get install -y oracle-java8-installer

COPY init.sh /usr/local/bin/init_server.sh
COPY logging.properties /logging.properties

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["sh", "/usr/local/bin/init_server.sh"]

EXPOSE 80 8080