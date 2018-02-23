FROM debian

EXPOSE 143

WORKDIR /root

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y gcc
RUN apt-get install -y glib2.0-dev
RUN apt-get install -y libevent-dev
RUN apt-get install -y libgmime-2.6-dev
RUN apt-get install -y libmhash-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y libzdb-dev
RUN apt-get install -y make
RUN apt-get install -y netcat
RUN apt-get install -y pkg-config
RUN apt-get install -y postgresql-client
RUN apt-get install -y wget

RUN wget http://www.dbmail.org/download/3.2/dbmail-3.2.3.tar.gz
RUN tar xf dbmail-3.2.3.tar.gz
WORKDIR /root/dbmail-3.2.3
RUN ./configure && make && make install

COPY ./conf/dbmail.conf /usr/local/etc

COPY ./bin/entrypoint.sh /root
ENTRYPOINT ["/root/entrypoint.sh"]
