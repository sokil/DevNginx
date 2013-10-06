#!/bin/bash

#
# Repo checkouts
#

# Nginx
if [ ! -d "nginx" ]; then
    hg clone http://hg.nginx.org/nginx
fi

# Push Stream Module
if [ ! -d "nginx-push-stream-module" ]; then
    git clone https://github.com/wandenberg/nginx-push-stream-module
fi

# Upload Module (Switch to 2.2)
if [ ! -d "nginx-upload-module" ]; then
    git clone https://github.com/vkholodkov/nginx-upload-module
    cd nginx-upload-module
    git checkout 2.2
    cd ..
fi

# Upload progress Module (Switch to 0.8.4)
if [ ! -d "nginx-upload-progress-module" ]; then
    git clone https://github.com/masterzen/nginx-upload-progress-module
    cd nginx-upload-progress-module
    git checkout 82b35fc
    cd ..
fi

#
# Configure nginx
# 

cd nginx

./auto/configure \
    --prefix=/usr \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-client-body-temp-path=/var/lib/nginx/body \
    --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
    --http-log-path=/var/log/nginx/access.log \
    --http-proxy-temp-path=/var/lib/nginx/proxy \
    --http-scgi-temp-path=/var/lib/nginx/scgi \
    --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
    --lock-path=/var/lock/nginx.lock \
    --pid-path=/run/nginx.pid \
    --with-pcre \
    --with-pcre-jit \
    --with-debug \
    --with-http_addition_module \
    --with-http_dav_module \
    --with-http_gzip_static_module \
    --with-http_realip_module \
    --with-http_stub_status_module \
    --with-http_ssl_module \
    --with-http_sub_module \
    --with-ipv6 \
    --with-mail \
    --with-mail_ssl_module \
    --add-module=../nginx-push-stream-module \
    --add-module=../nginx-upload-module \
    --add-module=../nginx-upload-progress-module
    #--add-module=/build/buildd/nginx-1.4.1/debian/modules/nginx-auth-pam \
    #--add-module=/build/buildd/nginx-1.4.1/debian/modules/nginx-dav-ext-module \
    #--add-module=/build/buildd/nginx-1.4.1/debian/modules/nginx-echo \
    #--add-module=/build/buildd/nginx-1.4.1/debian/modules/nginx-upstream-fair \
    #--add-module=/build/buildd/nginx-1.4.1/debian/modules/ngx_http_substitutions_filter_module \
