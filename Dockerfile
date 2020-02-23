FROM php:5.5-apache

MAINTAINER Andrew Cole <andrew.cole@illallangi.com>

ENV PROJECT /var/www/html

RUN apt-get update && apt-get install -y sqlite php5-sqlite git openjdk-7-jre curl

RUN a2enmod rewrite
RUN a2enmod expires

RUN git clone https://github.com/kiswa/TaskBoard $PROJECT

WORKDIR $PROJECT

RUN ./build/composer.phar install
RUN ./build/composer.phar self-update
RUN ./build/build-all

RUN chmod -R +w $PROJECT/api/
RUN chown -R www-data:www-data $PROJECT/
