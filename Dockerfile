FROM centos:7

RUN yum update
RUN yum -y install epel-release
RUN yum -y install nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.virtual.uno.conf /etc/nginx/conf.d/virtual-uno.conf
COPY nginx.virtual.dos.conf /etc/nginx/conf.d/virtual-dos.conf

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]