# because theses where the most stable php 5.3.x repos are!
FROM centos:centos6
MAINTAINER usman@techtraits.com

# Centos default image for some reason does not have tools like Wget/Tar/etc so lets COPY them
RUN yum -y install wget

# EPEL has good RPM goodies!
RUN rpm -Uvh   http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y install which openssh-server php-mysql php-gd php-mcrypt php-zip php-xml php-iconv php-curl php-soap php-simplexml php-pdo php-dom php-cli php-fpm nginx
RUN yum -y install tar mysql
COPY default.conf /etc/nginx/conf.d/default.conf
RUN chkconfig php-fpm on
RUN chkconfig nginx on

#install magento files 
COPY magento /var/www/
RUN cd /var/www/ && chmod -R o+w media var && chmod o+w app/etc
COPY seturl.php /var/www/seturl.php
COPY local.xml /var/www/app/etc/local.xml
COPY start.sh /start.sh
COPY generateMageCache.sh /generateMageCache.sh
RUN chmod 0755 /start.sh 
RUN chmod 0755 /generateMageCache.sh 

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
CMD /start.sh


