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

RUN apt-get install -y nano
# RUN dpkg -i elasticsearch-5.2.0.deb
# cat /var/lib/dpkg/info/elasticsearch.postinst
# rm /var/lib/dpkg/info/elasticsearch.postinst
# http://unix.stackexchange.com/questions/138188/easily-unpack-deb-edit-postinst-and-repack-deb

# WORKDIR /
# RUN git clone https://github.com/codec-abc/elastiCOIN.git elasticcoin
# RUN git checkout dev \
#     python3 elasticcoin/elasticsearch/setup.py

# EXPOSE 9200


# docker build -t elasticcoin .
# docker run -it elasticcoin