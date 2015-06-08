#!/bin/sh

MEMCACHED_HOSTS=$1

IFS=","
cat > /var/www/app/etc/mage-cache.xml << EOF
<cache>
  <backend>memcached</backend><!-- apc / memcached / empty=file -->
  <slow_backend>database</slow_backend>

  <memcached><!-- memcached cache backend related config -->
    <servers><!-- any number of server nodes can be included -->
EOF


for mem in $MEMCACHED_HOSTS; do
	echo "      <server>" >> /var/www/app/etc/mage-cache.xml
	echo "        <host><![CDATA[$mem]]></host>" >> /var/www/app/etc/mage-cache.xml
    echo "        <port><![CDATA[11211]]></port>" >> /var/www/app/etc/mage-cache.xml
    echo "        <persistent><![CDATA[1]]></persistent>" >> /var/www/app/etc/mage-cache.xml
    echo "      </server>" >> /var/www/app/etc/mage-cache.xml
done

cat >> /var/www/app/etc/mage-cache.xml << EOF
    </servers>
    <compression><![CDATA[0]]></compression>
    <cache_dir><![CDATA[]]></cache_dir>
    <hashed_directory_level><![CDATA[]]></hashed_directory_level>
    <hashed_directory_umask><![CDATA[]]></hashed_directory_umask>
    <file_name_prefix><![CDATA[]]></file_name_prefix>
  </memcached>
</cache>
</config>
EOF