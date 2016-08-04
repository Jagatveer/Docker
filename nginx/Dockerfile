FROM centos:6.6

MAINTAINER Jagatveer Singh <jagatveer@hotmail.com>

ENV NGINX_VERSION 1.11.3
ENV OPENSSL_VERSION 1.0.2h
ENV PREFIX /usr/local/nginx

ENV config "\
          --without-mail_pop3_module \
          --user=nginx --group=nginx \
          --with-http_ssl_module \
          --with-openssl=/usr/src/openssl-1.0.2h \
          --without-mail_imap_module \
          --without-mail_smtp_module \
          --lock-path=/var/lock/nginx.lock \
          --pid-path=/var/run/nginx.pid \
          --with-http_stub_status_module \
          --with-pcre"

RUN \
          rpm -ivh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm \
          && yum clean all \
          && yum check \
          && yum upgrade -y \
          && yum install wget tar perl gcc make curl pcre-devel openssl openssl-devel -y

RUN \
          groupadd nginx \
          && id -u nginx &>/dev/null || useradd -s /sbin/nologin nginx -g nginx \
          && curl -fSL http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz -o nginx.tar.gz \
          && mkdir -p /usr/src \
          && tar -zxC /usr/src -f nginx.tar.gz \
          && curl -fSL https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz -o openssl.tar.gz \
          && tar -zxC /usr/src -f openssl.tar.gz \
          && rm nginx.tar.gz openssl.tar.gz \
          && cd /usr/src/nginx-$NGINX_VERSION \
          && ./configure $CONFIG \
        	&& make \
        	&& make install \
          && ln -s /usr/local/nginx/conf /etc/nginx \
          && ln -s /usr/local/nginx/logs /var/log/nginx \
          && mkdir -p /usr/local/nginx/conf/vhosts.d \
          && mkdir -p /usr/local/nginx/conf/upstream.d \
          && mkdir -p /usr/local/nginx/conf/disabled.d \
          && mkdir -p /usr/local/nginx/conf/proxies.d \
          && mkdir -p /var/www/html/error_pages

COPY conf/nginx.conf /usr/local/nginx/conf/nginx.conf
COPY conf/nginx /etc/init.d/nginx
COPY conf/index.html /var/www/html/index.html
COPY conf/500.html /var/www/html/error_pages/500.html
COPY conf/404.html /var/www/html/error_pages/404.html

RUN \
          chown -R nginx:nginx /var/www/html \
          && chmod 0755 /etc/init.d/nginx

EXPOSE 80 443
CMD service nginx start
