#!/bin/bash

#启动nginx和php
/etc/init.d/nginx restart
/etc/init.d/php-fpm restart

#启动rsync
rsync --daemon --config=/app/sdo/rsync/rsyncd.conf || exit 2

echo -e "\n\033[35m服务启动完成！ \n\033[0m"
