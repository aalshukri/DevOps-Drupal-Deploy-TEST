#TRIAGE Dev Image
FROM lemp-dev-base:v2

#Label
LABEL version="0.2"

#nginx & php
RUN bash -c "mkdir /etc/nginx/ssl ; cd /etc/nginx/ssl/ ; openssl req -newkey rsa:4096 -nodes -keyout lemp-dev.key -x509 -days 1095 -out lemp-dev.crt -subj \"/C=UK/ST=London/L=London/O=OCTRU/OU=IT/CN=lemp-dev/emailAddress=dev@dev\""
COPY ./conf/nginx_default.conf /etc/nginx/sites-available/default
COPY ./conf/php_www.conf /etc/php/7.2/fpm/pool.d/www.conf
RUN echo "<?php phpinfo();?>" > /var/www/html/info.php

#mysql
#COPY ./conf/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
COPY ./conf/my.cnf /etc/mysql/my.cnf


#Copy setup scripts
COPY ./setup /setup


# Drupal drush install
RUN composer global require consolidation/cgr &&  \
    PATH="/root/.composer/vendor/bin:$PATH" && \    
    cgr drush/drush
# add to path so drush work from cmd
ENV PATH="/root/.composer/vendor/bin:${PATH}"


#Copy startup script
COPY ./conf/stack-startup.sh /usr/bin/stack-startup.sh
RUN chmod +x /usr/bin/stack-startup.sh



#Start nginx
CMD ["/usr/bin/stack-startup.sh"]

