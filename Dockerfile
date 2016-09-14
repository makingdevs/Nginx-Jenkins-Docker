FROM centos:7

RUN yum update
RUN yum -y install wget
RUN yum -y install epel-release
RUN yum -y install nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.virtual.uno.conf /etc/nginx/conf.d/virtual-uno.conf
COPY nginx.virtual.dos.conf /etc/nginx/conf.d/virtual-dos.conf

RUN wget http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war
RUN yum -y install java

COPY init.sh /usr/local/bin/init_server.sh

CMD ["sh", "/usr/local/bin/init_server.sh"]

EXPOSE 80 8080