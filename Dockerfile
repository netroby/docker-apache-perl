FROM ubuntu:18.04

RUN \
    DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y \
        build-essential \
        apt-utils \
        ssl-cert \
        apache2 \
        apache2-utils \
        apache2-dev \
        libapache2-mod-perl2 \
        libapache2-mod-perl2-dev \
        libcgi-pm-perl \
        liblocal-lib-perl \
        cpanminus \
        libexpat1-dev \
        libssl-dev \
        mysql-client \
        libmysqlclient-dev \
        libapreq2-dev \
        zip && \
    cpanm DBD::mysql && \
    a2enmod cgid && \
    a2enmod rewrite && \
    a2dissite 000-default && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get -y clean

COPY localhost.conf /etc/apache2/sites-enabled/localhost.conf
RUN rm  /etc/apache2/conf-enabled/serve-cgi-bin.conf
RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log    
VOLUME ["/var/www/html"]

EXPOSE 80
