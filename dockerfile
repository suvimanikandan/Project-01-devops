FROM ubuntu
RUN apt-get update
RUN apt-get install -y apache2
RUN apt-get update

RUN apt-get install -y apache2-utils
RUN apt-get update

COPY . /var/www/html/
EXPOSE 80

ENTRYPOINT ["apache2ctl"]
CMD ["-DFOREGROUND"]

