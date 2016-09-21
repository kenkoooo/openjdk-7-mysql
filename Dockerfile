FROM ubuntu

RUN apt-get update
RUN apt-get upgrade -y
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections && \
    apt-get -y install mysql-server

RUN sed -i -e "s/^bind-address\s*=\s*\(.*\)/#bind-address = \1/" /etc/mysql/my.cnf
RUN sed -i -e "s/\(\[mysqld\]\)/\1\ncharacter-set-server = utf8/g" /etc/mysql/my.cnf
RUN sed -i -e "s/\(\[client\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf
RUN sed -i -e "s/\(\[mysqldump\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf
RUN sed -i -e "s/\(\[mysql\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf

RUN apt-get -y install openjdk-8-jdk
RUN apt-get -y install memcached
RUN apt-get -y install gradle

ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8

CMD ["mysqld_safe"]
