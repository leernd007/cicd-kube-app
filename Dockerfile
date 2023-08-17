FROM nginx

RUN apt update -y
RUN apt install curl wget unzip -y

RUN cd /tmp && wget https://www.free-css.com/assets/files/free-css-templates/download/page293/photosec.zip
RUN cd /tmp && unzip -o photosec.zip
RUN rm -rf /usr/share/nginx/html/*
RUN cp /tmp/photosec-html/* /usr/share/nginx/html

EXPOSE 8080
