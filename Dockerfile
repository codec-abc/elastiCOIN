FROM debian:jessie

RUN apt-get update \
    && apt-get install -y \
        curl \
        ntpdate \
        python3-pip \
        git \
        build-essential \
        libxml2-dev \
        libxslt1-dev \
        libffi-dev \
        libssl-dev \
        zlib1g-dev \
        python3-dev \
        python3-lxml \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install -U setuptools
RUN pip3 install Scrapy scrapyd scrapyd-client

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update
RUN apt-get install -y oracle-java8-installer

WORKDIR /tmp
RUN wget -c https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.2.0.deb
RUN pip3 install -U elasticsearch==5.1.0

RUN dpkg-deb -R elasticsearch-5.2.0.deb elasticFix
RUN sed -i elasticFix/DEBIAN/postinst -re '55,68d' 
RUN dpkg-deb -b elasticFix Elasticfixed.deb
RUN dpkg -i Elasticfixed.deb

WORKDIR /
RUN git clone https://github.com/codec-abc/elastiCOIN.git elasticcoin
WORKDIR elasticcoin
RUN git checkout dev

WORKDIR /tmp
RUN wget -c https://artifacts.elastic.co/downloads/kibana/kibana-5.2.0-amd64.deb
RUN dpkg -i kibana-5.2.0-amd64.deb
RUN sed -i 's|^#\?\(server.host:\).*|\1 "0.0.0.0"|g' /etc/kibana/kibana.yml

RUN echo "root:docker" | chpasswd

USER elasticsearch
WORKDIR /elasticcoin

EXPOSE 5601

# /usr/share/elasticsearch/bin/elasticsearch -Edefault.path.logs=/var/log/elasticsearch -Edefault.path.data=/var/lib/elasticsearch -Edefault.path.conf=/etc/elasticsearch > /dev/null 2>&1 &
# python3 elasticsearch/setup.py
# su root
# /usr/share/kibana/bin/kibana > /dev/null 2>&1 &

# docker build -t elasticcoin .
# docker run -p 5601:5601 -it elasticcoin