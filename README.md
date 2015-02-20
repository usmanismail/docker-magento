## Magento docker image 

### Requirements
This docker image expects 2 other linked containers to work.

1. MySQL as 'db'

2. Memcached linked as 'cache'

### Starting this container


```
# Start MySQL
$ docker run -d --name mysql \
    -e MYSQL_ROOT_PASSWORD=${ROOT_PASSWORD} 
    -e MYSQL_USER=${MAGENTO_USER} -e MYSQL_PASSWORD=${MAGENTO_USER_PASSWORD} 
    -e MYSQL_DATABASE=magento 
    mysql
```

```
# Start Memcached
$ docker run --name memcache -d memcached
```

Then finally run our docker-magento container

```
docker run -d -p 80:80 -link mysql:db --link memcached:cache usmanismail/magento
```

Now visit your public IP in your browser and you will see the installer ready to go.. enter the database password when installer prompts.


### Builing the Image yourself.

```
git clone https://github.com/usmanismail/docker-magento.git .
docker build -t magento .
```

## LICENSE

Copyright 2015 Usman Ismail

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.    
