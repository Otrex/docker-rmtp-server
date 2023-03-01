FROM nginx:latest
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget build-essential libpcre3 libpcre3-dev libssl-dev
RUN apt-get install unzip
COPY . .
# RUN wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
RUN unzip master.zip
RUN rm -f master.zip

WORKDIR /nginx-1.21.3/
RUN ls
RUN chmod +x ./nginx-rtmp-module-master/config
# RUN sleep 5
RUN ./nginx-rtmp-module-master/config --with-http_ssl_module --add-module=../nginx-rtmp-module-master --with-debug
RUN cd ./nginx-rtmp-module-master
RUN make
RUN make install

COPY nginx.conf /usr/local/nginx/conf/nginx.conf
EXPOSE 1935
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
# CMD ["sleep", "5"]