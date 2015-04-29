#! /bin/bash

if [[ -e /firstrun ]]; then

	echo "Not first run so skipping initialization"

else 

	echo "setting the default installer info for magento"
	sed -i "s/<host>localhost/<host>${MYSQL_HOST}/g" /var/www/app/etc/config.xml
	sed -i "s/<username\/>/<username>user<\/username>/" /var/www/app/etc/config.xml
	sed -i "s/<password\/>/<password>password<\/password>/g" /var/www/app/etc/config.xml

	echo "Adding Magento Caching"

        echo "$MEMCACHED_HOST	cache" >> /etc/hosts
	sed -i -e  '/<\/config>/{ r /var/www/app/etc/mage-cache.xml' -e 'd}' /var/www/app/etc/local.xml.template

	touch /firstrun

fi

service php-fpm start

nginx 
