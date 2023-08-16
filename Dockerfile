FROM ubuntu

RUN apt update -y
RUN apt install curl wget unzip nginx -y

RUN cd /tmp && wget https://www.free-css.com/assets/files/free-css-templates/download/page293/photosec.zip
RUN cd /tmp && unzip -o photosec.zip
COPY /tmp/photosec-html /usr/share/nginx/html

EXPOSE 8080
