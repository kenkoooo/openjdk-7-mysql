FROM mysql

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y openjdk-7-jdk memcached protobuf-compiler


