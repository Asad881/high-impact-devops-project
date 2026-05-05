FROM nginx:latest As builder

WORKDIR /app

COPY . . 

FROM nginx:alpine As runner

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/ /usr/share/nginx/html/

RUN chmod 664 /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx" , "-g" , "daemon off;"]