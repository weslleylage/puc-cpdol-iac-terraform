FROM nginx

WORKDIR /usr/share/nginx/html

COPY ./app .

EXPOSE 80