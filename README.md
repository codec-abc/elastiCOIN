# elastiCOIN


## Requirements
* python 2.7
  https://docs.python.org/2/

* elasticsearch 2.3.3
  https://www.elastic.co/guide/en/elasticsearch/reference/2.3/index.html

* kibana 4.5.1
  https://www.elastic.co/guide/en/kibana/4.5/index.html

* elasticsearch-py==2.3.0
  http://elasticsearch-py.readthedocs.io/en/2.3.0/

* scrapy==1.1.0
  http://doc.scrapy.org/en/1.1/intro/install.html

* scrapyd==1.1.0
  http://scrapyd.readthedocs.io/en/1.1/

* scrapoxy
  http://docs.scrapoxy.io/en/master/

## Install
```
   curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
   apt-get update 
   apt-get install build-essential libxml2-dev libxslt-dev python-dev python-lxml nodejs

   wget -c https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.3/elasticsearch-2.3.3.deb 
   wget -c https://download.elastic.co/kibana/kibana/kibana_4.5.1_amd64.deb
   dpkg -i elasticsearch-2.3.3.deb kibana_4.5.1_amd64.deb
   pip install -U scrapy scrapyd scrapyd-client elasticsearch==2.3.0
   npm install -g scrapoxy
``` 


## Run
``` 
   cd scrapy/
   scrapy crawl lbc
```
Or 
``` 
   scrapy crawl lbc -a url=XXX
``` 
Where XXX is the starting url to crawl

## Run with scrapyd
Launch scrapyd
```
nohup scrapyd
```

First cd into scrapy project's root
```
   cd scrapy/
```
Deploy lbc scrapy project
```
   crapyd-deploy leboncoin -p leboncoin
```

Launch lbc scrapper
```
   curl -XPOST http://localhost:6800/schedule.json -d project=leboncoin -d spider=lbc  -d url=XXX
```

Hint: List available spiders
```
scrapy list
```
