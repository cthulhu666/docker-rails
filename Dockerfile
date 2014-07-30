FROM cthulhu666/docker-rbenv
MAINTAINER jakub.gluszecki@gmail.com

RUN apt-get update && \
    apt-get install -y supervisor openssh-server pwgen

ADD config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD bin/ /usr/sbin/
RUN chmod 755 /usr/sbin/init.sh
RUN chmod 755 /usr/sbin/entrypoint.sh

RUN init.sh

EXPOSE 22 8080

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/bin/supervisord -c /etc/supervisor/supervisord.conf"]