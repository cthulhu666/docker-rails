FROM cthulhu666/docker-rbenv
MAINTAINER jakub.gluszecki@gmail.com

RUN apt-get update && \
    apt-get install -y supervisor

ADD config /config

ADD bin /usr/sbin
RUN chmod 755 /usr/sbin/init.sh
RUN chmod 755 /usr/sbin/entrypoint.sh
RUN chmod 755 /usr/sbin/install-foreman.sh
RUN chmod 755 /usr/sbin/bundle-install.sh

RUN ["init.sh"]

EXPOSE 8080

ONBUILD ADD . /home/rails/rails-app
ONBUILD RUN chown -R rails:rails /home/rails/rails-app
ONBUILD RUN ["bundle-install.sh"]

RUN ["install-foreman.sh"]

VOLUME ["/home/rails/shared"]

ENTRYPOINT ["entrypoint.sh"]
CMD ["app:help"]