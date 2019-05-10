@echo off
set php_home=./php5.6.21
set nginx_home=./nginx-1.10.0

REM Windows 下无效
REM set PHP_FCGI_CHILDREN=5

REM 每个进程处理的最大请求数，或设置为 Windows 环境变量
set PHP_FCGI_MAX_REQUESTS=1000

echo Starting PHP FastCGI...
RunHiddenConsole %php_home%/php-cgi.exe -b 127.0.0.1:9000 -c %php_home%/php.ini
 
echo Starting nginx...
RunHiddenConsole %nginx_home%/nginx.exe -p %nginx_home%
