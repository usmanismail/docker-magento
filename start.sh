#! /bin/bash


/generateMageCache.sh ${MEMCACHED_SERVICE}

sed -i "s/CRYPTO_KEY/${CRYPTO_KEY}/g" /var/www/app/etc/local.xml
sed -i "s/MYSQL_HOST/${MYSQL_HOST}/g" /var/www/app/etc/local.xml
sed -i "s/MYSQL_USER/${MYSQL_USER}/g" /var/www/app/etc/local.xml
sed -i "s/MYSQL_PASSWORD/${MYSQL_PASSWORD}/g" /var/www/app/etc/local.xml

service php-fpm start
nginx 
