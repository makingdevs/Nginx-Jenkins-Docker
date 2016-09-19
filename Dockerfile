FROM centos:7

RUN yum update
RUN yum -y install wget
RUN yum -y install epel-release
RUN yum -y install nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.virtual.conf /etc/nginx/conf.d/virtual-host.conf

RUN wget http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war
RUN yum -y install java

COPY init.sh /usr/local/bin/init_server.sh
COPY logging.properties /logging.properties

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["sh", "/usr/local/bin/init_server.sh"]

EXPOSE 80 8080