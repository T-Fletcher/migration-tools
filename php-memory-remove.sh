#!/bin/sh
#
#   ///////////////////////////////
#  // Remove PHP's memory limit //
# ///////////////////////////////
#

# From https://stackoverflow.com/questions/54516509/php-memory-size-exhausted-in-docker-with-magento-bin-setupdicompile


echo 'memory_limit = -1' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini

#from the line below we setting memory to unlimited by using -1 (comment)
#Or you can set amount allocated by changing 'memory_limit = 512M' (comment)

# then check the memory with the following code (comment)
php -r "echo ini_get('memory_limit').PHP_EOL;"