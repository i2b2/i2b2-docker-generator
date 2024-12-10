# i2b2-ACT - postgres volume image
Below steps are intended to create postres volume image with i2b2 default ontology and act ontology. This scripts pulls i2b2-data repository from github.

## Pre-requisites 
Install below softwares
* docker
* docker-compose
* git
* unzip

## Upload data
In root directory, run below comamnd.
```
$ cd postgres/ 
$ ./install.sh
```

Note: above script will take time as per your machine's processing speed. To monitor the upload process, You can check logs using below command.
```
$ docker logs -f i2b2-pg
```
## wait for "completed the data load script message"

```
Execute the dockerimage.sh script
```
